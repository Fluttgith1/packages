// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_migrate/src/base/file_system.dart';
import 'package:flutter_migrate/src/base/io.dart';
import 'package:flutter_migrate/src/base/logger.dart';
import 'package:flutter_migrate/src/base/project.dart';
import 'package:flutter_migrate/src/base/signals.dart';
import 'package:flutter_migrate/src/base/terminal.dart';
import 'package:flutter_migrate/src/update_locks.dart';
import 'package:flutter_migrate/src/utils.dart';
import 'package:process/process.dart';
import 'package:yaml/yaml.dart';

import 'src/common.dart';
import 'src/test_utils.dart';

void main() {
  late FileSystem fileSystem;
  late BufferLogger logger;
  late MigrateUtils utils;
  late Directory currentDir;
  late FlutterProject flutterProject;
  late Terminal terminal;
  late ProcessManager processManager;

  setUp(() async {
    fileSystem = LocalFileSystem.test(signals: LocalSignals.instance);
    currentDir = createResolvedTempDirectorySync('current_app.');
    logger = BufferLogger.test();
    terminal = Terminal.test();
    utils = MigrateUtils(
      logger: logger,
      fileSystem: fileSystem,
      processManager: const LocalProcessManager(),
    );
    final FlutterProjectFactory flutterFactory = FlutterProjectFactory();
    flutterProject = flutterFactory.fromDirectory(currentDir);
    processManager = const LocalProcessManager();
  });

  tearDown(() async {
    tryToDelete(currentDir);
  });

  testWithoutContext('updates pubspec locks', () async {
    final ProcessResult result = await processManager.run(<String>[
      'flutter',
      'create',
      currentDir.absolute.path,
      '--project-name=testproject'
    ]);
    expect(result.exitCode, 0);
    final File pubspec = currentDir.childFile('pubspec.yaml');
    pubspec.writeAsStringSync('''
name: testproject
description: A test flutter project.

environment:
  sdk: ">=2.17.0-0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  characters: 1.2.0 # THIS LINE IS AUTOGENERATED - TO UPDATE USE "flutter update-packages --force-upgrade"
  collection: 1.15.0 # THIS LINE IS AUTOGENERATED - TO UPDATE USE "flutter update-packages --force-upgrade"
  js: 0.6.3 # THIS LINE IS AUTOGENERATED - TO UPDATE USE "flutter update-packages --force-upgrade"
  material_color_utilities: 0.1.0 # THIS LINE IS AUTOGENERATED - TO UPDATE USE "flutter update-packages --force-upgrade"
  meta: 1.7.0 # THIS LINE IS AUTOGENERATED - TO UPDATE USE "flutter update-packages --force-upgrade"
  vector_math: 2.1.2 # THIS LINE IS AUTOGENERATED - TO UPDATE USE "flutter update-packages --force-upgrade"

flutter:
  uses-material-design: true

# PUBSPEC CHECKSUM: 1b91

''', flush: true);
    await updatePubspecDependencies(flutterProject, utils, logger, terminal,
        force: true);
    final YamlMap pubspecYaml = loadYaml(pubspec.readAsStringSync());
    final YamlMap dependenciesMap = pubspecYaml['dependencies'];
    expect(
        _VersionCode.fromString(dependenciesMap['characters'] as String) >
            _VersionCode.fromString('1.2.0'),
        true);
    expect(
        _VersionCode.fromString(dependenciesMap['collection'] as String) >
            _VersionCode.fromString('1.15.0'),
        true);
    expect(
        _VersionCode.fromString(dependenciesMap['js'] as String) >
            _VersionCode.fromString('0.6.3'),
        true);
    expect(
        _VersionCode.fromString(
                dependenciesMap['material_color_utilities'] as String) >
            _VersionCode.fromString('0.1.0'),
        true);
    expect(
        _VersionCode.fromString(dependenciesMap['meta'] as String) >
            _VersionCode.fromString('1.7.0'),
        true);
  });

  testWithoutContext('updates gradle locks', () async {
    final ProcessResult result = await processManager.run(<String>[
      'flutter',
      'create',
      currentDir.absolute.path,
      '--project-name=testproject'
    ]);
    expect(result.exitCode, 0);
    final File projectAppLock =
        currentDir.childDirectory('android').childFile('project-app.lockfile');
    final File buildGradle =
        currentDir.childDirectory('android').childFile('build.gradle');
    final File gradleProperties =
        currentDir.childDirectory('android').childFile('gradle.properties');
    gradleProperties.writeAsStringSync('''
org.gradle.daemon=false
org.gradle.jvmargs=-Xmx1536M
android.useAndroidX=true
android.enableJetifier=true
''', flush: true);
    final File projectAppLockBackup = currentDir
        .childDirectory('android')
        .childFile('project-app.lockfile_backup_0');
    expect(projectAppLockBackup.existsSync(), false);
    projectAppLock.createSync(recursive: true);
    projectAppLock.writeAsStringSync('''
# This is a Gradle generated file for dependency locking.
# Manual edits can break the build and are not advised.
# This file is expected to be part of source control.
androidx.activity:activity:1.0.0=debugAndroidTestCompileClasspath,debugCompileClasspath,debugRuntimeClasspath,debugUnitTestCompileClasspath,debugUnitTestRuntimeClasspath,profileCompileClasspath,profileRuntimeClasspath,profileUnitTestCompileClasspath,profileUnitTestRuntimeClasspath,releaseCompileClasspath,releaseRuntimeClasspath,releaseUnitTestCompileClasspath,releaseUnitTestRuntimeClasspath
androidx.annotation:annotation-experimental:1.1.0=debugAndroidTestCompileClasspath,debugCompileClasspath,debugRuntimeClasspath,debugUnitTestCompileClasspath,debugUnitTestRuntimeClasspath,profileCompileClasspath,profileRuntimeClasspath,profileUnitTestCompileClasspath,profileUnitTestRuntimeClasspath,releaseCompileClasspath,releaseRuntimeClasspath,releaseUnitTestCompileClasspath,releaseUnitTestRuntimeClasspath
androidx.annotation:annotation:1.2.0=debugAndroidTestCompileClasspath,debugCompileClasspath,debugRuntimeClasspath,debugUnitTestCompileClasspath,debugUnitTestRuntimeClasspath,profileCompileClasspath,profileRuntimeClasspath,profileUnitTestCompileClasspath,profileUnitTestRuntimeClasspath,releaseCompileClasspath,releaseRuntimeClasspath,releaseUnitTestCompileClasspath,releaseUnitTestRuntimeClasspath

''', flush: true);
    buildGradle.writeAsStringSync(r'''
buildscript {
    ext.kotlin_version = '1.5.31'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.2.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }

    configurations.classpath {
        resolutionStrategy.activateDependencyLocking()
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = '../build'

subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
    dependencyLocking {
        ignoredDependencies.add('io.flutter:*')
        lockFile = file("${rootProject.projectDir}/project-${project.name}.lockfile")
        if (!project.hasProperty('local-engine-repo')) {
          lockAllConfigurations()
        }
    }
}

''', flush: true);
    expect(
        currentDir
            .childDirectory('android')
            .childFile('gradlew.bat')
            .existsSync(),
        true);
    final Directory dotGradle =
        currentDir.childDirectory('android').childDirectory('.gradle');
    tryToDelete(dotGradle);
    await updateGradleDependencyLocking(
        flutterProject, utils, logger, terminal, true, fileSystem,
        force: true);
    expect(projectAppLockBackup.existsSync(), true);
    expect(projectAppLock.existsSync(), true);
    expect(projectAppLock.readAsStringSync(),
        contains('# This is a Gradle generated file for dependency locking.'));
    expect(projectAppLock.readAsStringSync(),
        contains('# Manual edits can break the build and are not advised.'));
    expect(projectAppLock.readAsStringSync(),
        contains('# This file is expected to be part of source control.'));
  }, timeout: const Timeout(Duration(seconds: 500)), skip: true);
}

class _VersionCode extends Comparable<_VersionCode> {
  _VersionCode(this.first, this.second, this.third, this.caret);
  _VersionCode.fromString(String str)
      : first = 0,
        second = 0,
        third = 0,
        caret = 0 {
    caret = str.contains('^') ? 1 : 0;
    str = str.replaceAll('^', '');
    final List<String> splits = str.split('.');
    assert(splits.length == 3);

    first = int.parse(splits[0]);
    second = int.parse(splits[1]);
    third = int.parse(splits[2]);
  }

  int caret;
  int first;
  int second;
  int third;

  bool operator >(_VersionCode other) {
    return compareTo(other) > 0;
  }

  bool operator <(_VersionCode other) {
    return !(this > other);
  }

  @override
  int compareTo(_VersionCode other) {
    final int value = first * 10000000 + second * 100000 + third + caret;
    final int otherValue =
        other.first * 10000000 + other.second * 100000 + other.third + caret;
    return value - otherValue;
  }
}
