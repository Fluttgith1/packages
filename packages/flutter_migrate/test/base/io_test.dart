// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io' as io;

import 'package:file/memory.dart';
import 'package:flutter_migrate/src/base/io.dart';
import 'package:test/fake.dart';

import '../src/common.dart';
import '../src/io.dart';

void main() {
  testWithoutContext('IOOverrides can inject a memory file system', () async {
    final MemoryFileSystem memoryFileSystem = MemoryFileSystem.test();
    final FlutterIOOverrides flutterIOOverrides =
        FlutterIOOverrides(fileSystem: memoryFileSystem);
    await io.IOOverrides.runWithIOOverrides(() async {
      // statics delegate correctly.
      expect(io.FileSystemEntity.isWatchSupported,
          memoryFileSystem.isWatchSupported);
      expect(io.Directory.systemTemp.path,
          memoryFileSystem.systemTempDirectory.path);

      // can create and write to files/directories sync.
      final io.File file = io.File('abc');
      file.writeAsStringSync('def');
      final io.Directory directory = io.Directory('foobar');
      directory.createSync();

      expect(memoryFileSystem.file('abc').existsSync(), true);
      expect(memoryFileSystem.file('abc').readAsStringSync(), 'def');
      expect(memoryFileSystem.directory('foobar').existsSync(), true);

      // can create and write to files/directories async.
      final io.File fileB = io.File('xyz');
      await fileB.writeAsString('def');
      final io.Directory directoryB = io.Directory('barfoo');
      await directoryB.create();

      expect(memoryFileSystem.file('xyz').existsSync(), true);
      expect(memoryFileSystem.file('xyz').readAsStringSync(), 'def');
      expect(memoryFileSystem.directory('barfoo').existsSync(), true);

      // Links
      final io.Link linkA = io.Link('hhh');
      final io.Link linkB = io.Link('ggg');
      io.File('jjj').createSync();
      io.File('lll').createSync();
      await linkA.create('jjj');
      linkB.createSync('lll');

      expect(await memoryFileSystem.link('hhh').resolveSymbolicLinks(),
          await linkA.resolveSymbolicLinks());
      expect(memoryFileSystem.link('ggg').resolveSymbolicLinksSync(),
          linkB.resolveSymbolicLinksSync());
    }, flutterIOOverrides);
  });

  testWithoutContext('ProcessSignal signals are properly delegated', () async {
    final FakeProcessSignal signal = FakeProcessSignal();
    final ProcessSignal signalUnderTest = ProcessSignal(signal);

    signal.controller.add(signal);

    expect(signalUnderTest, await signalUnderTest.watch().first);
  });

  testWithoutContext('ProcessSignal toString() works', () async {
    expect(io.ProcessSignal.sigint.toString(), ProcessSignal.sigint.toString());
  });

  testWithoutContext('test_api defines the Declarer in a known place', () {
    expect(Zone.current[#test.declarer], isNotNull);
  });
}

class FakeProcessSignal extends Fake implements io.ProcessSignal {
  final StreamController<io.ProcessSignal> controller =
      StreamController<io.ProcessSignal>();

  @override
  Stream<io.ProcessSignal> watch() => controller.stream;
}
