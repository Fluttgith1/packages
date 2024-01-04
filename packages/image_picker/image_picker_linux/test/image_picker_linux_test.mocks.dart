// Mocks generated by Mockito 5.4.4 from annotations
// in image_picker_linux/test/image_picker_linux_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:file_selector_platform_interface/file_selector_platform_interface.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [FileSelectorPlatform].
///
/// See the documentation for Mockito's code generation for more information.
class MockFileSelectorPlatform extends _i1.Mock
    implements _i2.FileSelectorPlatform {
  MockFileSelectorPlatform() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i2.XFile?> openFile({
    List<_i2.XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? confirmButtonText,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #openFile,
          [],
          {
            #acceptedTypeGroups: acceptedTypeGroups,
            #initialDirectory: initialDirectory,
            #confirmButtonText: confirmButtonText,
          },
        ),
        returnValue: _i3.Future<_i2.XFile?>.value(),
      ) as _i3.Future<_i2.XFile?>);

  @override
  _i3.Future<List<_i2.XFile>> openFiles({
    List<_i2.XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? confirmButtonText,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #openFiles,
          [],
          {
            #acceptedTypeGroups: acceptedTypeGroups,
            #initialDirectory: initialDirectory,
            #confirmButtonText: confirmButtonText,
          },
        ),
        returnValue: _i3.Future<List<_i2.XFile>>.value(<_i2.XFile>[]),
      ) as _i3.Future<List<_i2.XFile>>);

  @override
  _i3.Future<String?> getSavePath({
    List<_i2.XTypeGroup>? acceptedTypeGroups,
    String? initialDirectory,
    String? suggestedName,
    String? confirmButtonText,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSavePath,
          [],
          {
            #acceptedTypeGroups: acceptedTypeGroups,
            #initialDirectory: initialDirectory,
            #suggestedName: suggestedName,
            #confirmButtonText: confirmButtonText,
          },
        ),
        returnValue: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);

  @override
  _i3.Future<_i2.FileSaveLocation?> getSaveLocation({
    List<_i2.XTypeGroup>? acceptedTypeGroups,
    _i2.SaveDialogOptions? options = const _i2.SaveDialogOptions(),
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSaveLocation,
          [],
          {
            #acceptedTypeGroups: acceptedTypeGroups,
            #options: options,
          },
        ),
        returnValue: _i3.Future<_i2.FileSaveLocation?>.value(),
      ) as _i3.Future<_i2.FileSaveLocation?>);

  @override
  _i3.Future<String?> getDirectoryPath({
    String? initialDirectory,
    String? confirmButtonText,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDirectoryPath,
          [],
          {
            #initialDirectory: initialDirectory,
            #confirmButtonText: confirmButtonText,
          },
        ),
        returnValue: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);

  @override
  _i3.Future<List<String>> getDirectoryPaths({
    String? initialDirectory,
    String? confirmButtonText,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDirectoryPaths,
          [],
          {
            #initialDirectory: initialDirectory,
            #confirmButtonText: confirmButtonText,
          },
        ),
        returnValue: _i3.Future<List<String>>.value(<String>[]),
      ) as _i3.Future<List<String>>);
}
