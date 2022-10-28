// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter_migrate/src/base/common.dart';
import 'package:flutter_migrate/src/base/context.dart';
import 'package:flutter_migrate/src/base/file_system.dart';
import 'package:flutter_migrate/src/base/io.dart';
import 'package:flutter_migrate/src/base/logger.dart';
import 'package:flutter_migrate/src/base/signals.dart';
import 'package:flutter_migrate/src/environment.dart';
import 'package:process/process.dart';

import 'src/common.dart';
import 'src/context.dart';

void main() {
  late FileSystem fileSystem;
  late BufferLogger logger;
  late ProcessManager processManager;
  late Directory appDir;

  setUp(() {
    fileSystem = LocalFileSystem.test(signals: LocalSignals.instance);
    appDir = fileSystem.systemTempDirectory.createTempSync('apptestdir');
    logger = BufferLogger.test();
    processManager = FakeProcessManager('''
{
  "FlutterProject.directory": "/Users/test/flutter",
  "FlutterProject.metadataFile": "/Users/test/flutter/.metadata",
  "FlutterProject.android.exists": false,
  "FlutterProject.ios.exists": false,
  "FlutterProject.web.exists": false,
  "FlutterProject.macos.exists": false,
  "FlutterProject.linux.exists": false,
  "FlutterProject.windows.exists": false,
  "FlutterProject.fuchsia.exists": false,
  "FlutterProject.android.isKotlin": false,
  "FlutterProject.ios.isSwift": false,
  "FlutterProject.isModule": false,
  "FlutterProject.isPlugin": false,
  "FlutterProject.manifest.appname": "",
  "FlutterVersion.frameworkRevision": "4e181f012c717777681862e4771af5a941774bb9",
  "Platform.operatingSystem": "macos",
  "Platform.isAndroid": false,
  "Platform.isIOS": false,
  "Platform.isWindows": false,
  "Platform.isMacOS": true,
  "Platform.isFuchsia": false,
  "Platform.pathSeparator": "/",
  "Cache.flutterRoot": "/Users/test/flutter"
}
''');
  });

  tearDown(() async {
    tryToDelete(appDir);
  });

  testUsingContext('Environment initialization', () async {
    final FlutterToolsEnvironment env =
        await FlutterToolsEnvironment.initializeFlutterToolsEnvironment(
            processManager, logger);
    expect(env.getString('invalid key') == null, true);
    expect(env.getBool('invalid key') == null, true);

    expect(env.getString('FlutterProject.directory') != null, true);
    expect(env.getString('FlutterProject.metadataFile') != null, true);
    expect(env.getBool('FlutterProject.android.exists'), false);
    expect(env.getBool('FlutterProject.ios.exists'), false);
    expect(env.getBool('FlutterProject.web.exists'), false);
    expect(env.getBool('FlutterProject.macos.exists'), false);
    expect(env.getBool('FlutterProject.linux.exists'), false);
    expect(env.getBool('FlutterProject.windows.exists'), false);
    expect(env.getBool('FlutterProject.fuchsia.exists'), false);
    expect(env.getBool('FlutterProject.android.isKotlin'), false);
    expect(env.getBool('FlutterProject.ios.isSwift'), false);
    expect(env.getBool('FlutterProject.isModule'), false);
    expect(env.getBool('FlutterProject.isPlugin'), false);
    expect(env.getString('FlutterProject.manifest.appname') != null, true);
    expect(env.getString('FlutterVersion.frameworkRevision') != null, true);
    final String os = isWindows
        ? 'windows'
        : isMacOS
            ? 'macos'
            : isLinux
                ? 'linux'
                : '';
    expect(env.getString('Platform.operatingSystem'), os);
    expect(env.getBool('Platform.isAndroid') != null, true);
    expect(env.getBool('Platform.isIOS') != null, true);
    expect(env.getBool('Platform.isWindows'), isWindows);
    expect(env.getBool('Platform.isMacOS'), isMacOS);
    expect(env.getBool('Platform.isFuchsia'), false);
    final String separator = isWindows ? r'\\' : '/';
    expect(env.getString('Platform.pathSeparator'), separator);
    expect(env.getString('Cache.flutterRoot') != null, true);
  }, overrides: <Type, Generator>{
    FileSystem: () => fileSystem,
    ProcessManager: () => processManager,
  });
}

class FakeProcessManager extends LocalProcessManager {
  FakeProcessManager(this.runResult);

  final String runResult;

  @override
  Future<ProcessResult> run(List<Object> command,
      {String? workingDirectory,
      Map<String, String>? environment,
      bool includeParentEnvironment = true,
      bool runInShell = false,
      covariant Encoding? stdoutEncoding = systemEncoding,
      covariant Encoding? stderrEncoding = systemEncoding}) async {
    return ProcessResult(0, 0, runResult, '');
  }
}
