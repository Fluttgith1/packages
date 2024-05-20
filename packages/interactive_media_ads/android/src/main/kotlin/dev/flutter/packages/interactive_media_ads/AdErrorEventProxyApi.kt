// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package dev.flutter.packages.interactive_media_ads

import com.google.ads.interactivemedia.v3.api.AdError
import com.google.ads.interactivemedia.v3.api.AdErrorEvent

class AdErrorEventProxyApi(override val pigeonRegistrar: ProxyApiRegistrar) :
    PigeonApiAdErrorEvent(pigeonRegistrar) {
  override fun error(pigeon_instance: AdErrorEvent): AdError {
    return pigeon_instance.error
  }
}
