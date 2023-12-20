// Mocks generated by Mockito 5.4.3 from annotations
// in webview_flutter_android/test/legacy/webview_android_cookie_manager_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:webview_flutter_android/src/android_webview.dart' as _i2;

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

class _FakeCookieManager_0 extends _i1.SmartFake implements _i2.CookieManager {
  _FakeCookieManager_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CookieManager].
///
/// See the documentation for Mockito's code generation for more information.
class MockCookieManager extends _i1.Mock implements _i2.CookieManager {
  MockCookieManager() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> setCookie(
    String? url,
    String? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setCookie,
          [
            url,
            value,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<bool> removeAllCookies() => (super.noSuchMethod(
        Invocation.method(
          #removeAllCookies,
          [],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
  @override
  _i3.Future<void> setAcceptThirdPartyCookies(
    _i2.WebView? webView,
    bool? accept,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setAcceptThirdPartyCookies,
          [
            webView,
            accept,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i2.CookieManager copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeCookieManager_0(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i2.CookieManager);
}
