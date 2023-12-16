// Mocks generated by Mockito 5.4.3 from annotations
// in webview_flutter_web/test/legacy/webview_flutter_web_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;

import 'package:flutter/foundation.dart' as _i3;
import 'package:flutter/src/widgets/notification_listener.dart' as _i6;
import 'package:flutter/widgets.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:web/src/dom/html.dart' as _i5;
import 'package:web/src/dom/xhr.dart' as _i4;
import 'package:webview_flutter_platform_interface/src/legacy/platform_interface/webview_platform_callbacks_handler.dart'
    as _i8;
import 'package:webview_flutter_platform_interface/src/legacy/types/types.dart'
    as _i7;
import 'package:webview_flutter_web/src/http_request_factory.dart' as _i10;

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

class _FakeWidget_0 extends _i1.SmartFake implements _i2.Widget {
  _FakeWidget_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedWidget_1 extends _i1.SmartFake
    implements _i2.InheritedWidget {
  _FakeInheritedWidget_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_2 extends _i1.SmartFake
    implements _i3.DiagnosticsNode {
  _FakeDiagnosticsNode_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({
    _i3.TextTreeConfiguration? parentConfiguration,
    _i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info,
  }) =>
      super.toString();
}

class _FakeXMLHttpRequest_3 extends _i1.SmartFake
    implements _i4.XMLHttpRequest {
  _FakeXMLHttpRequest_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HTMLIFrameElement].
///
/// See the documentation for Mockito's code generation for more information.
class MockHTMLIFrameElement extends _i1.Mock implements _i5.HTMLIFrameElement {
  MockHTMLIFrameElement() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [BuildContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockBuildContext extends _i1.Mock implements _i2.BuildContext {
  MockBuildContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Widget get widget => (super.noSuchMethod(
        Invocation.getter(#widget),
        returnValue: _FakeWidget_0(
          this,
          Invocation.getter(#widget),
        ),
      ) as _i2.Widget);

  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
      ) as bool);

  @override
  bool get debugDoingBuild => (super.noSuchMethod(
        Invocation.getter(#debugDoingBuild),
        returnValue: false,
      ) as bool);

  @override
  _i2.InheritedWidget dependOnInheritedElement(
    _i2.InheritedElement? ancestor, {
    Object? aspect,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #dependOnInheritedElement,
          [ancestor],
          {#aspect: aspect},
        ),
        returnValue: _FakeInheritedWidget_1(
          this,
          Invocation.method(
            #dependOnInheritedElement,
            [ancestor],
            {#aspect: aspect},
          ),
        ),
      ) as _i2.InheritedWidget);

  @override
  void visitAncestorElements(_i2.ConditionalElementVisitor? visitor) =>
      super.noSuchMethod(
        Invocation.method(
          #visitAncestorElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void visitChildElements(_i2.ElementVisitor? visitor) => super.noSuchMethod(
        Invocation.method(
          #visitChildElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispatchNotification(_i6.Notification? notification) =>
      super.noSuchMethod(
        Invocation.method(
          #dispatchNotification,
          [notification],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.DiagnosticsNode describeElement(
    String? name, {
    _i3.DiagnosticsTreeStyle? style = _i3.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeElement,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #describeElement,
            [name],
            {#style: style},
          ),
        ),
      ) as _i3.DiagnosticsNode);

  @override
  _i3.DiagnosticsNode describeWidget(
    String? name, {
    _i3.DiagnosticsTreeStyle? style = _i3.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeWidget,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #describeWidget,
            [name],
            {#style: style},
          ),
        ),
      ) as _i3.DiagnosticsNode);

  @override
  List<_i3.DiagnosticsNode> describeMissingAncestor(
          {required Type? expectedAncestorType}) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeMissingAncestor,
          [],
          {#expectedAncestorType: expectedAncestorType},
        ),
        returnValue: <_i3.DiagnosticsNode>[],
      ) as List<_i3.DiagnosticsNode>);

  @override
  _i3.DiagnosticsNode describeOwnershipChain(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeOwnershipChain,
          [name],
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #describeOwnershipChain,
            [name],
          ),
        ),
      ) as _i3.DiagnosticsNode);
}

/// A class which mocks [CreationParams].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreationParams extends _i1.Mock implements _i7.CreationParams {
  MockCreationParams() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Set<String> get javascriptChannelNames => (super.noSuchMethod(
        Invocation.getter(#javascriptChannelNames),
        returnValue: <String>{},
      ) as Set<String>);

  @override
  _i7.AutoMediaPlaybackPolicy get autoMediaPlaybackPolicy =>
      (super.noSuchMethod(
        Invocation.getter(#autoMediaPlaybackPolicy),
        returnValue:
            _i7.AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
      ) as _i7.AutoMediaPlaybackPolicy);

  @override
  List<_i7.WebViewCookie> get cookies => (super.noSuchMethod(
        Invocation.getter(#cookies),
        returnValue: <_i7.WebViewCookie>[],
      ) as List<_i7.WebViewCookie>);
}

/// A class which mocks [WebViewPlatformCallbacksHandler].
///
/// See the documentation for Mockito's code generation for more information.
class MockWebViewPlatformCallbacksHandler extends _i1.Mock
    implements _i8.WebViewPlatformCallbacksHandler {
  MockWebViewPlatformCallbacksHandler() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.FutureOr<bool> onNavigationRequest({
    required String? url,
    required bool? isForMainFrame,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #onNavigationRequest,
          [],
          {
            #url: url,
            #isForMainFrame: isForMainFrame,
          },
        ),
        returnValue: _i9.Future<bool>.value(false),
      ) as _i9.FutureOr<bool>);

  @override
  void onPageStarted(String? url) => super.noSuchMethod(
        Invocation.method(
          #onPageStarted,
          [url],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onPageFinished(String? url) => super.noSuchMethod(
        Invocation.method(
          #onPageFinished,
          [url],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onProgress(int? progress) => super.noSuchMethod(
        Invocation.method(
          #onProgress,
          [progress],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onWebResourceError(_i7.WebResourceError? error) => super.noSuchMethod(
        Invocation.method(
          #onWebResourceError,
          [error],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [HttpRequestFactory].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpRequestFactory extends _i1.Mock
    implements _i10.HttpRequestFactory {
  MockHttpRequestFactory() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i4.XMLHttpRequest> request(
    String? url, {
    String? method,
    bool? withCredentials,
    String? responseType,
    String? mimeType,
    Map<String, String>? requestHeaders,
    dynamic sendData,
    void Function(_i4.ProgressEvent)? onProgress,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #request,
          [url],
          {
            #method: method,
            #withCredentials: withCredentials,
            #responseType: responseType,
            #mimeType: mimeType,
            #requestHeaders: requestHeaders,
            #sendData: sendData,
            #onProgress: onProgress,
          },
        ),
        returnValue: _i9.Future<_i4.XMLHttpRequest>.value(_FakeXMLHttpRequest_3(
          this,
          Invocation.method(
            #request,
            [url],
            {
              #method: method,
              #withCredentials: withCredentials,
              #responseType: responseType,
              #mimeType: mimeType,
              #requestHeaders: requestHeaders,
              #sendData: sendData,
              #onProgress: onProgress,
            },
          ),
        )),
      ) as _i9.Future<_i4.XMLHttpRequest>);
}

/// A class which mocks [XMLHttpRequest].
///
/// See the documentation for Mockito's code generation for more information.
class MockXMLHttpRequest extends _i1.Mock implements _i4.XMLHttpRequest {
  MockXMLHttpRequest() {
    _i1.throwOnMissingStub(this);
  }
}
