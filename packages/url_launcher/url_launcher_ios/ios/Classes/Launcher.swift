// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Protocol for UIApplication methods relating to launching URLs.
///
/// This protocol exists to allow injecting an alternate implementation for testing.
protocol Launcher {
  func canOpenURL(_ url: URL) -> Bool
  func openURL(
    _ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any],
    completionHandler completion: ((Bool) -> Void)?)
}

/// Default implementation of Launcher, using UIApplication.
final class UIApplicationLauncher: Launcher {
  func canOpenURL(_ url: URL) -> Bool {
    UIApplication.shared.canOpenURL(url)
  }

  func openURL(
    _ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any],
    completionHandler completion: ((Bool) -> Void)?
  ) {
    UIApplication.shared.open(url, options: options, completionHandler: completion)
  }
}
