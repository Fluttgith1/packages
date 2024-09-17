// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.webviewflutter;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

import android.webkit.GeolocationPermissions;
import io.flutter.plugin.common.BinaryMessenger;
import java.util.Objects;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

public class GeolocationPermissionsCallbackTest {
  @Test
  public void invoke() {
    final PigeonApiGeolocationPermissionsCallback api = new TestProxyApiRegistrar().getPigeonApiGeolocationPermissionsCallback();

    final GeolocationPermissions.Callback instance = mock(GeolocationPermissions.Callback.class);
    final String origin = "myString";
    final boolean allow = true;
    final boolean retain = true;
    api.invoke(instance, origin, allow, retain);

    verify(instance).invoke(origin, allow, retain);
  }
}
