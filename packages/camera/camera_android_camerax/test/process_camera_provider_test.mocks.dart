// Mocks generated by Mockito 5.4.0 from annotations
// in camera_android_camerax/test/process_camera_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;

import 'test_camerax_library.g.dart' as _i2;

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

/// A class which mocks [TestInstanceManagerHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestInstanceManagerHostApi extends _i1.Mock
    implements _i2.TestInstanceManagerHostApi {
  MockTestInstanceManagerHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void clear() => super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestProcessCameraProviderHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestProcessCameraProviderHostApi extends _i1.Mock
    implements _i2.TestProcessCameraProviderHostApi {
  MockTestProcessCameraProviderHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<int> getInstance() => (super.noSuchMethod(
        Invocation.method(
          #getInstance,
          [],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  List<int?> getAvailableCameraInfos(int? identifier) => (super.noSuchMethod(
        Invocation.method(
          #getAvailableCameraInfos,
          [identifier],
        ),
        returnValue: <int?>[],
      ) as List<int?>);
  @override
  int bindToLifecycle(
    int? identifier,
    int? cameraSelectorIdentifier,
    List<int?>? useCaseIds,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #bindToLifecycle,
          [
            identifier,
            cameraSelectorIdentifier,
            useCaseIds,
          ],
        ),
        returnValue: 0,
      ) as int);
  @override
  bool isBound(
    int? identifier,
    int? useCaseIdentifier,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #isBound,
          [
            identifier,
            useCaseIdentifier,
          ],
        ),
        returnValue: false,
      ) as bool);
  @override
  void unbind(
    int? identifier,
    List<int?>? useCaseIds,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #unbind,
          [
            identifier,
            useCaseIds,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void unbindAll(int? identifier) => super.noSuchMethod(
        Invocation.method(
          #unbindAll,
          [identifier],
        ),
        returnValueForMissingStub: null,
      );
}
