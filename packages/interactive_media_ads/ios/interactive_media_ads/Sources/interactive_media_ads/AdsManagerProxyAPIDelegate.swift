// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Foundation
import GoogleInteractiveMediaAds

class AdsManagerProxyAPIDelegate: PigeonDelegateIMAAdsManager {
  func setDelegate(
    pigeonApi: PigeonApiIMAAdsManager, pigeonInstance: IMAAdsManager,
    delegate: IMAAdsManagerDelegate?
  ) throws {
    pigeonInstance.delegate = delegate as? AdsManagerDelegateImpl
  }

  func initialize(
    pigeonApi: PigeonApiIMAAdsManager, pigeonInstance: IMAAdsManager,
    adsRenderingSettings: IMAAdsRenderingSettings?
  ) throws {
    pigeonInstance.initialize(with: adsRenderingSettings)
  }

  func start(pigeonApi: PigeonApiIMAAdsManager, pigeonInstance: IMAAdsManager) throws {
    pigeonInstance.start()
  }

  func destroy(pigeonApi: PigeonApiIMAAdsManager, pigeonInstance: IMAAdsManager) throws {
    pigeonInstance.destroy()
  }
}
