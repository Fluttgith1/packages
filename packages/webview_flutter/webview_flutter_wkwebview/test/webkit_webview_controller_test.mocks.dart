// Mocks generated by Mockito 5.4.0 from annotations
// in webview_flutter_wkwebview/test/webkit_webview_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:math' as _i2;

import 'package:mockito/mockito.dart' as _i1;
import 'package:webview_flutter_wkwebview/src/foundation/foundation.dart'
    as _i6;
import 'package:webview_flutter_wkwebview/src/ui_kit/ui_kit.dart' as _i3;
import 'package:webview_flutter_wkwebview/src/web_kit/web_kit.dart' as _i4;

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

class _FakePoint_0<T extends num> extends _i1.SmartFake
    implements _i2.Point<T> {
  _FakePoint_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUIScrollView_1 extends _i1.SmartFake implements _i3.UIScrollView {
  _FakeUIScrollView_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWKPreferences_2 extends _i1.SmartFake implements _i4.WKPreferences {
  _FakeWKPreferences_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWKUserContentController_3 extends _i1.SmartFake
    implements _i4.WKUserContentController {
  _FakeWKUserContentController_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWKHttpCookieStore_4 extends _i1.SmartFake
    implements _i4.WKHttpCookieStore {
  _FakeWKHttpCookieStore_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWKWebsiteDataStore_5 extends _i1.SmartFake
    implements _i4.WKWebsiteDataStore {
  _FakeWKWebsiteDataStore_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWKWebViewConfiguration_6 extends _i1.SmartFake
    implements _i4.WKWebViewConfiguration {
  _FakeWKWebViewConfiguration_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWKWebView_7 extends _i1.SmartFake implements _i4.WKWebView {
  _FakeWKWebView_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UIScrollView].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockUIScrollView extends _i1.Mock implements _i3.UIScrollView {
  MockUIScrollView() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Point<double>> getContentOffset() => (super.noSuchMethod(
        Invocation.method(
          #getContentOffset,
          [],
        ),
        returnValue: _i5.Future<_i2.Point<double>>.value(_FakePoint_0<double>(
          this,
          Invocation.method(
            #getContentOffset,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Point<double>>);
  @override
  _i5.Future<void> scrollBy(_i2.Point<double>? offset) => (super.noSuchMethod(
        Invocation.method(
          #scrollBy,
          [offset],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setContentOffset(_i2.Point<double>? offset) =>
      (super.noSuchMethod(
        Invocation.method(
          #setContentOffset,
          [offset],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i3.UIScrollView copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeUIScrollView_1(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i3.UIScrollView);
  @override
  _i5.Future<void> setBackgroundColor(dynamic color) => (super.noSuchMethod(
        Invocation.method(
          #setBackgroundColor,
          [color],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setOpaque(bool? opaque) => (super.noSuchMethod(
        Invocation.method(
          #setOpaque,
          [opaque],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> addObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
    required Set<_i6.NSKeyValueObservingOptions>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addObserver,
          [observer],
          {
            #keyPath: keyPath,
            #options: options,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeObserver,
          [observer],
          {#keyPath: keyPath},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [WKPreferences].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockWKPreferences extends _i1.Mock implements _i4.WKPreferences {
  MockWKPreferences() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> setJavaScriptEnabled(bool? enabled) => (super.noSuchMethod(
        Invocation.method(
          #setJavaScriptEnabled,
          [enabled],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i4.WKPreferences copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeWKPreferences_2(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i4.WKPreferences);
  @override
  _i5.Future<void> addObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
    required Set<_i6.NSKeyValueObservingOptions>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addObserver,
          [observer],
          {
            #keyPath: keyPath,
            #options: options,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeObserver,
          [observer],
          {#keyPath: keyPath},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [WKUserContentController].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockWKUserContentController extends _i1.Mock
    implements _i4.WKUserContentController {
  MockWKUserContentController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> addScriptMessageHandler(
    _i4.WKScriptMessageHandler? handler,
    String? name,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addScriptMessageHandler,
          [
            handler,
            name,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeScriptMessageHandler(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeScriptMessageHandler,
          [name],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeAllScriptMessageHandlers() => (super.noSuchMethod(
        Invocation.method(
          #removeAllScriptMessageHandlers,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> addUserScript(_i4.WKUserScript? userScript) =>
      (super.noSuchMethod(
        Invocation.method(
          #addUserScript,
          [userScript],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeAllUserScripts() => (super.noSuchMethod(
        Invocation.method(
          #removeAllUserScripts,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i4.WKUserContentController copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeWKUserContentController_3(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i4.WKUserContentController);
  @override
  _i5.Future<void> addObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
    required Set<_i6.NSKeyValueObservingOptions>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addObserver,
          [observer],
          {
            #keyPath: keyPath,
            #options: options,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeObserver,
          [observer],
          {#keyPath: keyPath},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [WKWebsiteDataStore].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockWKWebsiteDataStore extends _i1.Mock
    implements _i4.WKWebsiteDataStore {
  MockWKWebsiteDataStore() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.WKHttpCookieStore get httpCookieStore => (super.noSuchMethod(
        Invocation.getter(#httpCookieStore),
        returnValue: _FakeWKHttpCookieStore_4(
          this,
          Invocation.getter(#httpCookieStore),
        ),
      ) as _i4.WKHttpCookieStore);
  @override
  _i5.Future<bool> removeDataOfTypes(
    Set<_i4.WKWebsiteDataType>? dataTypes,
    DateTime? since,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeDataOfTypes,
          [
            dataTypes,
            since,
          ],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i4.WKWebsiteDataStore copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeWKWebsiteDataStore_5(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i4.WKWebsiteDataStore);
  @override
  _i5.Future<void> addObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
    required Set<_i6.NSKeyValueObservingOptions>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addObserver,
          [observer],
          {
            #keyPath: keyPath,
            #options: options,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeObserver,
          [observer],
          {#keyPath: keyPath},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [WKWebView].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockWKWebView extends _i1.Mock implements _i4.WKWebView {
  MockWKWebView() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.WKWebViewConfiguration get configuration => (super.noSuchMethod(
        Invocation.getter(#configuration),
        returnValue: _FakeWKWebViewConfiguration_6(
          this,
          Invocation.getter(#configuration),
        ),
      ) as _i4.WKWebViewConfiguration);
  @override
  _i3.UIScrollView get scrollView => (super.noSuchMethod(
        Invocation.getter(#scrollView),
        returnValue: _FakeUIScrollView_1(
          this,
          Invocation.getter(#scrollView),
        ),
      ) as _i3.UIScrollView);
  @override
  _i5.Future<void> setUIDelegate(_i4.WKUIDelegate? delegate) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUIDelegate,
          [delegate],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setNavigationDelegate(_i4.WKNavigationDelegate? delegate) =>
      (super.noSuchMethod(
        Invocation.method(
          #setNavigationDelegate,
          [delegate],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<String?> getUrl() => (super.noSuchMethod(
        Invocation.method(
          #getUrl,
          [],
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);
  @override
  _i5.Future<double> getEstimatedProgress() => (super.noSuchMethod(
        Invocation.method(
          #getEstimatedProgress,
          [],
        ),
        returnValue: _i5.Future<double>.value(0.0),
      ) as _i5.Future<double>);
  @override
  _i5.Future<void> loadRequest(_i6.NSUrlRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadRequest,
          [request],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> loadHtmlString(
    String? string, {
    String? baseUrl,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadHtmlString,
          [string],
          {#baseUrl: baseUrl},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> loadFileUrl(
    String? url, {
    required String? readAccessUrl,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadFileUrl,
          [url],
          {#readAccessUrl: readAccessUrl},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> loadFlutterAsset(String? key) => (super.noSuchMethod(
        Invocation.method(
          #loadFlutterAsset,
          [key],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<bool> canGoBack() => (super.noSuchMethod(
        Invocation.method(
          #canGoBack,
          [],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<bool> canGoForward() => (super.noSuchMethod(
        Invocation.method(
          #canGoForward,
          [],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<void> goBack() => (super.noSuchMethod(
        Invocation.method(
          #goBack,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> goForward() => (super.noSuchMethod(
        Invocation.method(
          #goForward,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> reload() => (super.noSuchMethod(
        Invocation.method(
          #reload,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<String?> getTitle() => (super.noSuchMethod(
        Invocation.method(
          #getTitle,
          [],
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);
  @override
  _i5.Future<void> setAllowsBackForwardNavigationGestures(bool? allow) =>
      (super.noSuchMethod(
        Invocation.method(
          #setAllowsBackForwardNavigationGestures,
          [allow],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setCustomUserAgent(String? userAgent) => (super.noSuchMethod(
        Invocation.method(
          #setCustomUserAgent,
          [userAgent],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<Object?> evaluateJavaScript(String? javaScriptString) =>
      (super.noSuchMethod(
        Invocation.method(
          #evaluateJavaScript,
          [javaScriptString],
        ),
        returnValue: _i5.Future<Object?>.value(),
      ) as _i5.Future<Object?>);
  @override
  _i4.WKWebView copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeWKWebView_7(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i4.WKWebView);
  @override
  _i5.Future<void> setBackgroundColor(dynamic color) => (super.noSuchMethod(
        Invocation.method(
          #setBackgroundColor,
          [color],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setOpaque(bool? opaque) => (super.noSuchMethod(
        Invocation.method(
          #setOpaque,
          [opaque],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> addObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
    required Set<_i6.NSKeyValueObservingOptions>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addObserver,
          [observer],
          {
            #keyPath: keyPath,
            #options: options,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeObserver,
          [observer],
          {#keyPath: keyPath},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [WKWebViewConfiguration].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockWKWebViewConfiguration extends _i1.Mock
    implements _i4.WKWebViewConfiguration {
  MockWKWebViewConfiguration() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.WKUserContentController get userContentController => (super.noSuchMethod(
        Invocation.getter(#userContentController),
        returnValue: _FakeWKUserContentController_3(
          this,
          Invocation.getter(#userContentController),
        ),
      ) as _i4.WKUserContentController);
  @override
  _i4.WKPreferences get preferences => (super.noSuchMethod(
        Invocation.getter(#preferences),
        returnValue: _FakeWKPreferences_2(
          this,
          Invocation.getter(#preferences),
        ),
      ) as _i4.WKPreferences);
  @override
  _i4.WKWebsiteDataStore get websiteDataStore => (super.noSuchMethod(
        Invocation.getter(#websiteDataStore),
        returnValue: _FakeWKWebsiteDataStore_5(
          this,
          Invocation.getter(#websiteDataStore),
        ),
      ) as _i4.WKWebsiteDataStore);
  @override
  _i5.Future<void> setAllowsInlineMediaPlayback(bool? allow) =>
      (super.noSuchMethod(
        Invocation.method(
          #setAllowsInlineMediaPlayback,
          [allow],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setMediaTypesRequiringUserActionForPlayback(
          Set<_i4.WKAudiovisualMediaType>? types) =>
      (super.noSuchMethod(
        Invocation.method(
          #setMediaTypesRequiringUserActionForPlayback,
          [types],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i4.WKWebViewConfiguration copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeWKWebViewConfiguration_6(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i4.WKWebViewConfiguration);
  @override
  _i5.Future<void> addObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
    required Set<_i6.NSKeyValueObservingOptions>? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addObserver,
          [observer],
          {
            #keyPath: keyPath,
            #options: options,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeObserver(
    _i6.NSObject? observer, {
    required String? keyPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeObserver,
          [observer],
          {#keyPath: keyPath},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
