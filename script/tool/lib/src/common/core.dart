// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:colorize/colorize.dart';
import 'package:file/file.dart';
import 'package:pub_semver/pub_semver.dart';

/// The signature for a print handler for commands that allow overriding the
/// print destination.
typedef Print = void Function(Object? object);

/// Key for APK (Android) platform.
const String platformAndroid = 'android';

/// Alias for APK (Android) platform.
const String platformAndroidAlias = 'apk';

/// Key for IPA (iOS) platform.
const String platformIOS = 'ios';

/// Key for linux platform.
const String platformLinux = 'linux';

/// Key for macos platform.
const String platformMacOS = 'macos';

/// Key for Web platform.
const String platformWeb = 'web';

/// Key for windows platform.
const String platformWindows = 'windows';

/// Key for enable experiment.
const String kEnableExperiment = 'enable-experiment';

/// Target platforms supported by Flutter.
// ignore: public_member_api_docs
enum FlutterPlatform { android, ios, linux, macos, web, windows }

// Flutter->Dart SDK version mapping. Any time a command fails to look up a
// corresponding version, this map should be updated.
final Map<Version, Version> _dartSdkForFlutterSdk = <Version, Version>{
  Version(3, 0, 0): Version(2, 17, 0),
  Version(3, 0, 5): Version(2, 17, 6),
  Version(3, 3, 0): Version(2, 18, 0),
  Version(3, 3, 10): Version(2, 18, 6),
  Version(3, 7, 0): Version(2, 19, 0),
  Version(3, 7, 12): Version(2, 19, 6),
  Version(3, 10, 0): Version(3, 0, 0),
};

/// Returns the version of the Dart SDK that shipped with the given Flutter
/// SDK.
Version? getDartSdkForFlutterSdk(Version flutterVersion) =>
    _dartSdkForFlutterSdk[flutterVersion];

/// Returns whether the given directory is a Dart package.
bool isPackage(FileSystemEntity entity) {
  if (entity is! Directory) {
    return false;
  }
  // According to
  // https://dart.dev/guides/libraries/create-library-packages#what-makes-a-library-package
  // a package must also have a `lib/` directory, but in practice that's not
  // always true. Some special cases (espresso, flutter_template_images, etc.)
  // don't have any source, so this deliberately doesn't check that there's a
  // lib directory.
  return entity.childFile('pubspec.yaml').existsSync();
}

/// Prints `successMessage` in green.
void printSuccess(String successMessage) {
  print(Colorize(successMessage)..green());
}

/// Prints `errorMessage` in red.
void printError(String errorMessage) {
  print(Colorize(errorMessage)..red());
}

/// Error thrown when a command needs to exit with a non-zero exit code.
///
/// While there is no specific definition of the meaning of different non-zero
/// exit codes for this tool, commands should follow the general convention:
///   1: The command ran correctly, but found errors.
///   2: The command failed to run because the arguments were invalid.
///  >2: The command failed to run correctly for some other reason. Ideally,
///      each such failure should have a unique exit code within the context of
///      that command.
class ToolExit extends Error {
  /// Creates a tool exit with the given [exitCode].
  ToolExit(this.exitCode);

  /// The code that the process should exit with.
  final int exitCode;
}

/// A exit code for [ToolExit] for a successful run that found errors.
const int exitCommandFoundErrors = 1;

/// A exit code for [ToolExit] for a failure to run due to invalid arguments.
const int exitInvalidArguments = 2;
