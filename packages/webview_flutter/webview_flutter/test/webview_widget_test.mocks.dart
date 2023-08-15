// Mocks generated by Mockito 5.4.1 from annotations
// in webview_flutter/test/webview_widget_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:ui' as _i3;

import 'package:flutter/foundation.dart' as _i5;
import 'package:flutter/widgets.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:webview_flutter_platform_interface/src/platform_navigation_delegate.dart'
    as _i8;
import 'package:webview_flutter_platform_interface/src/platform_webview_controller.dart'
    as _i6;
import 'package:webview_flutter_platform_interface/src/platform_webview_widget.dart'
    as _i9;
import 'package:webview_flutter_platform_interface/src/types/types.dart' as _i2;

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

class _FakePlatformWebViewControllerCreationParams_0 extends _i1.SmartFake
    implements _i2.PlatformWebViewControllerCreationParams {
  _FakePlatformWebViewControllerCreationParams_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeObject_1 extends _i1.SmartFake implements Object {
  _FakeObject_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOffset_2 extends _i1.SmartFake implements _i3.Offset {
  _FakeOffset_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePlatformWebViewWidgetCreationParams_3 extends _i1.SmartFake
    implements _i2.PlatformWebViewWidgetCreationParams {
  _FakePlatformWebViewWidgetCreationParams_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWidget_4 extends _i1.SmartFake implements _i4.Widget {
  _FakeWidget_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i5.DiagnosticLevel? minLevel = _i5.DiagnosticLevel.info}) =>
      super.toString();
}

/// A class which mocks [PlatformWebViewController].
///
/// See the documentation for Mockito's code generation for more information.
class MockPlatformWebViewController extends _i1.Mock
    implements _i6.PlatformWebViewController {
  MockPlatformWebViewController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PlatformWebViewControllerCreationParams get params => (super.noSuchMethod(
        Invocation.getter(#params),
        returnValue: _FakePlatformWebViewControllerCreationParams_0(
          this,
          Invocation.getter(#params),
        ),
      ) as _i2.PlatformWebViewControllerCreationParams);
  @override
  _i7.Future<void> loadFile(String? absoluteFilePath) => (super.noSuchMethod(
        Invocation.method(
          #loadFile,
          [absoluteFilePath],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> loadFlutterAsset(String? key) => (super.noSuchMethod(
        Invocation.method(
          #loadFlutterAsset,
          [key],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> loadHtmlString(
    String? html, {
    String? baseUrl,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadHtmlString,
          [html],
          {#baseUrl: baseUrl},
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> loadRequest(_i2.LoadRequestParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadRequest,
          [params],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<String?> currentUrl() => (super.noSuchMethod(
        Invocation.method(
          #currentUrl,
          [],
        ),
        returnValue: _i7.Future<String?>.value(),
      ) as _i7.Future<String?>);
  @override
  _i7.Future<bool> canGoBack() => (super.noSuchMethod(
        Invocation.method(
          #canGoBack,
          [],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<bool> canGoForward() => (super.noSuchMethod(
        Invocation.method(
          #canGoForward,
          [],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<void> goBack() => (super.noSuchMethod(
        Invocation.method(
          #goBack,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> goForward() => (super.noSuchMethod(
        Invocation.method(
          #goForward,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> reload() => (super.noSuchMethod(
        Invocation.method(
          #reload,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> clearCache() => (super.noSuchMethod(
        Invocation.method(
          #clearCache,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> clearLocalStorage() => (super.noSuchMethod(
        Invocation.method(
          #clearLocalStorage,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> setPlatformNavigationDelegate(
          _i8.PlatformNavigationDelegate? handler) =>
      (super.noSuchMethod(
        Invocation.method(
          #setPlatformNavigationDelegate,
          [handler],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> runJavaScript(String? javaScript) => (super.noSuchMethod(
        Invocation.method(
          #runJavaScript,
          [javaScript],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<Object> runJavaScriptReturningResult(String? javaScript) =>
      (super.noSuchMethod(
        Invocation.method(
          #runJavaScriptReturningResult,
          [javaScript],
        ),
        returnValue: _i7.Future<Object>.value(_FakeObject_1(
          this,
          Invocation.method(
            #runJavaScriptReturningResult,
            [javaScript],
          ),
        )),
      ) as _i7.Future<Object>);
  @override
  _i7.Future<void> addJavaScriptChannel(
          _i6.JavaScriptChannelParams? javaScriptChannelParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #addJavaScriptChannel,
          [javaScriptChannelParams],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> removeJavaScriptChannel(String? javaScriptChannelName) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeJavaScriptChannel,
          [javaScriptChannelName],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<String?> getTitle() => (super.noSuchMethod(
        Invocation.method(
          #getTitle,
          [],
        ),
        returnValue: _i7.Future<String?>.value(),
      ) as _i7.Future<String?>);
  @override
  _i7.Future<void> scrollTo(
    int? x,
    int? y,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #scrollTo,
          [
            x,
            y,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> scrollBy(
    int? x,
    int? y,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #scrollBy,
          [
            x,
            y,
          ],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<_i3.Offset> getScrollPosition() => (super.noSuchMethod(
        Invocation.method(
          #getScrollPosition,
          [],
        ),
        returnValue: _i7.Future<_i3.Offset>.value(_FakeOffset_2(
          this,
          Invocation.method(
            #getScrollPosition,
            [],
          ),
        )),
      ) as _i7.Future<_i3.Offset>);
  @override
  _i7.Future<void> enableZoom(bool? enabled) => (super.noSuchMethod(
        Invocation.method(
          #enableZoom,
          [enabled],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> setBackgroundColor(_i3.Color? color) => (super.noSuchMethod(
        Invocation.method(
          #setBackgroundColor,
          [color],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> setJavaScriptMode(_i2.JavaScriptMode? javaScriptMode) =>
      (super.noSuchMethod(
        Invocation.method(
          #setJavaScriptMode,
          [javaScriptMode],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> setUserAgent(String? userAgent) => (super.noSuchMethod(
        Invocation.method(
          #setUserAgent,
          [userAgent],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> setOnPlatformPermissionRequest(
          void Function(_i2.PlatformWebViewPermissionRequest)?
              onPermissionRequest) =>
      (super.noSuchMethod(
        Invocation.method(
          #setOnPlatformPermissionRequest,
          [onPermissionRequest],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> setOnConsoleMessage(
          void Function(_i2.JavaScriptConsoleMessage)? onConsoleMessage) =>
      (super.noSuchMethod(
        Invocation.method(
          #setOnConsoleMessage,
          [onConsoleMessage],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [PlatformWebViewWidget].
///
/// See the documentation for Mockito's code generation for more information.
class MockPlatformWebViewWidget extends _i1.Mock
    implements _i9.PlatformWebViewWidget {
  MockPlatformWebViewWidget() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PlatformWebViewWidgetCreationParams get params => (super.noSuchMethod(
        Invocation.getter(#params),
        returnValue: _FakePlatformWebViewWidgetCreationParams_3(
          this,
          Invocation.getter(#params),
        ),
      ) as _i2.PlatformWebViewWidgetCreationParams);
  @override
  _i4.Widget build(_i4.BuildContext? context) => (super.noSuchMethod(
        Invocation.method(
          #build,
          [context],
        ),
        returnValue: _FakeWidget_4(
          this,
          Invocation.method(
            #build,
            [context],
          ),
        ),
      ) as _i4.Widget);
}
