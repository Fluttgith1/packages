// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.4.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package io.flutter.plugins.videoplayer;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.CLASS;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Map;
import java.util.Objects;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression", "serial"})
public class Messages {

  /** Error class for passing custom error details to Flutter via a thrown PlatformException. */
  public static class FlutterError extends RuntimeException {

    /** The error code. */
    public final String code;

    /** The error details. Must be a datatype supported by the api codec. */
    public final Object details;

    public FlutterError(@NonNull String code, @Nullable String message, @Nullable Object details) {
      super(message);
      this.code = code;
      this.details = details;
    }
  }

  @NonNull
  protected static ArrayList<Object> wrapError(@NonNull Throwable exception) {
    ArrayList<Object> errorList = new ArrayList<>(3);
    if (exception instanceof FlutterError) {
      FlutterError error = (FlutterError) exception;
      errorList.add(error.code);
      errorList.add(error.getMessage());
      errorList.add(error.details);
    } else {
      errorList.add(exception.toString());
      errorList.add(exception.getClass().getSimpleName());
      errorList.add(
          "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    }
    return errorList;
  }

  @Target(METHOD)
  @Retention(CLASS)
  @interface CanIgnoreReturnValue {}

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class TextureMessage {
    private @NonNull Long textureId;

    public @NonNull Long getTextureId() {
      return textureId;
    }

    public void setTextureId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"textureId\" is null.");
      }
      this.textureId = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    TextureMessage() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) {
        return true;
      }
      if (o == null || getClass() != o.getClass()) {
        return false;
      }
      TextureMessage that = (TextureMessage) o;
      return textureId.equals(that.textureId);
    }

    @Override
    public int hashCode() {
      return Objects.hash(textureId);
    }

    public static final class Builder {

      private @Nullable Long textureId;

      @CanIgnoreReturnValue
      public @NonNull Builder setTextureId(@NonNull Long setterArg) {
        this.textureId = setterArg;
        return this;
      }

      public @NonNull TextureMessage build() {
        TextureMessage pigeonReturn = new TextureMessage();
        pigeonReturn.setTextureId(textureId);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(1);
      toListResult.add(textureId);
      return toListResult;
    }

    static @NonNull TextureMessage fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      TextureMessage pigeonResult = new TextureMessage();
      Object textureId = pigeonVar_list.get(0);
      pigeonResult.setTextureId((Long) textureId);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class LoopingMessage {
    private @NonNull Long textureId;

    public @NonNull Long getTextureId() {
      return textureId;
    }

    public void setTextureId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"textureId\" is null.");
      }
      this.textureId = setterArg;
    }

    private @NonNull Boolean isLooping;

    public @NonNull Boolean getIsLooping() {
      return isLooping;
    }

    public void setIsLooping(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"isLooping\" is null.");
      }
      this.isLooping = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    LoopingMessage() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) {
        return true;
      }
      if (o == null || getClass() != o.getClass()) {
        return false;
      }
      LoopingMessage that = (LoopingMessage) o;
      return textureId.equals(that.textureId) && isLooping.equals(that.isLooping);
    }

    @Override
    public int hashCode() {
      return Objects.hash(textureId, isLooping);
    }

    public static final class Builder {

      private @Nullable Long textureId;

      @CanIgnoreReturnValue
      public @NonNull Builder setTextureId(@NonNull Long setterArg) {
        this.textureId = setterArg;
        return this;
      }

      private @Nullable Boolean isLooping;

      @CanIgnoreReturnValue
      public @NonNull Builder setIsLooping(@NonNull Boolean setterArg) {
        this.isLooping = setterArg;
        return this;
      }

      public @NonNull LoopingMessage build() {
        LoopingMessage pigeonReturn = new LoopingMessage();
        pigeonReturn.setTextureId(textureId);
        pigeonReturn.setIsLooping(isLooping);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(2);
      toListResult.add(textureId);
      toListResult.add(isLooping);
      return toListResult;
    }

    static @NonNull LoopingMessage fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      LoopingMessage pigeonResult = new LoopingMessage();
      Object textureId = pigeonVar_list.get(0);
      pigeonResult.setTextureId((Long) textureId);
      Object isLooping = pigeonVar_list.get(1);
      pigeonResult.setIsLooping((Boolean) isLooping);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class VolumeMessage {
    private @NonNull Long textureId;

    public @NonNull Long getTextureId() {
      return textureId;
    }

    public void setTextureId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"textureId\" is null.");
      }
      this.textureId = setterArg;
    }

    private @NonNull Double volume;

    public @NonNull Double getVolume() {
      return volume;
    }

    public void setVolume(@NonNull Double setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"volume\" is null.");
      }
      this.volume = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    VolumeMessage() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) {
        return true;
      }
      if (o == null || getClass() != o.getClass()) {
        return false;
      }
      VolumeMessage that = (VolumeMessage) o;
      return textureId.equals(that.textureId) && volume.equals(that.volume);
    }

    @Override
    public int hashCode() {
      return Objects.hash(textureId, volume);
    }

    public static final class Builder {

      private @Nullable Long textureId;

      @CanIgnoreReturnValue
      public @NonNull Builder setTextureId(@NonNull Long setterArg) {
        this.textureId = setterArg;
        return this;
      }

      private @Nullable Double volume;

      @CanIgnoreReturnValue
      public @NonNull Builder setVolume(@NonNull Double setterArg) {
        this.volume = setterArg;
        return this;
      }

      public @NonNull VolumeMessage build() {
        VolumeMessage pigeonReturn = new VolumeMessage();
        pigeonReturn.setTextureId(textureId);
        pigeonReturn.setVolume(volume);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(2);
      toListResult.add(textureId);
      toListResult.add(volume);
      return toListResult;
    }

    static @NonNull VolumeMessage fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      VolumeMessage pigeonResult = new VolumeMessage();
      Object textureId = pigeonVar_list.get(0);
      pigeonResult.setTextureId((Long) textureId);
      Object volume = pigeonVar_list.get(1);
      pigeonResult.setVolume((Double) volume);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class PlaybackSpeedMessage {
    private @NonNull Long textureId;

    public @NonNull Long getTextureId() {
      return textureId;
    }

    public void setTextureId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"textureId\" is null.");
      }
      this.textureId = setterArg;
    }

    private @NonNull Double speed;

    public @NonNull Double getSpeed() {
      return speed;
    }

    public void setSpeed(@NonNull Double setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"speed\" is null.");
      }
      this.speed = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    PlaybackSpeedMessage() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) {
        return true;
      }
      if (o == null || getClass() != o.getClass()) {
        return false;
      }
      PlaybackSpeedMessage that = (PlaybackSpeedMessage) o;
      return textureId.equals(that.textureId) && speed.equals(that.speed);
    }

    @Override
    public int hashCode() {
      return Objects.hash(textureId, speed);
    }

    public static final class Builder {

      private @Nullable Long textureId;

      @CanIgnoreReturnValue
      public @NonNull Builder setTextureId(@NonNull Long setterArg) {
        this.textureId = setterArg;
        return this;
      }

      private @Nullable Double speed;

      @CanIgnoreReturnValue
      public @NonNull Builder setSpeed(@NonNull Double setterArg) {
        this.speed = setterArg;
        return this;
      }

      public @NonNull PlaybackSpeedMessage build() {
        PlaybackSpeedMessage pigeonReturn = new PlaybackSpeedMessage();
        pigeonReturn.setTextureId(textureId);
        pigeonReturn.setSpeed(speed);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(2);
      toListResult.add(textureId);
      toListResult.add(speed);
      return toListResult;
    }

    static @NonNull PlaybackSpeedMessage fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      PlaybackSpeedMessage pigeonResult = new PlaybackSpeedMessage();
      Object textureId = pigeonVar_list.get(0);
      pigeonResult.setTextureId((Long) textureId);
      Object speed = pigeonVar_list.get(1);
      pigeonResult.setSpeed((Double) speed);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class PositionMessage {
    private @NonNull Long textureId;

    public @NonNull Long getTextureId() {
      return textureId;
    }

    public void setTextureId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"textureId\" is null.");
      }
      this.textureId = setterArg;
    }

    private @NonNull Long position;

    public @NonNull Long getPosition() {
      return position;
    }

    public void setPosition(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"position\" is null.");
      }
      this.position = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    PositionMessage() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) {
        return true;
      }
      if (o == null || getClass() != o.getClass()) {
        return false;
      }
      PositionMessage that = (PositionMessage) o;
      return textureId.equals(that.textureId) && position.equals(that.position);
    }

    @Override
    public int hashCode() {
      return Objects.hash(textureId, position);
    }

    public static final class Builder {

      private @Nullable Long textureId;

      @CanIgnoreReturnValue
      public @NonNull Builder setTextureId(@NonNull Long setterArg) {
        this.textureId = setterArg;
        return this;
      }

      private @Nullable Long position;

      @CanIgnoreReturnValue
      public @NonNull Builder setPosition(@NonNull Long setterArg) {
        this.position = setterArg;
        return this;
      }

      public @NonNull PositionMessage build() {
        PositionMessage pigeonReturn = new PositionMessage();
        pigeonReturn.setTextureId(textureId);
        pigeonReturn.setPosition(position);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(2);
      toListResult.add(textureId);
      toListResult.add(position);
      return toListResult;
    }

    static @NonNull PositionMessage fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      PositionMessage pigeonResult = new PositionMessage();
      Object textureId = pigeonVar_list.get(0);
      pigeonResult.setTextureId((Long) textureId);
      Object position = pigeonVar_list.get(1);
      pigeonResult.setPosition((Long) position);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class CreateMessage {
    private @Nullable String asset;

    public @Nullable String getAsset() {
      return asset;
    }

    public void setAsset(@Nullable String setterArg) {
      this.asset = setterArg;
    }

    private @Nullable String uri;

    public @Nullable String getUri() {
      return uri;
    }

    public void setUri(@Nullable String setterArg) {
      this.uri = setterArg;
    }

    private @Nullable String packageName;

    public @Nullable String getPackageName() {
      return packageName;
    }

    public void setPackageName(@Nullable String setterArg) {
      this.packageName = setterArg;
    }

    private @Nullable String formatHint;

    public @Nullable String getFormatHint() {
      return formatHint;
    }

    public void setFormatHint(@Nullable String setterArg) {
      this.formatHint = setterArg;
    }

    private @NonNull Map<String, String> httpHeaders;

    public @NonNull Map<String, String> getHttpHeaders() {
      return httpHeaders;
    }

    public void setHttpHeaders(@NonNull Map<String, String> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"httpHeaders\" is null.");
      }
      this.httpHeaders = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    CreateMessage() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) {
        return true;
      }
      if (o == null || getClass() != o.getClass()) {
        return false;
      }
      CreateMessage that = (CreateMessage) o;
      return Objects.equals(asset, that.asset)
          && Objects.equals(uri, that.uri)
          && Objects.equals(packageName, that.packageName)
          && Objects.equals(formatHint, that.formatHint)
          && httpHeaders.equals(that.httpHeaders);
    }

    @Override
    public int hashCode() {
      return Objects.hash(asset, uri, packageName, formatHint, httpHeaders);
    }

    public static final class Builder {

      private @Nullable String asset;

      @CanIgnoreReturnValue
      public @NonNull Builder setAsset(@Nullable String setterArg) {
        this.asset = setterArg;
        return this;
      }

      private @Nullable String uri;

      @CanIgnoreReturnValue
      public @NonNull Builder setUri(@Nullable String setterArg) {
        this.uri = setterArg;
        return this;
      }

      private @Nullable String packageName;

      @CanIgnoreReturnValue
      public @NonNull Builder setPackageName(@Nullable String setterArg) {
        this.packageName = setterArg;
        return this;
      }

      private @Nullable String formatHint;

      @CanIgnoreReturnValue
      public @NonNull Builder setFormatHint(@Nullable String setterArg) {
        this.formatHint = setterArg;
        return this;
      }

      private @Nullable Map<String, String> httpHeaders;

      @CanIgnoreReturnValue
      public @NonNull Builder setHttpHeaders(@NonNull Map<String, String> setterArg) {
        this.httpHeaders = setterArg;
        return this;
      }

      public @NonNull CreateMessage build() {
        CreateMessage pigeonReturn = new CreateMessage();
        pigeonReturn.setAsset(asset);
        pigeonReturn.setUri(uri);
        pigeonReturn.setPackageName(packageName);
        pigeonReturn.setFormatHint(formatHint);
        pigeonReturn.setHttpHeaders(httpHeaders);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(5);
      toListResult.add(asset);
      toListResult.add(uri);
      toListResult.add(packageName);
      toListResult.add(formatHint);
      toListResult.add(httpHeaders);
      return toListResult;
    }

    static @NonNull CreateMessage fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      CreateMessage pigeonResult = new CreateMessage();
      Object asset = pigeonVar_list.get(0);
      pigeonResult.setAsset((String) asset);
      Object uri = pigeonVar_list.get(1);
      pigeonResult.setUri((String) uri);
      Object packageName = pigeonVar_list.get(2);
      pigeonResult.setPackageName((String) packageName);
      Object formatHint = pigeonVar_list.get(3);
      pigeonResult.setFormatHint((String) formatHint);
      Object httpHeaders = pigeonVar_list.get(4);
      pigeonResult.setHttpHeaders((Map<String, String>) httpHeaders);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class MixWithOthersMessage {
    private @NonNull Boolean mixWithOthers;

    public @NonNull Boolean getMixWithOthers() {
      return mixWithOthers;
    }

    public void setMixWithOthers(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"mixWithOthers\" is null.");
      }
      this.mixWithOthers = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    MixWithOthersMessage() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) {
        return true;
      }
      if (o == null || getClass() != o.getClass()) {
        return false;
      }
      MixWithOthersMessage that = (MixWithOthersMessage) o;
      return mixWithOthers.equals(that.mixWithOthers);
    }

    @Override
    public int hashCode() {
      return Objects.hash(mixWithOthers);
    }

    public static final class Builder {

      private @Nullable Boolean mixWithOthers;

      @CanIgnoreReturnValue
      public @NonNull Builder setMixWithOthers(@NonNull Boolean setterArg) {
        this.mixWithOthers = setterArg;
        return this;
      }

      public @NonNull MixWithOthersMessage build() {
        MixWithOthersMessage pigeonReturn = new MixWithOthersMessage();
        pigeonReturn.setMixWithOthers(mixWithOthers);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(1);
      toListResult.add(mixWithOthers);
      return toListResult;
    }

    static @NonNull MixWithOthersMessage fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      MixWithOthersMessage pigeonResult = new MixWithOthersMessage();
      Object mixWithOthers = pigeonVar_list.get(0);
      pigeonResult.setMixWithOthers((Boolean) mixWithOthers);
      return pigeonResult;
    }
  }

  private static class PigeonCodec extends StandardMessageCodec {
    public static final PigeonCodec INSTANCE = new PigeonCodec();

    private PigeonCodec() {}

    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte) 129:
          return TextureMessage.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 130:
          return LoopingMessage.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 131:
          return VolumeMessage.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 132:
          return PlaybackSpeedMessage.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 133:
          return PositionMessage.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 134:
          return CreateMessage.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 135:
          return MixWithOthersMessage.fromList((ArrayList<Object>) readValue(buffer));
        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value) {
      if (value instanceof TextureMessage) {
        stream.write(129);
        writeValue(stream, ((TextureMessage) value).toList());
      } else if (value instanceof LoopingMessage) {
        stream.write(130);
        writeValue(stream, ((LoopingMessage) value).toList());
      } else if (value instanceof VolumeMessage) {
        stream.write(131);
        writeValue(stream, ((VolumeMessage) value).toList());
      } else if (value instanceof PlaybackSpeedMessage) {
        stream.write(132);
        writeValue(stream, ((PlaybackSpeedMessage) value).toList());
      } else if (value instanceof PositionMessage) {
        stream.write(133);
        writeValue(stream, ((PositionMessage) value).toList());
      } else if (value instanceof CreateMessage) {
        stream.write(134);
        writeValue(stream, ((CreateMessage) value).toList());
      } else if (value instanceof MixWithOthersMessage) {
        stream.write(135);
        writeValue(stream, ((MixWithOthersMessage) value).toList());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface AndroidVideoPlayerApi {

    void initialize();

    @NonNull
    TextureMessage create(@NonNull CreateMessage msg);

    void dispose(@NonNull TextureMessage msg);

    void setLooping(@NonNull LoopingMessage msg);

    void setVolume(@NonNull VolumeMessage msg);

    void setPlaybackSpeed(@NonNull PlaybackSpeedMessage msg);

    void play(@NonNull TextureMessage msg);

    @NonNull
    PositionMessage position(@NonNull TextureMessage msg);

    void seekTo(@NonNull PositionMessage msg);

    void pause(@NonNull TextureMessage msg);

    void setMixWithOthers(@NonNull MixWithOthersMessage msg);

    /** The codec used by AndroidVideoPlayerApi. */
    static @NonNull MessageCodec<Object> getCodec() {
      return PigeonCodec.INSTANCE;
    }
    /**
     * Sets up an instance of `AndroidVideoPlayerApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setUp(
        @NonNull BinaryMessenger binaryMessenger, @Nullable AndroidVideoPlayerApi api) {
      setUp(binaryMessenger, "", api);
    }

    static void setUp(
        @NonNull BinaryMessenger binaryMessenger,
        @NonNull String messageChannelSuffix,
        @Nullable AndroidVideoPlayerApi api) {
      messageChannelSuffix = messageChannelSuffix.isEmpty() ? "" : "." + messageChannelSuffix;
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.initialize"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                try {
                  api.initialize();
                  wrapped.add(0, null);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.create"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                CreateMessage msgArg = (CreateMessage) args.get(0);
                try {
                  TextureMessage output = api.create(msgArg);
                  wrapped.add(0, output);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.dispose"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                TextureMessage msgArg = (TextureMessage) args.get(0);
                try {
                  api.dispose(msgArg);
                  wrapped.add(0, null);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setLooping"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                LoopingMessage msgArg = (LoopingMessage) args.get(0);
                try {
                  api.setLooping(msgArg);
                  wrapped.add(0, null);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setVolume"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                VolumeMessage msgArg = (VolumeMessage) args.get(0);
                try {
                  api.setVolume(msgArg);
                  wrapped.add(0, null);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setPlaybackSpeed"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                PlaybackSpeedMessage msgArg = (PlaybackSpeedMessage) args.get(0);
                try {
                  api.setPlaybackSpeed(msgArg);
                  wrapped.add(0, null);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.play"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                TextureMessage msgArg = (TextureMessage) args.get(0);
                try {
                  api.play(msgArg);
                  wrapped.add(0, null);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.position"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                TextureMessage msgArg = (TextureMessage) args.get(0);
                try {
                  PositionMessage output = api.position(msgArg);
                  wrapped.add(0, output);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.seekTo"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                PositionMessage msgArg = (PositionMessage) args.get(0);
                try {
                  api.seekTo(msgArg);
                  wrapped.add(0, null);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.pause"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                TextureMessage msgArg = (TextureMessage) args.get(0);
                try {
                  api.pause(msgArg);
                  wrapped.add(0, null);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setMixWithOthers"
                    + messageChannelSuffix,
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                MixWithOthersMessage msgArg = (MixWithOthersMessage) args.get(0);
                try {
                  api.setMixWithOthers(msgArg);
                  wrapped.add(0, null);
                } catch (Throwable exception) {
                  wrapped = wrapError(exception);
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
}
