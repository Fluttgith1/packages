// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Flutter
import UIKit

public class InteractiveMediaAdsPlugin: NSObject, FlutterPlugin {
  var proxyApiRegistrar: PigeonProxyApiRegistrar?

  init(binaryMessenger: FlutterBinaryMessenger) {
    proxyApiRegistrar = PigeonProxyApiRegistrar(
      binaryMessenger: binaryMessenger, apiDelegate: ProxyApiDelegate())
    proxyApiRegistrar?.setUp()
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let plugin = InteractiveMediaAdsPlugin(binaryMessenger: registrar.messenger())
    let viewFactory = FlutterViewFactory(instanceManager: plugin.proxyApiRegistrar!.instanceManager)
    registrar.register(viewFactory, withId: "interactive_media_ads.packages.flutter.dev")
    registrar.publish(plugin)
  }

  public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
    proxyApiRegistrar!.tearDown()
    proxyApiRegistrar = nil
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

  }
}
