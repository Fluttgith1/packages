// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package dev.flutter.packages.file_selector_android;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

/** FileSelectorAndroidPlugin */
public class FileSelectorAndroidPlugin implements FlutterPlugin, ActivityAware {
  @Nullable
  private FileSelectorApiImpl fileSelectorApi;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {

  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    fileSelectorApi = new FileSelectorApiImpl(binding);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    if (fileSelectorApi != null) {
      fileSelectorApi.setActivityPluginBinding(null);
    }
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    if (fileSelectorApi != null) {
      fileSelectorApi.setActivityPluginBinding(binding);
    } else {
      fileSelectorApi = new FileSelectorApiImpl(binding);
    }
  }

  @Override
  public void onDetachedFromActivity() {
    if (fileSelectorApi != null) {
      fileSelectorApi.setActivityPluginBinding(null);
    }
  }
}
