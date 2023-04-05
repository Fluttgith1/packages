// Mocks generated by Mockito 5.4.0 from annotations
// in webview_flutter_android/test/android_webview_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i7;
import 'dart:ui' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:webview_flutter_android/src/android_webview.dart' as _i2;
import 'package:webview_flutter_android/src/android_webview.g.dart' as _i3;

import 'test_android_webview.g.dart' as _i6;

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

class _FakeDownloadListener_0 extends _i1.SmartFake
    implements _i2.DownloadListener {
  _FakeDownloadListener_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeJavaScriptChannel_1 extends _i1.SmartFake
    implements _i2.JavaScriptChannel {
  _FakeJavaScriptChannel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWebViewPoint_2 extends _i1.SmartFake implements _i3.WebViewPoint {
  _FakeWebViewPoint_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWebChromeClient_3 extends _i1.SmartFake
    implements _i2.WebChromeClient {
  _FakeWebChromeClient_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWebSettings_4 extends _i1.SmartFake implements _i2.WebSettings {
  _FakeWebSettings_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOffset_5 extends _i1.SmartFake implements _i4.Offset {
  _FakeOffset_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWebView_6 extends _i1.SmartFake implements _i2.WebView {
  _FakeWebView_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWebViewClient_7 extends _i1.SmartFake implements _i2.WebViewClient {
  _FakeWebViewClient_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CookieManagerHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockCookieManagerHostApi extends _i1.Mock
    implements _i3.CookieManagerHostApi {
  MockCookieManagerHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> clearCookies() => (super.noSuchMethod(
        Invocation.method(
          #clearCookies,
          [],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<void> setCookie(
    String? arg_url,
    String? arg_value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setCookie,
          [
            arg_url,
            arg_value,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [DownloadListener].
///
/// See the documentation for Mockito's code generation for more information.
class MockDownloadListener extends _i1.Mock implements _i2.DownloadListener {
  MockDownloadListener() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void Function(
    String,
    String,
    String,
    String,
    int,
  ) get onDownloadStart => (super.noSuchMethod(
        Invocation.getter(#onDownloadStart),
        returnValue: (
          String url,
          String userAgent,
          String contentDisposition,
          String mimetype,
          int contentLength,
        ) {},
      ) as void Function(
        String,
        String,
        String,
        String,
        int,
      ));
  @override
  _i2.DownloadListener copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeDownloadListener_0(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i2.DownloadListener);
}

/// A class which mocks [JavaScriptChannel].
///
/// See the documentation for Mockito's code generation for more information.
class MockJavaScriptChannel extends _i1.Mock implements _i2.JavaScriptChannel {
  MockJavaScriptChannel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get channelName => (super.noSuchMethod(
        Invocation.getter(#channelName),
        returnValue: '',
      ) as String);
  @override
  void Function(String) get postMessage => (super.noSuchMethod(
        Invocation.getter(#postMessage),
        returnValue: (String message) {},
      ) as void Function(String));
  @override
  _i2.JavaScriptChannel copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeJavaScriptChannel_1(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i2.JavaScriptChannel);
}

/// A class which mocks [TestDownloadListenerHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestDownloadListenerHostApi extends _i1.Mock
    implements _i6.TestDownloadListenerHostApi {
  MockTestDownloadListenerHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void create(int? instanceId) => super.noSuchMethod(
        Invocation.method(
          #create,
          [instanceId],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestGeolocationPermissionsCallbackHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestGeolocationPermissionsCallbackHostApi extends _i1.Mock
    implements _i6.TestGeolocationPermissionsCallbackHostApi {
  MockTestGeolocationPermissionsCallbackHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void invoke(
    int? instanceId,
    String? origin,
    bool? allow,
    bool? retain,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #invoke,
          [
            instanceId,
            origin,
            allow,
            retain,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestInstanceManagerHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestInstanceManagerHostApi extends _i1.Mock
    implements _i6.TestInstanceManagerHostApi {
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

/// A class which mocks [TestJavaObjectHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestJavaObjectHostApi extends _i1.Mock
    implements _i6.TestJavaObjectHostApi {
  MockTestJavaObjectHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void dispose(int? identifier) => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [identifier],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestJavaScriptChannelHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestJavaScriptChannelHostApi extends _i1.Mock
    implements _i6.TestJavaScriptChannelHostApi {
  MockTestJavaScriptChannelHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void create(
    int? instanceId,
    String? channelName,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #create,
          [
            instanceId,
            channelName,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestWebChromeClientHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestWebChromeClientHostApi extends _i1.Mock
    implements _i6.TestWebChromeClientHostApi {
  MockTestWebChromeClientHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void create(int? instanceId) => super.noSuchMethod(
        Invocation.method(
          #create,
          [instanceId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setSynchronousReturnValueForOnShowFileChooser(
    int? instanceId,
    bool? value,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setSynchronousReturnValueForOnShowFileChooser,
          [
            instanceId,
            value,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestWebSettingsHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestWebSettingsHostApi extends _i1.Mock
    implements _i6.TestWebSettingsHostApi {
  MockTestWebSettingsHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void create(
    int? instanceId,
    int? webViewInstanceId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #create,
          [
            instanceId,
            webViewInstanceId,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setDomStorageEnabled(
    int? instanceId,
    bool? flag,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setDomStorageEnabled,
          [
            instanceId,
            flag,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setJavaScriptCanOpenWindowsAutomatically(
    int? instanceId,
    bool? flag,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setJavaScriptCanOpenWindowsAutomatically,
          [
            instanceId,
            flag,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setSupportMultipleWindows(
    int? instanceId,
    bool? support,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setSupportMultipleWindows,
          [
            instanceId,
            support,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setJavaScriptEnabled(
    int? instanceId,
    bool? flag,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setJavaScriptEnabled,
          [
            instanceId,
            flag,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setUserAgentString(
    int? instanceId,
    String? userAgentString,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setUserAgentString,
          [
            instanceId,
            userAgentString,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setMediaPlaybackRequiresUserGesture(
    int? instanceId,
    bool? require,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setMediaPlaybackRequiresUserGesture,
          [
            instanceId,
            require,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setSupportZoom(
    int? instanceId,
    bool? support,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setSupportZoom,
          [
            instanceId,
            support,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setLoadWithOverviewMode(
    int? instanceId,
    bool? overview,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setLoadWithOverviewMode,
          [
            instanceId,
            overview,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setUseWideViewPort(
    int? instanceId,
    bool? use,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setUseWideViewPort,
          [
            instanceId,
            use,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setDisplayZoomControls(
    int? instanceId,
    bool? enabled,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setDisplayZoomControls,
          [
            instanceId,
            enabled,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setBuiltInZoomControls(
    int? instanceId,
    bool? enabled,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setBuiltInZoomControls,
          [
            instanceId,
            enabled,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setAllowFileAccess(
    int? instanceId,
    bool? enabled,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setAllowFileAccess,
          [
            instanceId,
            enabled,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setTextZoom(
    int? instanceId,
    int? textZoom,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setTextZoom,
          [
            instanceId,
            textZoom,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestWebStorageHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestWebStorageHostApi extends _i1.Mock
    implements _i6.TestWebStorageHostApi {
  MockTestWebStorageHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void create(int? instanceId) => super.noSuchMethod(
        Invocation.method(
          #create,
          [instanceId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void deleteAllData(int? instanceId) => super.noSuchMethod(
        Invocation.method(
          #deleteAllData,
          [instanceId],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestWebViewClientHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestWebViewClientHostApi extends _i1.Mock
    implements _i6.TestWebViewClientHostApi {
  MockTestWebViewClientHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void create(int? instanceId) => super.noSuchMethod(
        Invocation.method(
          #create,
          [instanceId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setSynchronousReturnValueForShouldOverrideUrlLoading(
    int? instanceId,
    bool? value,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setSynchronousReturnValueForShouldOverrideUrlLoading,
          [
            instanceId,
            value,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestWebViewHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestWebViewHostApi extends _i1.Mock
    implements _i6.TestWebViewHostApi {
  MockTestWebViewHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void create(int? instanceId) => super.noSuchMethod(
        Invocation.method(
          #create,
          [instanceId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void loadData(
    int? instanceId,
    String? data,
    String? mimeType,
    String? encoding,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #loadData,
          [
            instanceId,
            data,
            mimeType,
            encoding,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void loadDataWithBaseUrl(
    int? instanceId,
    String? baseUrl,
    String? data,
    String? mimeType,
    String? encoding,
    String? historyUrl,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #loadDataWithBaseUrl,
          [
            instanceId,
            baseUrl,
            data,
            mimeType,
            encoding,
            historyUrl,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void loadUrl(
    int? instanceId,
    String? url,
    Map<String?, String?>? headers,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #loadUrl,
          [
            instanceId,
            url,
            headers,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void postUrl(
    int? instanceId,
    String? url,
    _i7.Uint8List? data,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #postUrl,
          [
            instanceId,
            url,
            data,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  String? getUrl(int? instanceId) => (super.noSuchMethod(Invocation.method(
        #getUrl,
        [instanceId],
      )) as String?);
  @override
  bool canGoBack(int? instanceId) => (super.noSuchMethod(
        Invocation.method(
          #canGoBack,
          [instanceId],
        ),
        returnValue: false,
      ) as bool);
  @override
  bool canGoForward(int? instanceId) => (super.noSuchMethod(
        Invocation.method(
          #canGoForward,
          [instanceId],
        ),
        returnValue: false,
      ) as bool);
  @override
  void goBack(int? instanceId) => super.noSuchMethod(
        Invocation.method(
          #goBack,
          [instanceId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void goForward(int? instanceId) => super.noSuchMethod(
        Invocation.method(
          #goForward,
          [instanceId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void reload(int? instanceId) => super.noSuchMethod(
        Invocation.method(
          #reload,
          [instanceId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void clearCache(
    int? instanceId,
    bool? includeDiskFiles,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #clearCache,
          [
            instanceId,
            includeDiskFiles,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<String?> evaluateJavascript(
    int? instanceId,
    String? javascriptString,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #evaluateJavascript,
          [
            instanceId,
            javascriptString,
          ],
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);
  @override
  String? getTitle(int? instanceId) => (super.noSuchMethod(Invocation.method(
        #getTitle,
        [instanceId],
      )) as String?);
  @override
  void scrollTo(
    int? instanceId,
    int? x,
    int? y,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #scrollTo,
          [
            instanceId,
            x,
            y,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void scrollBy(
    int? instanceId,
    int? x,
    int? y,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #scrollBy,
          [
            instanceId,
            x,
            y,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  int getScrollX(int? instanceId) => (super.noSuchMethod(
        Invocation.method(
          #getScrollX,
          [instanceId],
        ),
        returnValue: 0,
      ) as int);
  @override
  int getScrollY(int? instanceId) => (super.noSuchMethod(
        Invocation.method(
          #getScrollY,
          [instanceId],
        ),
        returnValue: 0,
      ) as int);
  @override
  _i3.WebViewPoint getScrollPosition(int? instanceId) => (super.noSuchMethod(
        Invocation.method(
          #getScrollPosition,
          [instanceId],
        ),
        returnValue: _FakeWebViewPoint_2(
          this,
          Invocation.method(
            #getScrollPosition,
            [instanceId],
          ),
        ),
      ) as _i3.WebViewPoint);
  @override
  void setWebContentsDebuggingEnabled(bool? enabled) => super.noSuchMethod(
        Invocation.method(
          #setWebContentsDebuggingEnabled,
          [enabled],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setWebViewClient(
    int? instanceId,
    int? webViewClientInstanceId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setWebViewClient,
          [
            instanceId,
            webViewClientInstanceId,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addJavaScriptChannel(
    int? instanceId,
    int? javaScriptChannelInstanceId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #addJavaScriptChannel,
          [
            instanceId,
            javaScriptChannelInstanceId,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeJavaScriptChannel(
    int? instanceId,
    int? javaScriptChannelInstanceId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #removeJavaScriptChannel,
          [
            instanceId,
            javaScriptChannelInstanceId,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setDownloadListener(
    int? instanceId,
    int? listenerInstanceId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setDownloadListener,
          [
            instanceId,
            listenerInstanceId,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setWebChromeClient(
    int? instanceId,
    int? clientInstanceId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setWebChromeClient,
          [
            instanceId,
            clientInstanceId,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setBackgroundColor(
    int? instanceId,
    int? color,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setBackgroundColor,
          [
            instanceId,
            color,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestAssetManagerHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestAssetManagerHostApi extends _i1.Mock
    implements _i6.TestAssetManagerHostApi {
  MockTestAssetManagerHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<String?> list(String? path) => (super.noSuchMethod(
        Invocation.method(
          #list,
          [path],
        ),
        returnValue: <String?>[],
      ) as List<String?>);
  @override
  String getAssetFilePathByName(String? name) => (super.noSuchMethod(
        Invocation.method(
          #getAssetFilePathByName,
          [name],
        ),
        returnValue: '',
      ) as String);
}

/// A class which mocks [WebChromeClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockWebChromeClient extends _i1.Mock implements _i2.WebChromeClient {
  MockWebChromeClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> setSynchronousReturnValueForOnShowFileChooser(bool? value) =>
      (super.noSuchMethod(
        Invocation.method(
          #setSynchronousReturnValueForOnShowFileChooser,
          [value],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i2.WebChromeClient copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeWebChromeClient_3(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i2.WebChromeClient);
}

/// A class which mocks [WebView].
///
/// See the documentation for Mockito's code generation for more information.
class MockWebView extends _i1.Mock implements _i2.WebView {
  MockWebView() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WebSettings get settings => (super.noSuchMethod(
        Invocation.getter(#settings),
        returnValue: _FakeWebSettings_4(
          this,
          Invocation.getter(#settings),
        ),
      ) as _i2.WebSettings);
  @override
  _i5.Future<void> loadData({
    required String? data,
    String? mimeType,
    String? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadData,
          [],
          {
            #data: data,
            #mimeType: mimeType,
            #encoding: encoding,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> loadDataWithBaseUrl({
    String? baseUrl,
    required String? data,
    String? mimeType,
    String? encoding,
    String? historyUrl,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadDataWithBaseUrl,
          [],
          {
            #baseUrl: baseUrl,
            #data: data,
            #mimeType: mimeType,
            #encoding: encoding,
            #historyUrl: historyUrl,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> loadUrl(
    String? url,
    Map<String, String>? headers,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadUrl,
          [
            url,
            headers,
          ],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> postUrl(
    String? url,
    _i7.Uint8List? data,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #postUrl,
          [
            url,
            data,
          ],
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
  _i5.Future<void> clearCache(bool? includeDiskFiles) => (super.noSuchMethod(
        Invocation.method(
          #clearCache,
          [includeDiskFiles],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<String?> evaluateJavascript(String? javascriptString) =>
      (super.noSuchMethod(
        Invocation.method(
          #evaluateJavascript,
          [javascriptString],
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);
  @override
  _i5.Future<String?> getTitle() => (super.noSuchMethod(
        Invocation.method(
          #getTitle,
          [],
        ),
        returnValue: _i5.Future<String?>.value(),
      ) as _i5.Future<String?>);
  @override
  _i5.Future<void> scrollTo(
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
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> scrollBy(
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
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<int> getScrollX() => (super.noSuchMethod(
        Invocation.method(
          #getScrollX,
          [],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<int> getScrollY() => (super.noSuchMethod(
        Invocation.method(
          #getScrollY,
          [],
        ),
        returnValue: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);
  @override
  _i5.Future<_i4.Offset> getScrollPosition() => (super.noSuchMethod(
        Invocation.method(
          #getScrollPosition,
          [],
        ),
        returnValue: _i5.Future<_i4.Offset>.value(_FakeOffset_5(
          this,
          Invocation.method(
            #getScrollPosition,
            [],
          ),
        )),
      ) as _i5.Future<_i4.Offset>);
  @override
  _i5.Future<void> setWebViewClient(_i2.WebViewClient? webViewClient) =>
      (super.noSuchMethod(
        Invocation.method(
          #setWebViewClient,
          [webViewClient],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> addJavaScriptChannel(
          _i2.JavaScriptChannel? javaScriptChannel) =>
      (super.noSuchMethod(
        Invocation.method(
          #addJavaScriptChannel,
          [javaScriptChannel],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> removeJavaScriptChannel(
          _i2.JavaScriptChannel? javaScriptChannel) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeJavaScriptChannel,
          [javaScriptChannel],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setDownloadListener(_i2.DownloadListener? listener) =>
      (super.noSuchMethod(
        Invocation.method(
          #setDownloadListener,
          [listener],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setWebChromeClient(_i2.WebChromeClient? client) =>
      (super.noSuchMethod(
        Invocation.method(
          #setWebChromeClient,
          [client],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> setBackgroundColor(_i4.Color? color) => (super.noSuchMethod(
        Invocation.method(
          #setBackgroundColor,
          [color],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i2.WebView copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeWebView_6(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i2.WebView);
}

/// A class which mocks [WebViewClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockWebViewClient extends _i1.Mock implements _i2.WebViewClient {
  MockWebViewClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> setSynchronousReturnValueForShouldOverrideUrlLoading(
          bool? value) =>
      (super.noSuchMethod(
        Invocation.method(
          #setSynchronousReturnValueForShouldOverrideUrlLoading,
          [value],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i2.WebViewClient copy() => (super.noSuchMethod(
        Invocation.method(
          #copy,
          [],
        ),
        returnValue: _FakeWebViewClient_7(
          this,
          Invocation.method(
            #copy,
            [],
          ),
        ),
      ) as _i2.WebViewClient);
}
