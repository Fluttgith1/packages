// Mocks generated by Mockito 5.4.0 from annotations
// in path_provider_foundation/test/path_provider_foundation_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:path_provider_foundation/messages.g.dart' as _i3;

import 'messages_test.g.dart' as _i2;

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

/// A class which mocks [TestPathProviderApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestPathProviderApi extends _i1.Mock
    implements _i2.TestPathProviderApi {
  MockTestPathProviderApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String? getDirectoryPath(_i3.DirectoryType? type) =>
      (super.noSuchMethod(Invocation.method(
        #getDirectoryPath,
        [type],
      )) as String?);
  @override
  String? getContainerPath(String? appGroupIdentifier) =>
      (super.noSuchMethod(Invocation.method(
        #getContainerPath,
        [appGroupIdentifier],
      )) as String?);
}
