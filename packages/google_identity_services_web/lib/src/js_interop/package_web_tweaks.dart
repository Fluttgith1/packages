// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Provides some useful tweaks to `package:web`.
library package_web_tweaks;

import 'dart:js_interop';
import 'package:web/web.dart' as web;

/// This extension gives web.window a nullable getter to the `trustedTypes`
/// property, which needs to be used to check for feature support.
extension NullableTrustedTypesGetter on web.Window {
  ///
  @JS('trustedTypes')
  external web.TrustedTypePolicyFactory? get nullableTrustedTypes;
}

/// This extension allows a trusted type policy to create a script URL without
/// the `args` parameter (which in Chrome currently fails).
extension CreateScriptUrlWithoutArgs on web.TrustedTypePolicy {
  ///
  @JS('createScriptURL')
  external web.TrustedScriptURL createScriptURLNoArgs(
    String input,
  );
}

/// This extension allows setting a TrustedScriptURL as the src of a script element,
/// which currently only accepts a string.
extension TrustedTypeSrcAttribute on web.HTMLScriptElement {
  ///
  @JS('src')
  external set srcTT(web.TrustedScriptURL value);
}
