// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'base/file_system.dart';
import 'base/logger.dart';
import 'base/project.dart';
import 'base/terminal.dart';

import 'utils.dart';

/// Checks if the project uses pubspec dependency locking and prompts if
/// the pub upgrade should be run.
Future<void> updatePubspecDependencies(FlutterProject flutterProject,
    MigrateUtils migrateUtils, Logger logger, Terminal terminal,
    {bool force = false}) async {
  final File pubspecFile = flutterProject.directory.childFile('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    return;
  }
  if (!pubspecFile
      .readAsStringSync()
      .contains('# THIS LINE IS AUTOGENERATED')) {
    return;
  }
  logger.printStatus('\nDart dependency locking detected in pubspec.yaml.');
  terminal.usesTerminalUi = true;
  String selection = 'y';
  if (!force) {
    selection = await terminal.promptForCharInput(
      <String>['y', 'n'],
      logger: logger,
      prompt:
          'Do you want the tool to run `flutter pub upgrade --major-versions`? (y)es, (n)o',
      defaultChoiceIndex: 1,
    );
  }
  if (selection == 'y') {
    // Runs `flutter pub upgrade --major-versions`
    await migrateUtils.flutterPubUpgrade(flutterProject.directory.path);
  }
}

/// Checks if gradle dependency locking is used and prompts the developer to
/// remove and back up the gradle dependency lockfile.
Future<void> updateGradleDependencyLocking(
  FlutterProject flutterProject,
  MigrateUtils migrateUtils,
  Logger logger,
  Terminal terminal,
  bool verbose,
  FileSystem fileSystem, {
  bool force = false,
}) async {
  final Directory androidDir =
      flutterProject.directory.childDirectory('android');
  if (!androidDir.existsSync()) {
    return;
  }
  final List<FileSystemEntity> androidFiles = androidDir.listSync();
  final List<File> lockfiles = <File>[];
  final List<String> backedUpFilePaths = <String>[];
  for (final FileSystemEntity entity in androidFiles) {
    if (entity is! File) {
      continue;
    }
    final File file = entity.absolute;
    // Don't re-handle backed up lockfiles.
    if (file.path.contains('_backup_')) {
      continue;
    }
    try {
      // lockfiles generated by gradle start with this prefix.
      if (file.readAsStringSync().startsWith(
          '# This is a Gradle generated file for dependency locking.\n# '
          'Manual edits can break the build and are not advised.\n# This '
          'file is expected to be part of source control.')) {
        lockfiles.add(file);
      }
    } on FileSystemException {
      if (verbose) {
        logger.printStatus('Unable to check ${file.path}');
      }
    }
  }
  if (lockfiles.isNotEmpty) {
    logger.printStatus('\nGradle dependency locking detected.');
    logger
        .printStatus('Flutter can backup the lockfiles and regenerate updated '
            'lockfiles.');
    terminal.usesTerminalUi = true;
    String selection = 'y';
    if (!force) {
      selection = await terminal.promptForCharInput(
        <String>['y', 'n'],
        logger: logger,
        prompt:
            'Do you want the tool to update locked dependencies? (y)es, (n)o',
        defaultChoiceIndex: 1,
      );
    }
    if (selection == 'y') {
      for (final File file in lockfiles) {
        int counter = 0;
        while (true) {
          final String newPath = '${file.absolute.path}_backup_$counter';
          if (!fileSystem.file(newPath).existsSync()) {
            file.renameSync(newPath);
            backedUpFilePaths.add(newPath);
            break;
          } else {
            counter++;
          }
        }
      }
      // Runs `./gradlew tasks`in the project's android directory.
      await migrateUtils.gradlewTasks(
          flutterProject.directory.childDirectory('android').path);
      logger.printStatus('Old lockfiles renamed to:');
      for (final String path in backedUpFilePaths) {
        logger.printStatus(path, color: TerminalColor.grey, indent: 2);
      }
    }
  }
}
