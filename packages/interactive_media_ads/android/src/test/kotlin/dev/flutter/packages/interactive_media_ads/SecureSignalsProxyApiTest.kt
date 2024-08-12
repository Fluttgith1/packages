// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package dev.flutter.packages.interactive_media_ads

import com.google.ads.interactivemedia.v3.api.signals.SecureSignals
import kotlin.test.Test
import kotlin.test.assertEquals
import org.mockito.kotlin.mock
import org.mockito.kotlin.whenever

class SecureSignalsProxyApiTest {
  @Test
  fun secureSignal() {
    val api = TestProxyApiRegistrar().getPigeonApiSecureSignals()

    val instance = mock<SecureSignals>()
    val value = "myString"
    whenever(instance.secureSignal).thenReturn(value)

    assertEquals(value, api.secureSignal(instance))
  }
}
