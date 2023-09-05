// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:pointer_interceptor_platform_interface/pointer_interceptor_platform_interface.dart';

const String _viewType = '__webPointerInterceptorViewType__';
const String _debug = 'debug__';

// Computes a "view type" for different configurations of the widget.
String _getViewType({bool debug = false}) {
  return debug ? _viewType + _debug : _viewType;
}

// Registers a viewFactory for this widget.
void _registerFactory({bool debug = false}) {
  final String viewType = _getViewType(debug: debug);
  ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
    final html.Element htmlElement = html.DivElement()
      ..style.width = '100%'
      ..style.height = '100%';
    if (debug) {
      htmlElement.style.backgroundColor = 'rgba(255, 0, 0, .5)';
    }
    return htmlElement;
  }, isVisible: false);
}

/// The web implementation of the [PointerInterceptorPlatform]
class PointerInterceptorPlugin extends PointerInterceptorPlatform {
  /// Register for the web plugin.
  static void registerWith(Registrar registrar) {
    PointerInterceptorPlatform.instance = PointerInterceptorPlugin();
  }

  @override
  Widget buildWidget(
      {required Widget child,
      bool intercepting = true,
      bool debug = false,
      Key? key}) {
    if (!_registered) {
      _register();
    }
    if (!intercepting) {
      return child;
    }

    final String viewType = _getViewType(debug: debug);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
          child: HtmlElementView(
            viewType: viewType,
          ),
        ),
        child,
      ],
    );
  }

  // Keeps track if this widget has already registered its view factories or not.
  static bool _registered = false;

  // Registers the view factories for the interceptor widgets.
  static void _register() {
    assert(!_registered);

    _registerFactory();
    _registerFactory(debug: true);

    _registered = true;
  }
}
