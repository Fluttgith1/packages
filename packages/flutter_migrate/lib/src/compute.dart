// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'base/common.dart';
import 'base/file_system.dart';
import 'base/logger.dart';
import 'base/project.dart';
import 'custom_merge.dart';
import 'environment.dart';
import 'flutter_project_metadata.dart';
import 'migrate_logger.dart';
import 'result.dart';
import 'utils.dart';

// This defines paths of files and directories relative to the project root
// that should be skipped regardless of .gitignore and config settings.
// Paths use `/` as a stand-in for path separator.
const List<String> _skippedFiles = <String>[
  'ios/Runner.xcodeproj/project.pbxproj', // Xcode managed configs that may not merge cleanly.
  'README.md', // changes to this shouldn't be overwritten since is is user owned.
];

const List<String> _skippedDirectories = <String>[
  '.dart_tool', // The .dart_tool generated dir.
  '.git', // Git metadata.
  'assets', // Common directory for user assets.
  'build', // Build artifacts.
  'lib', // Always user owned and we don't want to overwrite their apps.
  'test', // Typically user owned and flutter-side changes are not relevant.
];

// Returns true for paths relative to the project root that should be skipped
// by the migrate tool.
bool _skipped(String localPath, FileSystem fileSystem,
    {Set<String>? skippedPrefixes}) {
  for (final String path in _skippedFiles) {
    if (path.replaceAll('/', fileSystem.path.separator) == localPath) {
      return true;
    }
  }
  if (_skippedFiles.contains(localPath)) {
    return true;
  }
  for (final String dir in _skippedDirectories) {
    if (localPath.startsWith(
        '${dir.replaceAll('/', fileSystem.path.separator)}${fileSystem.path.separator}')) {
      return true;
    }
  }
  if (skippedPrefixes != null) {
    return skippedPrefixes.any((String prefix) => localPath.startsWith('$prefix${fileSystem.path.separator}'));
  }
  return false;
}

const List<String> _skippedMergeFileExtensions = <String>[
  // Don't merge image files
  '.bmp',
  '.gif',
  '.jpg',
  '.jpeg',
  '.png',
  '.svg',
  // Don't merge compiled artifacts and executables
  '.dll',
  '.exe',
  '.jar',
  '.so',
];

const Set<String> _alwaysMigrateFiles = <String>{
  '.metadata', // .metadata tracks key migration information.
  'android/gradle/wrapper/gradle-wrapper.jar',
  // Always add .gitignore back in even if user-deleted as it makes it
  // difficult to migrate in the future and the migrate tool enforces git
  // usage.
  '.gitignore',
};

/// True for files that should not be merged. Typically, images and binary files.
bool _skippedMerge(String localPath) {
  for (final String ext in _skippedMergeFileExtensions) {
    if (localPath.endsWith(ext) && !_alwaysMigrateFiles.contains(localPath)) {
      return true;
    }
  }
  return false;
}

// Compile the set of path prefixes that should be ignored as configured
// in the command arguments.
Set<String> _getSkippedPrefixes(List<SupportedPlatform?> platforms) {
  final Set<String> skippedPrefixes = <String>{};
  for (final SupportedPlatform platform in SupportedPlatform.values) {
    skippedPrefixes.add(platformToSubdirectoryPrefix(platform));
  }
  for (final SupportedPlatform? platform in platforms) {
    if (platform != null) {
      skippedPrefixes.remove(platformToSubdirectoryPrefix(platform));
    }
  }
  skippedPrefixes.remove(null);
  return skippedPrefixes;
}

/// Data class holds the common context that is used throughout the steps of a migrate computation.
class MigrateContext {
  MigrateContext({
    required this.flutterProject,
    required this.skippedPrefixes,
    required this.logger,
    required this.verbose,
    required this.fileSystem,
    required this.migrateLogger,
    required this.migrateUtils,
    required this.environment,
    this.baseProject,
    this.targetProject,
  });

  final FlutterProject flutterProject;
  final Set<String> skippedPrefixes;
  final Logger logger;
  final bool verbose;
  final FileSystem fileSystem;
  final MigrateLogger migrateLogger;
  final MigrateUtils migrateUtils;
  final FlutterToolsEnvironment environment;

  MigrateBaseFlutterProject? baseProject;
  MigrateTargetFlutterProject? targetProject;
}

String getLocalPath(String path, String basePath, FileSystem fileSystem) {
  return path.replaceFirst(basePath + fileSystem.path.separator, '');
}

String platformToSubdirectoryPrefix(SupportedPlatform platform) {
  switch (platform) {
    case SupportedPlatform.android:
      return 'android';
    case SupportedPlatform.ios:
      return 'ios';
    case SupportedPlatform.linux:
      return 'linux';
    case SupportedPlatform.macos:
      return 'macos';
    case SupportedPlatform.web:
      return 'web';
    case SupportedPlatform.windows:
      return 'windows';
    case SupportedPlatform.fuchsia:
      return 'fuchsia';
  }
}

class MigrateCommandParameters {
  MigrateCommandParameters({
    this.baseAppPath,
    this.targetAppPath,
    this.baseRevision,
    this.targetRevision,
    this.preferTwoWayMerge = false,
    this.verbose = false,
    this.allowFallbackBaseRevision = false,
    this.deleteTempDirectories = true,
    this.platforms,
  });
  final String? baseAppPath;
  final String? targetAppPath;
  final String? baseRevision;
  final String? targetRevision;
  final bool preferTwoWayMerge;
  final bool verbose;
  final bool allowFallbackBaseRevision;
  final bool deleteTempDirectories;
  final List<SupportedPlatform?>? platforms;
}

/// Computes the changes that migrates the current flutter project to the target revision.
///
/// This is the entry point to the core migration computations.
///
/// This method attempts to find a base revision, which is the revision of the Flutter SDK
/// the app was generated with or the last revision the app was migrated to. The base revision
/// typically comes from the .metadata, but for legacy apps, the config may not exist. In
/// this case, we fallback to using the revision in .metadata, and if that does not exist, we
/// use the target revision as the base revision. In the final fallback case, the migration should
/// still work, but will likely generate slightly less accurate merges.
///
/// Operations the computation performs:
///
///  - Parse .metadata file
///  - Collect revisions to use for each platform
///  - Download each flutter revision and call `flutter create` for each.
///  - Call `flutter create` with target revision (target is typically current flutter version)
///  - Diff base revision generated app with target revision generated app
///  - Compute all newly added files between base and target revisions
///  - Compute merge of all files that are modified by user and flutter
///  - Track temp dirs to be deleted
///
/// Structure: This method builds upon a MigrateResult instance
Future<MigrateResult?> computeMigration({
  FlutterProject? flutterProject,
  required MigrateCommandParameters commandParameters,
  required FileSystem fileSystem,
  required Logger logger,
  required MigrateUtils migrateUtils,
  required FlutterToolsEnvironment environment,
}) async {
  flutterProject ??= FlutterProject.current(fileSystem);

  final MigrateLogger migrateLogger = MigrateLogger(logger: logger);
  migrateLogger.logStep('start');
  // Find the path prefixes to ignore. This allows subdirectories of platforms
  // not part of the migration to be skipped.
  final List<SupportedPlatform?> platforms = commandParameters.platforms ?? flutterProject.getSupportedPlatforms();
  final Set<String> skippedPrefixes = _getSkippedPrefixes(platforms);

  final MigrateResult result = MigrateResult.empty();
  final MigrateContext context = MigrateContext(
    flutterProject: flutterProject,
    skippedPrefixes: skippedPrefixes,
    logger: logger,
    verbose: commandParameters.verbose,
    migrateLogger: migrateLogger,
    fileSystem: fileSystem,
    migrateUtils: migrateUtils,
    environment: environment,
  );

  migrateLogger.logStep('revisions');
  final MigrateRevisions revisionConfig = MigrateRevisions(
    context: context,
    baseRevision: commandParameters.baseRevision,
    allowFallbackBaseRevision: commandParameters.allowFallbackBaseRevision,
    platforms: platforms,
    environment: environment,
  );

  // Extract the unamanged files/paths that should be ignored by the migrate tool.
  // These paths are absolute paths.
  if (commandParameters.verbose) {
    migrateLogger.logStep('unmanaged');
  }
  final List<String> unmanagedFiles = <String>[];
  final List<String> unmanagedDirectories = <String>[];
  final String basePath = flutterProject.directory.path;
  for (final String localPath in revisionConfig.config.unmanagedFiles) {
    if (localPath.endsWith(fileSystem.path.separator)) {
      unmanagedDirectories.add(fileSystem.path.join(basePath, localPath));
    } else {
      unmanagedFiles.add(fileSystem.path.join(basePath, localPath));
    }
  }

  migrateLogger.logStep('generating_base');
  // Generate the base templates
  final ReferenceProjects referenceProjects = await _generateBaseAndTargetReferenceProjects(
    context: context,
    result: result,
    revisionConfig: revisionConfig,
    platforms: platforms,
    commandParameters: commandParameters,
  );
  result.generatedBaseTemplateDirectory = referenceProjects.baseProject.directory;
  result.generatedTargetTemplateDirectory = referenceProjects.targetProject.directory;

  // Generate diffs. These diffs are used to determine if a file is newly added, needs merging,
  // or deleted (rare). Only files with diffs between the base and target revisions need to be
  // migrated. If files are unchanged between base and target, then there are no changes to merge.
  migrateLogger.logStep('diff');
  result.diffMap
      .addAll(await referenceProjects.baseProject.diff(context, referenceProjects.targetProject));

  // Check for any new files that were added in the target reference app that did not
  // exist in the base reference app.
  migrateLogger.logStep('new_files');
  result.addedFiles
      .addAll(await referenceProjects.baseProject.newlyAddedFiles(context, result, referenceProjects.targetProject));

  // Merge any base->target changed files with the version in the developer's project.
  // Files that the developer left unchanged are fully updated to match the target reference.
  // Files that the developer changed and were changed from base->target are merged.
  migrateLogger.logStep('merging');
  await MigrateFlutterProject.merge(
    context,
    result,
    referenceProjects.baseProject,
    referenceProjects.targetProject,
    unmanagedFiles,
    unmanagedDirectories,
    commandParameters.preferTwoWayMerge,
  );

  // Clean up any temp directories generated by this tool.
  migrateLogger.logStep('cleaning');
  _registerTempDirectoriesForCleaning(
    commandParameters: commandParameters,
    result: result,
    referenceProjects: referenceProjects
  );
  migrateLogger.stop();
  return result;
}

/// Returns a base revision to fallback to in case a true base revision is unknown.
String _getFallbackBaseRevision(bool allowFallbackBaseRevision, bool verbose,
    MigrateLogger migrateLogger) {
  if (!allowFallbackBaseRevision) {
    migrateLogger.stop();
    migrateLogger.printError(
        'Could not determine base revision this app was created with:');
    migrateLogger.printError(
        '.metadata file did not exist or did not contain a valid revision.',
        indent: 2);
    migrateLogger.printError(
        'Run this command again with the `--allow-fallback-base-revision` flag to use Flutter v1.0.0 as the base revision or manually pass a revision with `--base-revision=<revision>`',
        indent: 2);
    throwToolExit('Failed to resolve base revision');
  }
  // Earliest version of flutter with .metadata: c17099f474675d8066fec6984c242d8b409ae985 (2017)
  // Flutter 2.0.0: 60bd88df915880d23877bfc1602e8ddcf4c4dd2a
  // Flutter v1.0.0: 5391447fae6209bb21a89e6a5a6583cac1af9b4b
  //
  // TODO(garyq): Use things like dart sdk version and other hints to better fine-tune this fallback.
  //
  // We fall back on flutter v1.0.0 if .metadata doesn't exist.
  if (verbose) {
    migrateLogger.logStep('fallback');
  }
  return '5391447fae6209bb21a89e6a5a6583cac1af9b4b';
}

class ReferenceProjects {
  ReferenceProjects({
    required this.baseProject,
    required this.targetProject,
    required this.customBaseProjectDir,
    required this.customTargetProjectDir,
  });

  MigrateBaseFlutterProject baseProject;
  MigrateTargetFlutterProject targetProject;

  // Whether a user provided base and target projects were provided.
  bool customBaseProjectDir;
  bool customTargetProjectDir;
}

// Generate the base templates
Future<ReferenceProjects> _generateBaseAndTargetReferenceProjects({
  required MigrateContext context,
  required MigrateResult result,
  required MigrateRevisions revisionConfig,
  required List<SupportedPlatform?> platforms,
  required MigrateCommandParameters commandParameters,
}) async {
  // Use user-provided projects if provided, if not, generate them internally.
  final bool customBaseProjectDir = commandParameters.baseAppPath != null;
  final bool customTargetProjectDir = commandParameters.targetAppPath != null;
  Directory? baseProjectDir;
  Directory? targetProjectDir;
  if (customBaseProjectDir) {
    baseProjectDir = context.fileSystem.directory(commandParameters.baseAppPath);
  } else {
    baseProjectDir =
        context.fileSystem.systemTempDirectory.createTempSync('baseProject');
    if (context.verbose) {
      context.migrateLogger.printStatus('Created temporary directory: ${baseProjectDir.path}');
    }
  }
  if (customTargetProjectDir) {
    targetProjectDir = context.fileSystem.directory(commandParameters.targetAppPath);
  } else {
    targetProjectDir =
        context.fileSystem.systemTempDirectory.createTempSync('targetProject');
    if (context.verbose) {
      context.migrateLogger.printStatus(
          'Created temporary directory: ${targetProjectDir.path}');
    }
  }

  // Git init to enable running further git commands on the reference projects.
  await context.migrateUtils.gitInit(
      baseProjectDir.absolute.path);
  await context.migrateUtils.gitInit(
      targetProjectDir.absolute.path);

  final String name = context.environment['FlutterProject.manifest.appname']! as String;
  final String androidLanguage =
      context.environment['FlutterProject.android.isKotlin']! as bool
          ? 'kotlin'
          : 'java';
  final String iosLanguage =
      context.environment['FlutterProject.ios.isSwift']! as bool ? 'swift' : 'objc';

  final Directory targetFlutterDirectory =
      context.fileSystem.directory(context.environment.getString('Cache.flutterRoot'));

  // Create the base reference vanilla app.
  //
  // This step clones the base flutter sdk, and uses it to create a new vanilla app.
  // The vanilla base app is used as part of a 3 way merge between the base app, target
  // app, and the current user-owned app.
  final MigrateBaseFlutterProject baseProject = MigrateBaseFlutterProject(
    path: commandParameters.baseAppPath,
    directory: baseProjectDir,
    name: name,
    androidLanguage: androidLanguage,
    iosLanguage: iosLanguage,
    platformWhitelist: platforms,
  );
  context.baseProject = baseProject;
  await baseProject.createProject(
    context,
    result,
    revisionConfig.revisionsList,
    revisionConfig.revisionToConfigs,
    commandParameters.baseRevision ??
        revisionConfig.metadataRevision ??
        _getFallbackBaseRevision(
            commandParameters.allowFallbackBaseRevision, commandParameters.verbose, context.migrateLogger),
    revisionConfig.targetRevision,
    targetFlutterDirectory,
  );

  // Create target reference app when not provided.
  //
  // This step directly calls flutter create with the target (the current installed revision)
  // flutter sdk.
  final MigrateTargetFlutterProject targetProject = MigrateTargetFlutterProject(
    path: commandParameters.targetAppPath,
    directory: targetProjectDir,
    name: name,
    androidLanguage: androidLanguage,
    iosLanguage: iosLanguage,
    platformWhitelist: platforms,
  );
  context.targetProject = targetProject;
  await targetProject.createProject(
    context,
    result,
    revisionConfig.targetRevision,
    targetFlutterDirectory,
  );

  return ReferenceProjects(
    baseProject: baseProject,
    targetProject: targetProject,
    customBaseProjectDir: customBaseProjectDir,
    customTargetProjectDir: customTargetProjectDir,
  );
}

void _registerTempDirectoriesForCleaning({
  required MigrateCommandParameters commandParameters,
  required MigrateResult result,
  required ReferenceProjects referenceProjects,
}) {
  if (commandParameters.deleteTempDirectories) {
    // Don't delete user-provided directories
    if (!referenceProjects.customBaseProjectDir) {
      result.tempDirectories
          .add(result.generatedBaseTemplateDirectory!);
    }
    if (!referenceProjects.customTargetProjectDir) {
      result.tempDirectories
          .add(result.generatedTargetTemplateDirectory!);
    }
    result.tempDirectories
        .addAll(result.sdkDirs.values);
  }
}

/// A reference flutter project.
///
/// A MigrateFlutterProject is a project that is generated internally within the tool
/// to see what changes need to be made to the user's project. This class
/// provides methods to merge, diff, and otherwise compare multiple MigrateFlutterProject
/// instances.
abstract class MigrateFlutterProject {
  MigrateFlutterProject({
    required this.path,
    required this.directory,
    required this.name,
    required this.androidLanguage,
    required this.iosLanguage,
    this.platformWhitelist,
  });

  final String? path;
  final Directory directory;
  final String name;
  final String androidLanguage;
  final String iosLanguage;
  final List<SupportedPlatform?>? platformWhitelist;

  /// Run git diff over each matching pair of files in the this project and the provided target project.
  Future<Map<String, DiffResult>> diff(
    MigrateContext context,
    MigrateFlutterProject other,
  ) async {
    final Map<String, DiffResult> diffMap = <String, DiffResult>{};
    final List<FileSystemEntity> thisFiles =
        directory.listSync(recursive: true);
    int modifiedFilesCount = 0;
    for (final FileSystemEntity entity in thisFiles) {
      if (entity is! File) {
        continue;
      }
      final File thisFile = entity.absolute;
      final String localPath = getLocalPath(
          thisFile.path, directory.absolute.path, context.fileSystem);
      if (_skipped(localPath, context.fileSystem,
          skippedPrefixes: context.skippedPrefixes)) {
        continue;
      }
      if (await context.migrateUtils
          .isGitIgnored(thisFile.absolute.path, directory.absolute.path)) {
        diffMap[localPath] = DiffResult(diffType: DiffType.ignored);
      }
      final File otherFile = other.directory.childFile(localPath);
      if (otherFile.existsSync()) {
        final DiffResult diff =
            await context.migrateUtils.diffFiles(thisFile, otherFile);
        diffMap[localPath] = diff;
        if (context.verbose && diff.diff != '') {
          context.migrateLogger.printStatus(
              'Found ${diff.exitCode} changes in $localPath',
              indent: 4);
          modifiedFilesCount++;
        }
      } else {
        // Current file has no new template counterpart, which is equivalent to a deletion.
        // This could also indicate a renaming if there is an addition with equivalent contents.
        diffMap[localPath] = DiffResult(diffType: DiffType.deletion);
      }
    }
    if (context.verbose) {
      context.migrateLogger.printStatus(
          '$modifiedFilesCount files were modified between base and target apps.');
    }
    return diffMap;
  }

  /// Find all files that exist in the target reference app but not in the base reference app.
  Future<List<FilePendingMigration>> newlyAddedFiles(
      MigrateContext context,
      MigrateResult result, 
      MigrateFlutterProject other,
    ) async {
    final List<FilePendingMigration> addedFiles = <FilePendingMigration>[];
    final List<FileSystemEntity> otherFiles =
        other.directory.listSync(recursive: true);
    for (final FileSystemEntity entity in otherFiles) {
      if (entity is! File) {
        continue;
      }
      final File otherFile = entity.absolute;
      final String localPath = getLocalPath(
          otherFile.path, other.directory.absolute.path, context.fileSystem);
      if (directory.childFile(localPath).existsSync() ||
          _skipped(localPath, context.fileSystem,
              skippedPrefixes: context.skippedPrefixes)) {
        continue;
      }
      if (await context.migrateUtils.isGitIgnored(
          otherFile.absolute.path, other.directory.absolute.path)) {
        result.diffMap[localPath] =
            DiffResult(diffType: DiffType.ignored);
      }
      result.diffMap[localPath] =
          DiffResult(diffType: DiffType.addition);
      if (context.flutterProject.directory.childFile(localPath).existsSync()) {
        // Don't store as added file if file already exists in the project.
        continue;
      }
      addedFiles.add(FilePendingMigration(localPath, otherFile));
    }
    if (context.verbose) {
      context.migrateLogger.printStatus(
          '${addedFiles.length} files were newly added in the target app.');
    }
    return addedFiles;
  }

  /// Loops through each existing file and intelligently merges it with the base->target changes.
  static Future<void> merge(
    MigrateContext context,
    MigrateResult result,
    MigrateFlutterProject baseProject,
    MigrateFlutterProject targetProject,
    List<String> unmanagedFiles,
    List<String> unmanagedDirectories,
    bool preferTwoWayMerge,
  ) async {
    final List<CustomMerge> customMerges = <CustomMerge>[
      MetadataCustomMerge(logger: context.logger),
    ];
    // For each existing file in the project, we attempt to 3 way merge if it is changed by the user.
    final List<FileSystemEntity> currentFiles =
        context.flutterProject.directory.listSync(recursive: true);
    final String projectRootPath =
        context.flutterProject.directory.absolute.path;
    final Set<String> missingAlwaysMigrateFiles =
        Set<String>.of(_alwaysMigrateFiles);
    for (final FileSystemEntity entity in currentFiles) {
      if (entity is! File) {
        continue;
      }
      // check if the file is unmanaged/ignored by the migration tool.
      bool ignored = false;
      ignored = unmanagedFiles.contains(entity.absolute.path);
      for (final String path in unmanagedDirectories) {
        if (entity.absolute.path.startsWith(path)) {
          ignored = true;
          break;
        }
      }
      if (ignored) {
        continue; // Skip if marked as unmanaged
      }

      final File currentFile = entity.absolute;
      // Diff the current file against the old generated template
      final String localPath =
          getLocalPath(currentFile.path, projectRootPath, context.fileSystem);
      missingAlwaysMigrateFiles.remove(localPath);
      if (result.diffMap.containsKey(localPath) &&
              result.diffMap[localPath]!.diffType ==
                  DiffType.ignored ||
          await context.migrateUtils.isGitIgnored(currentFile.path,
              context.flutterProject.directory.absolute.path) ||
          _skipped(localPath, context.fileSystem,
              skippedPrefixes: context.skippedPrefixes) ||
          _skippedMerge(localPath)) {
        continue;
      }
      final File baseTemplateFile = baseProject.directory.childFile(localPath);
      final File targetTemplateFile =
          targetProject.directory.childFile(localPath);
      final DiffResult userDiff =
          await context.migrateUtils.diffFiles(currentFile, baseTemplateFile);
      final DiffResult targetDiff =
          await context.migrateUtils.diffFiles(currentFile, targetTemplateFile);
      if (targetDiff.exitCode == 0) {
        // current file is already the same as the target file.
        continue;
      }

      final bool alwaysMigrate = _alwaysMigrateFiles.contains(localPath);

      // Current file unchanged by user, thus we consider it owned by the tool.
      if (userDiff.exitCode == 0 || alwaysMigrate) {
        if ((result.diffMap.containsKey(localPath) ||
                alwaysMigrate) &&
            result.diffMap[localPath] != null) {
          // File changed between base and target
          if (result.diffMap[localPath]!.diffType ==
              DiffType.deletion) {
            // File is deleted in new template
            result.deletedFiles
                .add(FilePendingMigration(localPath, currentFile));
            continue;
          }
          if (result.diffMap[localPath]!.exitCode != 0 ||
              alwaysMigrate) {
            // Accept the target version wholesale
            MergeResult mergeResult;
            try {
              mergeResult = StringMergeResult.explicit(
                mergedString: targetTemplateFile.readAsStringSync(),
                hasConflict: false,
                exitCode: 0,
                localPath: localPath,
              );
            } on FileSystemException {
              mergeResult = BinaryMergeResult.explicit(
                mergedBytes: targetTemplateFile.readAsBytesSync(),
                hasConflict: false,
                exitCode: 0,
                localPath: localPath,
              );
            }
            result.mergeResults.add(mergeResult);
            continue;
          }
        }
        continue;
      }

      // File changed by user
      if (result.diffMap.containsKey(localPath)) {
        MergeResult? mergeResult;
        // Default to two way merge as it does not require the base file to exist.
        MergeType mergeType =
            result.mergeTypeMap[localPath] ?? MergeType.twoWay;
        for (final CustomMerge customMerge in customMerges) {
          if (customMerge.localPath == localPath) {
            mergeResult = customMerge.merge(
                currentFile, baseTemplateFile, targetTemplateFile);
            mergeType = MergeType.custom;
            break;
          }
        }
        if (mergeResult == null) {
          late String basePath;
          late String currentPath;
          late String targetPath;

          // Use two way merge if diff between base and target are the same.
          // This prevents the three way merge re-deleting the base->target changes.
          if (preferTwoWayMerge) {
            mergeType = MergeType.twoWay;
          }
          switch (mergeType) {
            case MergeType.twoWay:
              {
                basePath = currentFile.path;
                currentPath = currentFile.path;
                targetPath = context.fileSystem.path.join(
                    result.generatedTargetTemplateDirectory!.path,
                    localPath);
                break;
              }
            case MergeType.threeWay:
              {
                basePath = context.fileSystem.path.join(
                    result.generatedBaseTemplateDirectory!.path,
                    localPath);
                currentPath = currentFile.path;
                targetPath = context.fileSystem.path.join(
                    result.generatedTargetTemplateDirectory!.path,
                    localPath);
                break;
              }
            case MergeType.custom:
              {
                break; // handled above
              }
          }
          if (mergeType != MergeType.custom) {
            mergeResult = await context.migrateUtils.gitMergeFile(
              base: basePath,
              current: currentPath,
              target: targetPath,
              localPath: localPath,
            );
          }
        }
        if (mergeResult != null) {
          // Don't include if result is identical to the current file.
          if (mergeResult is StringMergeResult) {
            if (mergeResult.mergedString == currentFile.readAsStringSync()) {
              context.migrateLogger
                  .printStatus('$localPath was merged with a $mergeType.');
              continue;
            }
          } else {
            if ((mergeResult as BinaryMergeResult).mergedBytes ==
                currentFile.readAsBytesSync()) {
              continue;
            }
          }
          result.mergeResults.add(mergeResult);
        }
        if (context.verbose) {
          context.migrateLogger
              .printStatus('$localPath was merged with a $mergeType.');
        }
        continue;
      }
    }

    // Add files that are in the target, marked as always migrate, and missing in the current project.
    for (final String localPath in missingAlwaysMigrateFiles) {
      final File targetTemplateFile = result.generatedTargetTemplateDirectory!
          .childFile(localPath);
      if (targetTemplateFile.existsSync() &&
          !_skipped(localPath, context.fileSystem,
              skippedPrefixes: context.skippedPrefixes)) {
        result.addedFiles
            .add(FilePendingMigration(localPath, targetTemplateFile));
      }
    }
  }
}

/// The base reference project used in a migration computation.
///
/// This project is a clean re-generation of the version the user's project
/// was 1. originally generated with, or 2. the last successful migrated to.
class MigrateBaseFlutterProject extends MigrateFlutterProject {
  MigrateBaseFlutterProject({
    required super.path,
    required super.directory,
    required super.name,
    required super.androidLanguage,
    required super.iosLanguage,
    super.platformWhitelist,
  });

  /// Creates the base reference app based off of the migrate config in the .metadata file.
  Future<void> createProject(
    MigrateContext context,
    MigrateResult result,
    List<String> revisionsList,
    Map<String, List<MigratePlatformConfig>> revisionToConfigs,
    String fallbackRevision,
    String targetRevision,
    Directory targetFlutterDirectory,
  ) async {
    // Create base
    // Clone base flutter
    if (path == null) {
      final Map<String, Directory> revisionToFlutterSdkDir =
          <String, Directory>{};
      for (final String revision in revisionsList) {
        final List<String> platforms = <String>[];
        for (final MigratePlatformConfig config
            in revisionToConfigs[revision]!) {
          platforms.add(config.platform.toString().split('.').last);
        }
        platforms.remove(
            'root'); // Root does not need to be listed and is not a valid platform

        // In the case of the revision being invalid or not a hash of the master branch,
        // we want to fallback in the following order:
        //   - parsed revision
        //   - fallback revision
        //   - target revision (currently installed flutter)
        late Directory sdkDir;
        final List<String> revisionsToTry = <String>[revision];
        if (revision != fallbackRevision) {
          revisionsToTry.add(fallbackRevision);
        }
        bool sdkAvailable = false;
        int index = 0;
        do {
          if (index < revisionsToTry.length) {
            final String activeRevision = revisionsToTry[index++];
            if (activeRevision != revision &&
                revisionToFlutterSdkDir.containsKey(activeRevision)) {
              sdkDir = revisionToFlutterSdkDir[activeRevision]!;
              revisionToFlutterSdkDir[revision] = sdkDir;
              sdkAvailable = true;
            } else {
              sdkDir = context.fileSystem.systemTempDirectory
                  .createTempSync('flutter_$activeRevision');
              result.sdkDirs[activeRevision] = sdkDir;
              context.migrateLogger.printStatus('Cloning SDK $activeRevision');
              sdkAvailable = await context.migrateUtils
                  .cloneFlutter(activeRevision, sdkDir.absolute.path);
              revisionToFlutterSdkDir[revision] = sdkDir;
            }
          } else {
            // fallback to just using the modern target version of flutter.
            sdkDir = targetFlutterDirectory;
            revisionToFlutterSdkDir[revision] = sdkDir;
            sdkAvailable = true;
          }
        } while (!sdkAvailable);
        context.migrateLogger.printStatus(
            'Creating base app for $platforms with revision $revision.');
        final String newDirectoryPath =
            await context.migrateUtils.createFromTemplates(
          sdkDir.childDirectory('bin').absolute.path,
          name: name,
          androidLanguage: androidLanguage,
          iosLanguage: iosLanguage,
          outputDirectory: result.generatedBaseTemplateDirectory!.absolute.path,
          platforms: platforms,
        );
        if (newDirectoryPath !=
            result.generatedBaseTemplateDirectory?.path) {
          result.generatedBaseTemplateDirectory =
              context.fileSystem.directory(newDirectoryPath);
        }
        // Determine merge type for each newly generated file.
        final List<FileSystemEntity> generatedBaseFiles =
          result.generatedBaseTemplateDirectory!
            .listSync(recursive: true);
        for (final FileSystemEntity entity in generatedBaseFiles) {
          if (entity is! File) {
            continue;
          }
          final File baseTemplateFile = entity.absolute;
          final String localPath = getLocalPath(
              baseTemplateFile.path,
              result.generatedBaseTemplateDirectory!.absolute.path,
              context.fileSystem);
          if (!result.mergeTypeMap.containsKey(localPath)) {
            // Use two way merge when the base revision is the same as the target revision.
            result.mergeTypeMap[localPath] =
                revision == targetRevision
                    ? MergeType.twoWay
                    : MergeType.threeWay;
          }
        }
        if (newDirectoryPath !=
            result.generatedBaseTemplateDirectory?.path) {
          result.generatedBaseTemplateDirectory =
              context.fileSystem.directory(newDirectoryPath);
          break; // The create command is old and does not distinguish between platforms so it only needs to be called once.
        }
      }
    }
  }
}

/// Represents a manifested flutter project that is the migration target.
///
/// The files in this project are the version the migrate tool will try
/// to transform the existing files into.
class MigrateTargetFlutterProject extends MigrateFlutterProject {
  MigrateTargetFlutterProject({
    required super.path,
    required super.directory,
    required super.name,
    required super.androidLanguage,
    required super.iosLanguage,
    super.platformWhitelist,
  });

  /// Creates the base reference app based off of the migrate config in the .metadata file.
  Future<void> createProject(
    MigrateContext context,
    MigrateResult result,
    String targetRevision,
    Directory targetFlutterDirectory,
  ) async {
    if (path == null) {
      // Create target
      context.migrateLogger.printStatus(
          'Creating target app with revision $targetRevision.');
      if (context.verbose) {
        context.logger.printStatus('Creating target app.');
      }
      await context.migrateUtils.createFromTemplates(
        targetFlutterDirectory.childDirectory('bin').absolute.path,
        name: name,
        androidLanguage: androidLanguage,
        iosLanguage: iosLanguage,
        outputDirectory: result.generatedTargetTemplateDirectory!.absolute.path,
      );
    }
  }
}

/// Parses the metadata of the flutter project, extracts, computes, and stores the
/// revisions that the migration should use to migrate between.
class MigrateRevisions {
  MigrateRevisions({
    required MigrateContext context,
    required String? baseRevision,
    required bool allowFallbackBaseRevision,
    required List<SupportedPlatform?> platforms,
    required FlutterToolsEnvironment environment,
  }) {
    _computeRevisions(context, baseRevision, allowFallbackBaseRevision,
        platforms, environment);
  }

  late List<String> revisionsList;
  late Map<String, List<MigratePlatformConfig>> revisionToConfigs;
  late String fallbackRevision;
  late String targetRevision;
  late String? metadataRevision;
  late MigrateConfig config;

  void _computeRevisions(
    MigrateContext context,
    String? baseRevision,
    bool allowFallbackBaseRevision,
    List<SupportedPlatform?> platforms,
    FlutterToolsEnvironment environment,
  ) {
    final FlutterProjectMetadata metadata = FlutterProjectMetadata(
        context.flutterProject.directory.childFile('.metadata'),
        context.logger);
    config = metadata.migrateConfig;

    // We call populate in case MigrateConfig is empty. If it is filled, populate should not do anything.
    config.populate(
      projectDirectory: context.flutterProject.directory,
      update: false,
      logger: context.logger,
    );

    metadataRevision = metadata.versionRevision;
    if (environment.getString('FlutterVersion.frameworkRevision') == null) {
      throwToolExit('Flutter framework revision was null');
    }
    targetRevision = environment.getString('FlutterVersion.frameworkRevision')!;
    String rootBaseRevision = '';
    revisionToConfigs = <String, List<MigratePlatformConfig>>{};
    final Set<String> revisions = <String>{};
    if (baseRevision == null) {
      for (final MigratePlatformConfig platform
          in config.platformConfigs.values) {
        final String effectiveRevision = platform.baseRevision == null
            ? metadataRevision ??
                _getFallbackBaseRevision(allowFallbackBaseRevision,
                    context.verbose, context.migrateLogger)
            : platform.baseRevision!;
        if (platforms != null && !platforms.contains(platform.platform)) {
          continue;
        }
        if (platform.platform == null) {
          rootBaseRevision = effectiveRevision;
        }
        revisions.add(effectiveRevision);
        if (revisionToConfigs[effectiveRevision] == null) {
          revisionToConfigs[effectiveRevision] = <MigratePlatformConfig>[];
        }
        revisionToConfigs[effectiveRevision]!.add(platform);
      }
    } else {
      rootBaseRevision = baseRevision;
      revisionToConfigs[baseRevision] = <MigratePlatformConfig>[];
      for (final SupportedPlatform? platform in platforms) {
        revisionToConfigs[baseRevision]!.add(MigratePlatformConfig(
            platform: platform, baseRevision: baseRevision));
      }
      revisionToConfigs[baseRevision]!.add(MigratePlatformConfig(
            platform: null, baseRevision: baseRevision));
    }
    // Reorder such that the root revision is created first.
    revisions.remove(rootBaseRevision);
    revisionsList = List<String>.from(revisions);
    if (rootBaseRevision != '') {
      revisionsList.insert(0, rootBaseRevision);
    }
    if (context.verbose) {
      context.logger.printStatus('Potential base revisions: $revisionsList');
    }
    fallbackRevision = _getFallbackBaseRevision(
        true, context.verbose, context.migrateLogger);
    if (revisionsList.contains(fallbackRevision) &&
        baseRevision != fallbackRevision &&
        metadataRevision != fallbackRevision) {
      context.migrateLogger.printStatus(
          'Using Flutter v1.0.0 ($fallbackRevision) as the base revision since a valid base revision could not be found in the .metadata file. This may result in more merge conflicts than normally expected.',
          indent: 4);
    }
  }
}
