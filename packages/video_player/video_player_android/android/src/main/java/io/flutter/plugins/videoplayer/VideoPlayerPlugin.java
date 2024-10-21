// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.videoplayer;

import android.content.Context;
import android.os.Build;
import android.util.LongSparseArray;
import androidx.annotation.NonNull;
import io.flutter.FlutterInjector;
import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.view.TextureRegistry;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import javax.net.ssl.HttpsURLConnection;

/** Android platform implementation of the VideoPlayerPlugin. */
public class VideoPlayerPlugin implements FlutterPlugin, AndroidVideoPlayerApi {
  private static final String TAG = "VideoPlayerPlugin";
  private final LongSparseArray<VideoPlayer> videoPlayers = new LongSparseArray<>();
  private FlutterState flutterState;
  private final VideoPlayerOptions options = new VideoPlayerOptions();

  /** Register this with the v2 embedding for the plugin to respond to lifecycle callbacks. */
  public VideoPlayerPlugin() {}

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    if (android.os.Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP) {
      try {
        HttpsURLConnection.setDefaultSSLSocketFactory(new CustomSSLSocketFactory());
      } catch (KeyManagementException | NoSuchAlgorithmException e) {
        Log.w(
            TAG,
            "Failed to enable TLSv1.1 and TLSv1.2 Protocols for API level 19 and below.\n"
                + "For more information about Socket Security, please consult the following link:\n"
                + "https://developer.android.com/reference/javax/net/ssl/SSLSocket",
            e);
      }
    }

    final FlutterInjector injector = FlutterInjector.instance();
    this.flutterState =
        new FlutterState(
            binding.getApplicationContext(),
            binding.getBinaryMessenger(),
            injector.flutterLoader()::getLookupKeyForAsset,
            injector.flutterLoader()::getLookupKeyForAsset,
            binding.getTextureRegistry());
    flutterState.startListening(this, binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    if (flutterState == null) {
      Log.wtf(TAG, "Detached from the engine before registering to it.");
    }
    flutterState.stopListening(binding.getBinaryMessenger());
    flutterState = null;
    onDestroy();
  }

  private void disposeAllPlayers() {
    for (int i = 0; i < videoPlayers.size(); i++) {
      videoPlayers.valueAt(i).dispose();
    }
    videoPlayers.clear();
  }

  public void onDestroy() {
    // The whole FlutterView is being destroyed. Here we release resources acquired for all
    // instances
    // of VideoPlayer. Once https://github.com/flutter/flutter/issues/19358 is resolved this may
    // be replaced with just asserting that videoPlayers.isEmpty().
    // https://github.com/flutter/flutter/issues/20989 tracks this.
    disposeAllPlayers();
  }

  @Override
  public void initialize() {
    disposeAllPlayers();
  }

  @Override
  public long create(@NonNull CreateMessage arg) {
    TextureRegistry.SurfaceProducer handle = flutterState.textureRegistry.createSurfaceProducer();
    EventChannel eventChannel =
        new EventChannel(
            flutterState.binaryMessenger, "flutter.io/videoPlayer/videoEvents" + handle.id());

    final VideoAsset videoAsset;
    if (arg.getAsset() != null) {
      String assetLookupKey;
      if (arg.getPackageName() != null) {
        assetLookupKey =
            flutterState.keyForAssetAndPackageName.get(arg.getAsset(), arg.getPackageName());
      } else {
        assetLookupKey = flutterState.keyForAsset.get(arg.getAsset());
      }
      videoAsset = VideoAsset.fromAssetUrl("asset:///" + assetLookupKey);
    } else if (arg.getUri().startsWith("rtsp://")) {
      videoAsset = VideoAsset.fromRtspUrl(arg.getUri());
    } else {
      VideoAsset.StreamingFormat streamingFormat = VideoAsset.StreamingFormat.UNKNOWN;
      String formatHint = arg.getFormatHint();
      if (formatHint != null) {
        switch (formatHint) {
          case "ss":
            streamingFormat = VideoAsset.StreamingFormat.SMOOTH;
            break;
          case "dash":
            streamingFormat = VideoAsset.StreamingFormat.DYNAMIC_ADAPTIVE;
            break;
          case "hls":
            streamingFormat = VideoAsset.StreamingFormat.HTTP_LIVE;
            break;
        }
      }
      videoAsset = VideoAsset.fromRemoteUrl(arg.getUri(), streamingFormat, arg.getHttpHeaders());
    }
    videoPlayers.put(
        handle.id(),
        VideoPlayer.create(
            flutterState.applicationContext,
            VideoPlayerEventCallbacks.bindTo(eventChannel),
            handle,
            videoAsset,
            options));

    return handle.id();
  }

  @NonNull
  private VideoPlayer getPlayer(long textureId) {
    VideoPlayer player = videoPlayers.get(textureId);

    // Avoid a very ugly un-debuggable NPE that results in returning a null player.
    if (player == null) {
      String message = "No player found with textureId <" + textureId + ">";
      if (videoPlayers.size() == 0) {
        message += " and no active players created by the plugin.";
      }
      throw new IllegalStateException(message);
    }

    return player;
  }

  @Override
  public void dispose(long textureId) {
    VideoPlayer player = getPlayer(textureId);
    player.dispose();
    videoPlayers.remove(textureId);
  }

  @Override
  public void setLooping(long textureId, boolean looping) {
    VideoPlayer player = getPlayer(textureId);
    player.setLooping(looping);
  }

  @Override
  public void setVolume(long textureId, double volume) {
    VideoPlayer player = getPlayer(textureId);
    player.setVolume(volume);
  }

  @Override
  public void setPlaybackSpeed(long textureId, double speed) {
    VideoPlayer player = getPlayer(textureId);
    player.setPlaybackSpeed(speed);
  }

  @Override
  public void play(long textureId) {
    VideoPlayer player = getPlayer(textureId);
    player.play();
  }

  @Override
  public long position(long textureId) {
    VideoPlayer player = getPlayer(textureId);
    long position = player.getPosition();
    player.sendBufferingUpdate();
    return position;
  }

  @Override
  public void seekTo(long textureId, long position) {
    VideoPlayer player = getPlayer(textureId);
    player.seekTo((int) position);
  }

  @Override
  public void pause(long textureId) {
    VideoPlayer player = getPlayer(textureId);
    player.pause();
  }

  @Override
  public void setMixWithOthers(boolean mixWithOthers) {
    options.mixWithOthers = mixWithOthers;
  }

  private interface KeyForAssetFn {
    String get(String asset);
  }

  private interface KeyForAssetAndPackageName {
    String get(String asset, String packageName);
  }

  private static final class FlutterState {
    final Context applicationContext;
    final BinaryMessenger binaryMessenger;
    final KeyForAssetFn keyForAsset;
    final KeyForAssetAndPackageName keyForAssetAndPackageName;
    final TextureRegistry textureRegistry;

    FlutterState(
        Context applicationContext,
        BinaryMessenger messenger,
        KeyForAssetFn keyForAsset,
        KeyForAssetAndPackageName keyForAssetAndPackageName,
        TextureRegistry textureRegistry) {
      this.applicationContext = applicationContext;
      this.binaryMessenger = messenger;
      this.keyForAsset = keyForAsset;
      this.keyForAssetAndPackageName = keyForAssetAndPackageName;
      this.textureRegistry = textureRegistry;
    }

    void startListening(VideoPlayerPlugin methodCallHandler, BinaryMessenger messenger) {
      AndroidVideoPlayerApi.Companion.setUp(messenger, methodCallHandler);
    }

    void stopListening(BinaryMessenger messenger) {
      AndroidVideoPlayerApi.Companion.setUp(messenger, null);
    }
  }
}
