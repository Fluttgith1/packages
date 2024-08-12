// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package dev.flutter.packages.interactive_media_ads

import com.google.ads.interactivemedia.v3.api.AdDisplayContainer
import com.google.ads.interactivemedia.v3.api.player.VideoAdPlayer

/**
 * ProxyApi implementation for [com.google.ads.interactivemedia.v3.api.AdDisplayContainer].
 *
 * <p>This class may handle instantiating native object instances that are attached to a Dart
 * instance or handle method calls on the associated native class or an instance of that class.
 */
class AdDisplayContainerProxyApi(override val pigeonRegistrar: ProxyApiRegistrar) :
    PigeonApiAdDisplayContainer(pigeonRegistrar) {
    override fun getPlayer(pigeon_instance: AdDisplayContainer): VideoAdPlayer {
        return pigeon_instance.player
    }
}
