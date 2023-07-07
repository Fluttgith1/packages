// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

// Generates the pigeon output files needed for platform_test tests.
//
// Eventually this may get more options to control which files are generated,
// but for now it always generates everything needed for the platform unit
// tests.

import 'dart:io' show Platform, exit;

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import 'shared/generation.dart';

const String _helpFlag = 'help';
const String _formatFlag = 'format';
const String _files = 'files';
const String _test = 'test';
const String _example = 'example';

const List<String> _fileGroups = <String>[_test, _example];

Future<void> main(List<String> args) async {
  final ArgParser parser = ArgParser()
    ..addFlag(_formatFlag, abbr: 'f', help: 'Autoformats after generation.')
    ..addFlag(_helpFlag,
        negatable: false, abbr: 'h', help: 'Print this reference.')
    ..addMultiOption(_files,
        help:
            'Select specific groups of files to generate; $_test or $_example. Defaults to both.',
        allowed: _fileGroups);

  final ArgResults argResults = parser.parse(args);
  if (argResults.wasParsed(_helpFlag)) {
    print('''
usage: dart run tool/generate.dart [options]

${parser.usage}''');
    exit(0);
  }

  final String baseDir = p.dirname(p.dirname(Platform.script.toFilePath()));

  final List<String>? toGenerate =
      argResults.wasParsed(_files) ? argResults[_files] as List<String> : null;

  if (toGenerate == null || toGenerate.contains(_test)) {
    print('Generating platform_test/ output...');
    final int generateExitCode = await generateTestPigeons(baseDir: baseDir);
    if (generateExitCode == 0) {
      print('Generation complete!');
    } else {
      print('Generation failed; see above for errors.');
      exit(generateExitCode);
    }
  }

  if (toGenerate == null || toGenerate.contains(_example)) {
    print('Generating example/ output...');
    final int generateExitCode = await generateExamplePigeons();
    if (generateExitCode == 0) {
      print('Generation complete!');
    } else {
      print('Generation failed; see above for errors.');
      exit(generateExitCode);
    }
  }

  if (argResults.wasParsed(_formatFlag)) {
    print('Formatting generated output...');
    final int formatExitCode =
        await formatAllFiles(repositoryRoot: p.dirname(p.dirname(baseDir)));
    if (formatExitCode != 0) {
      print('Formatting failed; see above for errors.');
      exit(formatExitCode);
    }
  }
}
