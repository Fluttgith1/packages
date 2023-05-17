// Mocks generated by Mockito 5.4.0 from annotations
// in file_selector_android/test/file_selector_android_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:file_selector_android/src/file_selector_api.g.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

import 'test_file_selector_api.g.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TestFileSelectorApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestFileSelectorApi extends _i1.Mock
    implements _i2.TestFileSelectorApi {
  MockTestFileSelectorApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.FileResponse?> openFile(
    String? initialDirectory,
    List<String?>? mimeTypes,
    List<String?>? extensions,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #openFile,
          [
            initialDirectory,
            mimeTypes,
            extensions,
          ],
        ),
        returnValue: _i3.Future<_i4.FileResponse?>.value(),
      ) as _i3.Future<_i4.FileResponse?>);
  @override
  _i3.Future<List<_i4.FileResponse?>> openFiles(
    String? initialDirectory,
    List<String?>? mimeTypes,
    List<String?>? extensions,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #openFiles,
          [
            initialDirectory,
            mimeTypes,
            extensions,
          ],
        ),
        returnValue:
            _i3.Future<List<_i4.FileResponse?>>.value(<_i4.FileResponse?>[]),
      ) as _i3.Future<List<_i4.FileResponse?>>);
  @override
  _i3.Future<String?> getDirectoryPath(String? initialDirectory) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDirectoryPath,
          [initialDirectory],
        ),
        returnValue: _i3.Future<String?>.value(),
      ) as _i3.Future<String?>);
}
