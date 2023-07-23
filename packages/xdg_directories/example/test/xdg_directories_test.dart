import 'dart:io' show Directory, Platform;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:xdg_directories/xdg_directories.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('XDG Directories', (WidgetTester _) async {
    if (!Platform.isLinux) {
      throw Exception('This test is only valid on Linux');
    }

    // Check that the XDG directories are valid.
    expect(getUserDirectoryNames(), Set<String>,
        reason: 'getUserDirectoryNames() should return a Set<String>');

    expect(
      getUserDirectoryNames().length,
      isNot(0),
      reason: 'getUserDirectoryNames() should return a non-empty Set<String>',
    );

    final Set<String> userDirectoryNames = getUserDirectoryNames();

    expect(
      getUserDirectory(userDirectoryNames.first),
      Directory,
      reason: 'getUserDirectory() should return a Directory',
    );

    expect(
      getUserDirectory('randomString'),
      null,
      reason:
          'getUserDirectory() should return null if the directory does not exist',
    );

    expect(
      dataHome,
      Directory,
      reason: 'dataHome should return a Directory',
    );

    expect(
      configHome,
      Directory,
      reason: 'configHome should return a Directory',
    );

    expect(
      cacheHome,
      Directory,
      reason: 'cacheHome should return a Directory',
    );

    expect(
      runtimeDir,
      Directory,
      reason: 'runtimeDir should return a Directory',
    );

    expect(
      dataDirs,
      List<Directory>,
      reason: 'dataDirs should return a List<Directory>',
    );

    expect(
      configDirs,
      List<Directory>,
      reason: 'configDirs should return a List<Directory>',
    );
  });
}
