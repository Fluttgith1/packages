// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.sharedpreferences;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.Base64;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.VisibleForTesting;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugins.sharedpreferences.Messages.SharedPreferencesApi;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.List;
import java.util.Map;

/** SharedPreferencesPlugin */
public class SharedPreferencesPlugin implements FlutterPlugin, SharedPreferencesApi {
  static final String TAG = "SharedPreferencesPlugin.java";

  SharedPreferencesListEncoder listEncoder;

  static class ListEncoder implements SharedPreferencesListEncoder {
    @Override
    public @NonNull String encode(@NonNull List<String> list) throws RuntimeException {
      try {
        ByteArrayOutputStream byteStream = new ByteArrayOutputStream();
        ObjectOutputStream stream = new ObjectOutputStream(byteStream);
        stream.writeObject(list);
        stream.flush();
        return Base64.encodeToString(byteStream.toByteArray(), 0);
      } catch (IOException e) {
        throw new RuntimeException(e);
      }
    }

    @SuppressWarnings("unchecked")
    @Override
    public @NonNull List<String> decode(@NonNull String listString) throws RuntimeException {
      try {
        ObjectInputStream stream =
            new ObjectInputStream(new ByteArrayInputStream(Base64.decode(listString, 0)));
        return (List<String>) stream.readObject();
      } catch (IOException | ClassNotFoundException e) {
        throw new RuntimeException(e);
      }
    }
  }

  public SharedPreferencesPlugin() {
    this(new ListEncoder());
  }

  @VisibleForTesting
  SharedPreferencesPlugin(SharedPreferencesListEncoder testListEncoder) {
    listEncoder = testListEncoder;
  }

  // SharedPreferences Helper Object, exposes SharedPreferences methods
  private MethodCallHandlerImpl preferences;

  @SuppressWarnings("deprecation")
  public static void registerWith(
      @NonNull io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
    final SharedPreferencesPlugin plugin = new SharedPreferencesPlugin();
    plugin.setUp(registrar.messenger(), registrar.context());
  }

  private void setUp(@NonNull BinaryMessenger messenger, @NonNull Context context) {
    preferences = new MethodCallHandlerImpl(context, listEncoder);
    try {
      SharedPreferencesApi.setup(messenger, this);
    } catch (Exception ex) {
      Log.e(TAG, "Received exception while setting up SharedPreferencesPlugin", ex);
    }
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPlugin.FlutterPluginBinding binding) {
    setUp(binding.getBinaryMessenger(), binding.getApplicationContext());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPlugin.FlutterPluginBinding binding) {
    SharedPreferencesApi.setup(binding.getBinaryMessenger(), null);
  }

  @Override
  public @NonNull Boolean setBool(@NonNull String key, @NonNull Boolean value) {
    return preferences.setBool(key, value);
  }

  @Override
  public @NonNull Boolean setString(@NonNull String key, @NonNull String value) {
    return preferences.setString(key, value);
  }

  @Override
  public @NonNull Boolean setInt(@NonNull String key, @NonNull Long value) {
    return preferences.setInt(key, value);
  }

  @Override
  public @NonNull Boolean setDouble(@NonNull String key, @NonNull Double value) {
    return preferences.setDouble(key, value);
  }

  @Override
  public @NonNull Boolean remove(@NonNull String key) {
    return preferences.remove(key);
  }

  @Override
  public @NonNull Boolean setStringList(@NonNull String key, @NonNull List<String> value)
      throws RuntimeException {
    return preferences.setStringList(key, value);
  }

  @Override
  public @NonNull Map<String, Object> getAllWithPrefix(@NonNull String prefix)
      throws RuntimeException {
    return preferences.getAllWithPrefix(prefix);
  }

  @Override
  public @NonNull Boolean clearWithPrefix(@NonNull String prefix) throws RuntimeException {
    return preferences.clearWithPrefix(prefix);
  }
}
