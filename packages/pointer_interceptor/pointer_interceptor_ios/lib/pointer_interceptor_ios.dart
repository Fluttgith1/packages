// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:pointer_interceptor_platform_interface/pointer_interceptor_platform_interface.dart';

/// The iOS implementation of the [PointerInterceptorPlatform]
class PointerInterceptorPluginIOS extends PointerInterceptorPlatform {

  static void registerWith() {
    PointerInterceptorPlatform.instance = PointerInterceptorPluginIOS();
  }

  @override
  Widget buildWidget(
      {required Widget child,
      bool intercepting = true,
      bool debug = false,
      Key? key}) {
    return child;
  }
}
