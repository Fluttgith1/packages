// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.camerax;

import androidx.annotation.NonNull;
import androidx.lifecycle.LifecycleOwner;
import androidx.lifecycle.LiveData;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugins.camerax.GeneratedCameraXLibrary.LiveDataHostApi;
import java.util.Objects;

/**
 * Host API implementation for {@link LiveData}.
 *
 * <p>This class may handle instantiating and adding native object instances that are attached to a
 * Dart instance or handle method calls on the associated native class or an instance of the class.
 */
public class LiveDataHostApiImpl implements LiveDataHostApi {
  private final BinaryMessenger binaryMessenger;
  private final InstanceManager instanceManager;
  private LifecycleOwner lifecycleOwner;

  /**
   * Constructs a {@link LiveDataHostApiImpl}.
   *
   * @param binaryMessenger used to communicate with Dart over asynchronous messages
   * @param instanceManager maintains instances stored to communicate with attached Dart objects
   */
  public LiveDataHostApiImpl(
      @NonNull BinaryMessenger binaryMessenger, @NonNull InstanceManager instanceManager) {
    this.binaryMessenger = binaryMessenger;
    this.instanceManager = instanceManager;
  }

  /** Sets {@link LifecycleOwner} used to observe the camera state if so requested. */
  public void setLifecycleOwner(LifecycleOwner lifecycleOwner) {
    this.lifecycleOwner = lifecycleOwner;
  }

  /**
   * Adds an {@link Observer} with the specified identifier to the observers list of this instance
   * within the lifespan of the {@link lifecycleOwner}.
   */
  @Override
  @SuppressWarnings("unchecked")
  public void observe(@NonNull Long identifier, @NonNull Long observerIdentifier) {
    getLiveDataInstance(identifier)
        .observe(
            lifecycleOwner,
            Objects.requireNonNull(instanceManager.getInstance(observerIdentifier)));
  }

  /**
   * Removes all observers of this instance that are tied to the {@link lifecycleOwner}.
   */
  @Override
  public void removeObservers(@NonNull Long identifier) {
    getLiveDataInstance(identifier).removeObservers(lifecycleOwner);
  }

  /**
   * Re-creates an instance of {@link LiveData} that has been created on the Java side,
   * stored in the Dart {@link InstanceManager} as a generic type, and casted to a
   * specific type on the Dart side.
   * 
   * <p>This method is necessary in order for the Dart wrapped version of this class
   * to be generic since the type of {@link LiveData} created on the Java side is
   * unknown to the Dart side.
   */
  @Override
  public void cast(Long identifier, Long newInstanceIdentifier) {
    instanceManager.addDartCreatedInstance(
        instanceManager.getInstance(identifier), newInstanceIdentifier);
  }

  /** Retrieves the {@link LiveData} instance that has the specified identifier. */
  private LiveData<?> getLiveDataInstance(@NonNull Long identifier) {
    return Objects.requireNonNull(instanceManager.getInstance(identifier));
  }
}
