// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:file/file.dart';

import 'common/core.dart';
import 'common/package_looping_command.dart';
import 'common/plugin_utils.dart';
import 'common/repository_package.dart';

/// A command to enforce gradle file conventions and best practices.
class GradleCheckCommand extends PackageLoopingCommand {
  /// Creates an instance of the gradle check command.
  GradleCheckCommand(Directory packagesDir) : super(packagesDir);

  @override
  final String name = 'gradle-check';

  @override
  final String description =
      'Checks that gradle files follow repository conventions.';

  @override
  bool get hasLongOutput => false;

  @override
  PackageLoopingType get packageLoopingType =>
      PackageLoopingType.includeAllSubpackages;

  @override
  Future<PackageResult> runForPackage(RepositoryPackage package) async {
    if (!package.platformDirectory(FlutterPlatform.android).existsSync()) {
      return PackageResult.skip('No android/ directory.');
    }

    const String exampleDirName = 'example';
    final bool isExample = package.directory.basename == exampleDirName ||
        package.directory.parent.basename == exampleDirName;
    if (!_validateBuildGradles(package, isExample: isExample)) {
      return PackageResult.fail();
    }
    return PackageResult.success();
  }

  bool _validateBuildGradles(RepositoryPackage package,
      {required bool isExample}) {
    final Directory androidDir =
        package.platformDirectory(FlutterPlatform.android);
    final File topLevelGradleFile = _getBuildGradleFile(androidDir);

    // This is tracked as a variable rather than a sequence of &&s so that all
    // failures are reported at once, not just the first one.
    bool succeeded = true;
    if (isExample) {
      if (!_validateExampleTopLevelBuildGradle(package, topLevelGradleFile)) {
        succeeded = false;
      }

      final File appGradleFile =
          _getBuildGradleFile(androidDir.childDirectory('app'));
      if (!_validateExampleAppBuildGradle(package, appGradleFile)) {
        succeeded = false;
      }
    } else {
      succeeded = _validatePluginBuildGradle(package, topLevelGradleFile);
    }

    return succeeded;
  }

  // Returns the gradle file in the given directory.
  File _getBuildGradleFile(Directory dir) => dir.childFile('build.gradle');

  // Returns the main/AndroidManifest.xml file for the given package.
  File _getMainAndroidManifest(RepositoryPackage package,
      {required bool isExample}) {
    final Directory androidDir =
        package.platformDirectory(FlutterPlatform.android);
    final Directory baseDir =
        isExample ? androidDir.childDirectory('app') : androidDir;
    return baseDir
        .childDirectory('src')
        .childDirectory('main')
        .childFile('AndroidManifest.xml');
  }

  bool _isCommented(String line) => line.trim().startsWith('//');

  /// Validates the build.gradle file for a plugin
  /// (some_plugin/android/build.gradle).
  bool _validatePluginBuildGradle(RepositoryPackage package, File gradleFile) {
    print('${indentation}Validating '
        '${getRelativePosixPath(gradleFile, from: package.directory)}.');
    final String contents = gradleFile.readAsStringSync();
    final List<String> lines = contents.split('\n');

    // This is tracked as a variable rather than a sequence of &&s so that all
    // failures are reported at once, not just the first one.
    bool succeeded = true;
    if (!_validateNamespace(package, contents, isExample: false)) {
      succeeded = false;
    }
    if (!_validateCompatibilityVersions(lines)) {
      succeeded = false;
    }
    if (!_validateGradleDrivenLintConfig(package, lines)) {
      succeeded = false;
    }
    return succeeded;
  }

  /// Validates the top-level build.gradle for an example app (e.g.,
  /// some_package/example/android/build.gradle).
  bool _validateExampleTopLevelBuildGradle(
      RepositoryPackage package, File gradleFile) {
    print('${indentation}Validating '
        '${getRelativePosixPath(gradleFile, from: package.directory)}.');
    final String contents = gradleFile.readAsStringSync();
    final List<String> lines = contents.split('\n');

    // This is tracked as a variable rather than a sequence of &&s so that all
    // failures are reported at once, not just the first one.
    bool succeeded = true;
    if (!_validateJavacLintConfig(package, lines)) {
      succeeded = false;
    }
    return succeeded;
  }

  /// Validates the app-level build.gradle for an example app (e.g.,
  /// some_package/example/android/app/build.gradle).
  bool _validateExampleAppBuildGradle(
      RepositoryPackage package, File gradleFile) {
    print('${indentation}Validating '
        '${getRelativePosixPath(gradleFile, from: package.directory)}.');
    final String contents = gradleFile.readAsStringSync();

    // This is tracked as a variable rather than a sequence of &&s so that all
    // failures are reported at once, not just the first one.
    bool succeeded = true;
    if (!_validateNamespace(package, contents, isExample: true)) {
      succeeded = false;
    }
    return succeeded;
  }

  /// Validates that [gradleContents] sets a namespace, which is required for
  /// compatibility with apps that use AGP 8+.
  bool _validateNamespace(RepositoryPackage package, String gradleContents,
      {required bool isExample}) {
    final RegExp namespaceRegex =
        RegExp('^\\s*namespace\\s+[\'"](.*?)[\'"]', multiLine: true);
    final RegExpMatch? namespaceMatch =
        namespaceRegex.firstMatch(gradleContents);

    // For plugins, make sure the namespace is conditionalized so that it
    // doesn't break client apps using AGP 4.1 and earlier (which don't have
    // a namespace property, and will fail to build if it's set).
    const String namespaceConditional =
        'if (project.android.hasProperty("namespace"))';
    String exampleSetNamespace = "namespace 'dev.flutter.foo'";
    if (!isExample) {
      exampleSetNamespace = '''
$namespaceConditional {
    $exampleSetNamespace
}''';
    }
    // Wrap the namespace command in an `android` block, adding the indentation
    // to make it line up correctly.
    final String exampleAndroidNamespaceBlock = '''
    android {
        ${exampleSetNamespace.split('\n').join('\n        ')}
    }
''';

    if (namespaceMatch == null) {
      final String errorMessage = '''
build.gradle must set a "namespace":

$exampleAndroidNamespaceBlock

The value must match the "package" attribute in AndroidManifest.xml, if one is
present. For more information, see:
https://developer.android.com/build/publish-library/prep-lib-release#choose-namespace
''';

      printError(
          '$indentation${errorMessage.split('\n').join('\n$indentation')}');
      return false;
    } else {
      if (!isExample && !gradleContents.contains(namespaceConditional)) {
        final String errorMessage = '''
build.gradle for a plugin must conditionalize "namespace":

$exampleAndroidNamespaceBlock
''';

        printError(
            '$indentation${errorMessage.split('\n').join('\n$indentation')}');
        return false;
      }

      return _validateNamespaceMatchesManifest(package,
          isExample: isExample, namespace: namespaceMatch.group(1)!);
    }
  }

  /// Validates that the given namespace matches the manifest package of
  /// [package] (if any; a package does not need to be in the manifest in cases
  /// where compatibility with AGP <7 is no longer required).
  ///
  /// Prints an error and returns false if validation fails.
  bool _validateNamespaceMatchesManifest(RepositoryPackage package,
      {required bool isExample, required String namespace}) {
    final RegExp manifestPackageRegex = RegExp(r'package\s*=\s*"(.*?)"');
    final String manifestContents =
        _getMainAndroidManifest(package, isExample: isExample)
            .readAsStringSync();
    final RegExpMatch? packageMatch =
        manifestPackageRegex.firstMatch(manifestContents);
    if (packageMatch != null && namespace != packageMatch.group(1)) {
      final String errorMessage = '''
build.gradle "namespace" must match the "package" attribute in AndroidManifest.xml, if one is present.
  build.gradle namespace: "$namespace"
  AndroidMastifest.xml package: "${packageMatch.group(1)}"
''';
      printError(
          '$indentation${errorMessage.split('\n').join('\n$indentation')}');
      return false;
    }
    return true;
  }

  /// Checks for a source compatibiltiy version, so that it's explicit rather
  /// than using whatever the client's local toolchaing defaults to (which can
  /// lead to compile errors that show up for clients, but not in CI).
  bool _validateCompatibilityVersions(List<String> gradleLines) {
    final bool hasLanguageVersion = gradleLines.any((String line) =>
        line.contains('languageVersion') && !_isCommented(line));
    final bool hasCompabilityVersions = gradleLines.any((String line) =>
            line.contains('sourceCompatibility') && !_isCommented(line)) &&
        // Newer toolchains default targetCompatibility to the same value as
        // sourceCompatibility, but older toolchains require it to be set
        // explicitly. The exact version cutoff (and of which piece of the
        // toolchain; likely AGP) is unknown; for context see
        // https://github.com/flutter/flutter/issues/125482
        gradleLines.any((String line) =>
            line.contains('targetCompatibility') && !_isCommented(line));
    if (!hasLanguageVersion && !hasCompabilityVersions) {
      const String errorMessage = '''
build.gradle must set an explicit Java compatibility version.

This can be done either via "sourceCompatibility"/"targetCompatibility":
    android {
        compileOptions {
            sourceCompatibility JavaVersion.VERSION_1_8
            targetCompatibility JavaVersion.VERSION_1_8
        }
    }

or "toolchain":
    java {
        toolchain {
            languageVersion = JavaLanguageVersion.of(8)
        }
    }

See:
https://docs.gradle.org/current/userguide/java_plugin.html#toolchain_and_compatibility
for more details.''';

      printError(
          '$indentation${errorMessage.split('\n').join('\n$indentation')}');
      return false;
    }
    return true;
  }

  /// Returns whether the given gradle content is configured to enable all
  /// Gradle-driven lints (those checked by ./gradlew lint) and treat them as
  /// errors.
  bool _validateGradleDrivenLintConfig(
      RepositoryPackage package, List<String> gradleLines) {
    final List<String> gradleBuildContents = package
        .platformDirectory(FlutterPlatform.android)
        .childFile('build.gradle')
        .readAsLinesSync();
    if (!gradleBuildContents.any((String line) =>
            line.contains('checkAllWarnings true') && !_isCommented(line)) ||
        !gradleBuildContents.any((String line) =>
            line.contains('warningsAsErrors true') && !_isCommented(line))) {
      printError('${indentation}This package is not configured to enable all '
          'Gradle-driven lint warnings and treat them as errors. '
          'Please add the following to the lintOptions section of '
          'android/build.gradle:');
      print('''
        checkAllWarnings true
        warningsAsErrors true
''');
      return false;
    }
    return true;
  }

  /// Validates whether the given [example]'s gradle content is configured to
  /// build its plugin target with javac lints enabled and treated as errors,
  /// if the enclosing package is a plugin.
  ///
  /// This can only be called on example packages. (Plugin packages should not
  /// be configured this way, since it would affect clients.)
  ///
  /// If [example]'s enclosing package is not a plugin package, this just
  /// returns true.
  bool _validateJavacLintConfig(
      RepositoryPackage example, List<String> gradleLines) {
    final RepositoryPackage enclosingPackage = example.getEnclosingPackage()!;
    if (!pluginSupportsPlatform(platformAndroid, enclosingPackage,
        requiredMode: PlatformSupport.inline)) {
      return true;
    }
    final String enclosingPackageName = enclosingPackage.directory.basename;

    // The check here is intentionally somewhat loose, to allow for the
    // possibility of variations (e.g., not using Xlint:all in some cases, or
    // passing other arguments).
    if (!(gradleLines.any((String line) =>
            line.contains('project(":$enclosingPackageName")')) &&
        gradleLines.any((String line) =>
            line.contains('options.compilerArgs') &&
            line.contains('-Xlint') &&
            line.contains('-Werror')))) {
      printError('The example '
          '"${getRelativePosixPath(example.directory, from: enclosingPackage.directory)}" '
          'is not configured to treat javac lints and warnings as errors. '
          'Please add the following to its build.gradle:');
      print('''
gradle.projectsEvaluated {
    project(":$enclosingPackageName") {
        tasks.withType(JavaCompile) {
            options.compilerArgs << "-Xlint:all" << "-Werror"
        }
    }
}
''');
      return false;
    }
    return true;
  }
}
