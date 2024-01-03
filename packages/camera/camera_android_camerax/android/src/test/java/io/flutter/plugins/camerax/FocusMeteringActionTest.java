// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.camerax;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.spy;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import android.content.Context;
import androidx.camera.core.FocusMeteringAction;
import com.google.common.util.concurrent.FutureCallback;
import com.google.common.util.concurrent.Futures;
import com.google.common.util.concurrent.ListenableFuture;
import io.flutter.plugin.common.BinaryMessenger;
import java.util.Objects;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

public class FocusMeteringActionTest {
  @Rule public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock public BinaryMessenger mockBinaryMessenger;
  @Mock public FocusMeteringAction focusMeteringAction;

  InstanceManager testInstanceManager;

  @Before
  public void setUp() {
    testInstanceManager = InstanceManager.create(identifier -> {});
  }

  @After
  public void tearDown() {
    testInstanceManager.stopFinalizationListener();
  }

  @Test
  public void hostApiCreate_createsExpectedFocusMeteringAction() {
    // here
  }

  @Test
  public void flutterApiCreate_makesCallToCreateInstanceOnDartSide() {
    final FocusMeteringActionFlutterApiImpl spyFlutterApi =
        spy(new FocusMeteringActionFlutterApiImpl(mockBinaryMessenger, testInstanceManager));

    spyFlutterApi.create(focusMeteringAction, reply -> {});

    final long focusMeteringActionIdentifier =
        Objects.requireNonNull(testInstanceManager.getIdentifierForStrongReference(focusMeteringAction));
    verify(spyFlutterApi).create(eq(focusMeteringActionIdentifier), any());
  }
}