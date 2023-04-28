// Mocks generated by Mockito 5.4.0 from annotations
// in camera_android_camerax/test/image_proxy_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
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

/// A class which mocks [TestImageProxyHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestImageProxyHostApi extends _i1.Mock
    implements _i2.TestImageProxyHostApi {
  MockTestImageProxyHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<int?> getPlanes(int? identifier) => (super.noSuchMethod(
        Invocation.method(
          #getPlanes,
          [identifier],
        ),
        returnValue: <int?>[],
      ) as List<int?>);
  @override
  void close(int? identifier) => super.noSuchMethod(
        Invocation.method(
          #close,
          [identifier],
        ),
        returnValueForMissingStub: null,
      );
}

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
