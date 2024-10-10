// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.4.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package io.flutter.plugins.camera;

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
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
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

    public FlutterError(@NonNull String code, @Nullable String message, @Nullable Object details) 
    {
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

  @NonNull
  protected static FlutterError createConnectionError(@NonNull String channelName) {
    return new FlutterError("channel-error",  "Unable to establish connection on channel: " + channelName + ".", "");
  }

  @Target(METHOD)
  @Retention(CLASS)
  @interface CanIgnoreReturnValue {}

  /** Pigeon equivalent of [CameraLensDirection]. */
  public enum PlatformCameraLensDirection {
    FRONT(0),
    BACK(1),
    EXTERNAL(2);

    final int index;

    PlatformCameraLensDirection(final int index) {
      this.index = index;
    }
  }

  /** Pigeon equivalent of [DeviceOrientation]. */
  public enum PlatformDeviceOrientation {
    PORTRAIT_UP(0),
    PORTRAIT_DOWN(1),
    LANDSCAPE_LEFT(2),
    LANDSCAPE_RIGHT(3);

    final int index;

    PlatformDeviceOrientation(final int index) {
      this.index = index;
    }
  }

  /** Pigeon equivalent of [ExposureMode]. */
  public enum PlatformExposureMode {
    AUTO(0),
    LOCKED(1);

    final int index;

    PlatformExposureMode(final int index) {
      this.index = index;
    }
  }

  /** Pigeon equivalent of [FocusMode]. */
  public enum PlatformFocusMode {
    AUTO(0),
    LOCKED(1);

    final int index;

    PlatformFocusMode(final int index) {
      this.index = index;
    }
  }

  /**
   * Pigeon equivalent of [CameraDescription].
   *
   * Generated class from Pigeon that represents data sent in messages.
   */
  public static final class PlatformCameraDescription {
    private @NonNull String name;

    public @NonNull String getName() {
      return name;
    }

    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull PlatformCameraLensDirection lensDirection;

    public @NonNull PlatformCameraLensDirection getLensDirection() {
      return lensDirection;
    }

    public void setLensDirection(@NonNull PlatformCameraLensDirection setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"lensDirection\" is null.");
      }
      this.lensDirection = setterArg;
    }

    private @NonNull Long sensorOrientation;

    public @NonNull Long getSensorOrientation() {
      return sensorOrientation;
    }

    public void setSensorOrientation(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"sensorOrientation\" is null.");
      }
      this.sensorOrientation = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    PlatformCameraDescription() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) { return true; }
      if (o == null || getClass() != o.getClass()) { return false; }
      PlatformCameraDescription that = (PlatformCameraDescription) o;
      return name.equals(that.name) && lensDirection.equals(that.lensDirection) && sensorOrientation.equals(that.sensorOrientation);
    }

    @Override
    public int hashCode() {
      return Objects.hash(name, lensDirection, sensorOrientation);
    }

    public static final class Builder {

      private @Nullable String name;

      @CanIgnoreReturnValue
      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }

      private @Nullable PlatformCameraLensDirection lensDirection;

      @CanIgnoreReturnValue
      public @NonNull Builder setLensDirection(@NonNull PlatformCameraLensDirection setterArg) {
        this.lensDirection = setterArg;
        return this;
      }

      private @Nullable Long sensorOrientation;

      @CanIgnoreReturnValue
      public @NonNull Builder setSensorOrientation(@NonNull Long setterArg) {
        this.sensorOrientation = setterArg;
        return this;
      }

      public @NonNull PlatformCameraDescription build() {
        PlatformCameraDescription pigeonReturn = new PlatformCameraDescription();
        pigeonReturn.setName(name);
        pigeonReturn.setLensDirection(lensDirection);
        pigeonReturn.setSensorOrientation(sensorOrientation);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(3);
      toListResult.add(name);
      toListResult.add(lensDirection);
      toListResult.add(sensorOrientation);
      return toListResult;
    }

    static @NonNull PlatformCameraDescription fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      PlatformCameraDescription pigeonResult = new PlatformCameraDescription();
      Object name = pigeonVar_list.get(0);
      pigeonResult.setName((String) name);
      Object lensDirection = pigeonVar_list.get(1);
      pigeonResult.setLensDirection((PlatformCameraLensDirection) lensDirection);
      Object sensorOrientation = pigeonVar_list.get(2);
      pigeonResult.setSensorOrientation((Long) sensorOrientation);
      return pigeonResult;
    }
  }

  /**
   * Data needed for [CameraInitializedEvent].
   *
   * Generated class from Pigeon that represents data sent in messages.
   */
  public static final class PlatformCameraState {
    private @NonNull PlatformSize previewSize;

    public @NonNull PlatformSize getPreviewSize() {
      return previewSize;
    }

    public void setPreviewSize(@NonNull PlatformSize setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"previewSize\" is null.");
      }
      this.previewSize = setterArg;
    }

    private @NonNull PlatformExposureMode exposureMode;

    public @NonNull PlatformExposureMode getExposureMode() {
      return exposureMode;
    }

    public void setExposureMode(@NonNull PlatformExposureMode setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"exposureMode\" is null.");
      }
      this.exposureMode = setterArg;
    }

    private @NonNull PlatformFocusMode focusMode;

    public @NonNull PlatformFocusMode getFocusMode() {
      return focusMode;
    }

    public void setFocusMode(@NonNull PlatformFocusMode setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"focusMode\" is null.");
      }
      this.focusMode = setterArg;
    }

    private @NonNull Boolean exposurePointSupported;

    public @NonNull Boolean getExposurePointSupported() {
      return exposurePointSupported;
    }

    public void setExposurePointSupported(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"exposurePointSupported\" is null.");
      }
      this.exposurePointSupported = setterArg;
    }

    private @NonNull Boolean focusPointSupported;

    public @NonNull Boolean getFocusPointSupported() {
      return focusPointSupported;
    }

    public void setFocusPointSupported(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"focusPointSupported\" is null.");
      }
      this.focusPointSupported = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    PlatformCameraState() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) { return true; }
      if (o == null || getClass() != o.getClass()) { return false; }
      PlatformCameraState that = (PlatformCameraState) o;
      return previewSize.equals(that.previewSize) && exposureMode.equals(that.exposureMode) && focusMode.equals(that.focusMode) && exposurePointSupported.equals(that.exposurePointSupported) && focusPointSupported.equals(that.focusPointSupported);
    }

    @Override
    public int hashCode() {
      return Objects.hash(previewSize, exposureMode, focusMode, exposurePointSupported, focusPointSupported);
    }

    public static final class Builder {

      private @Nullable PlatformSize previewSize;

      @CanIgnoreReturnValue
      public @NonNull Builder setPreviewSize(@NonNull PlatformSize setterArg) {
        this.previewSize = setterArg;
        return this;
      }

      private @Nullable PlatformExposureMode exposureMode;

      @CanIgnoreReturnValue
      public @NonNull Builder setExposureMode(@NonNull PlatformExposureMode setterArg) {
        this.exposureMode = setterArg;
        return this;
      }

      private @Nullable PlatformFocusMode focusMode;

      @CanIgnoreReturnValue
      public @NonNull Builder setFocusMode(@NonNull PlatformFocusMode setterArg) {
        this.focusMode = setterArg;
        return this;
      }

      private @Nullable Boolean exposurePointSupported;

      @CanIgnoreReturnValue
      public @NonNull Builder setExposurePointSupported(@NonNull Boolean setterArg) {
        this.exposurePointSupported = setterArg;
        return this;
      }

      private @Nullable Boolean focusPointSupported;

      @CanIgnoreReturnValue
      public @NonNull Builder setFocusPointSupported(@NonNull Boolean setterArg) {
        this.focusPointSupported = setterArg;
        return this;
      }

      public @NonNull PlatformCameraState build() {
        PlatformCameraState pigeonReturn = new PlatformCameraState();
        pigeonReturn.setPreviewSize(previewSize);
        pigeonReturn.setExposureMode(exposureMode);
        pigeonReturn.setFocusMode(focusMode);
        pigeonReturn.setExposurePointSupported(exposurePointSupported);
        pigeonReturn.setFocusPointSupported(focusPointSupported);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(5);
      toListResult.add(previewSize);
      toListResult.add(exposureMode);
      toListResult.add(focusMode);
      toListResult.add(exposurePointSupported);
      toListResult.add(focusPointSupported);
      return toListResult;
    }

    static @NonNull PlatformCameraState fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      PlatformCameraState pigeonResult = new PlatformCameraState();
      Object previewSize = pigeonVar_list.get(0);
      pigeonResult.setPreviewSize((PlatformSize) previewSize);
      Object exposureMode = pigeonVar_list.get(1);
      pigeonResult.setExposureMode((PlatformExposureMode) exposureMode);
      Object focusMode = pigeonVar_list.get(2);
      pigeonResult.setFocusMode((PlatformFocusMode) focusMode);
      Object exposurePointSupported = pigeonVar_list.get(3);
      pigeonResult.setExposurePointSupported((Boolean) exposurePointSupported);
      Object focusPointSupported = pigeonVar_list.get(4);
      pigeonResult.setFocusPointSupported((Boolean) focusPointSupported);
      return pigeonResult;
    }
  }

  /**
   * Pigeon equivalent of [Size].
   *
   * Generated class from Pigeon that represents data sent in messages.
   */
  public static final class PlatformSize {
    private @NonNull Double width;

    public @NonNull Double getWidth() {
      return width;
    }

    public void setWidth(@NonNull Double setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"width\" is null.");
      }
      this.width = setterArg;
    }

    private @NonNull Double height;

    public @NonNull Double getHeight() {
      return height;
    }

    public void setHeight(@NonNull Double setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"height\" is null.");
      }
      this.height = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    PlatformSize() {}

    @Override
    public boolean equals(Object o) {
      if (this == o) { return true; }
      if (o == null || getClass() != o.getClass()) { return false; }
      PlatformSize that = (PlatformSize) o;
      return width.equals(that.width) && height.equals(that.height);
    }

    @Override
    public int hashCode() {
      return Objects.hash(width, height);
    }

    public static final class Builder {

      private @Nullable Double width;

      @CanIgnoreReturnValue
      public @NonNull Builder setWidth(@NonNull Double setterArg) {
        this.width = setterArg;
        return this;
      }

      private @Nullable Double height;

      @CanIgnoreReturnValue
      public @NonNull Builder setHeight(@NonNull Double setterArg) {
        this.height = setterArg;
        return this;
      }

      public @NonNull PlatformSize build() {
        PlatformSize pigeonReturn = new PlatformSize();
        pigeonReturn.setWidth(width);
        pigeonReturn.setHeight(height);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<>(2);
      toListResult.add(width);
      toListResult.add(height);
      return toListResult;
    }

    static @NonNull PlatformSize fromList(@NonNull ArrayList<Object> pigeonVar_list) {
      PlatformSize pigeonResult = new PlatformSize();
      Object width = pigeonVar_list.get(0);
      pigeonResult.setWidth((Double) width);
      Object height = pigeonVar_list.get(1);
      pigeonResult.setHeight((Double) height);
      return pigeonResult;
    }
  }

  private static class PigeonCodec extends StandardMessageCodec {
    public static final PigeonCodec INSTANCE = new PigeonCodec();

    private PigeonCodec() {}

    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte) 129: {
          Object value = readValue(buffer);
          return value == null ? null : PlatformCameraLensDirection.values()[((Long) value).intValue()];
        }
        case (byte) 130: {
          Object value = readValue(buffer);
          return value == null ? null : PlatformDeviceOrientation.values()[((Long) value).intValue()];
        }
        case (byte) 131: {
          Object value = readValue(buffer);
          return value == null ? null : PlatformExposureMode.values()[((Long) value).intValue()];
        }
        case (byte) 132: {
          Object value = readValue(buffer);
          return value == null ? null : PlatformFocusMode.values()[((Long) value).intValue()];
        }
        case (byte) 133:
          return PlatformCameraDescription.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 134:
          return PlatformCameraState.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 135:
          return PlatformSize.fromList((ArrayList<Object>) readValue(buffer));
        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value) {
      if (value instanceof PlatformCameraLensDirection) {
        stream.write(129);
        writeValue(stream, value == null ? null : ((PlatformCameraLensDirection) value).index);
      } else if (value instanceof PlatformDeviceOrientation) {
        stream.write(130);
        writeValue(stream, value == null ? null : ((PlatformDeviceOrientation) value).index);
      } else if (value instanceof PlatformExposureMode) {
        stream.write(131);
        writeValue(stream, value == null ? null : ((PlatformExposureMode) value).index);
      } else if (value instanceof PlatformFocusMode) {
        stream.write(132);
        writeValue(stream, value == null ? null : ((PlatformFocusMode) value).index);
      } else if (value instanceof PlatformCameraDescription) {
        stream.write(133);
        writeValue(stream, ((PlatformCameraDescription) value).toList());
      } else if (value instanceof PlatformCameraState) {
        stream.write(134);
        writeValue(stream, ((PlatformCameraState) value).toList());
      } else if (value instanceof PlatformSize) {
        stream.write(135);
        writeValue(stream, ((PlatformSize) value).toList());
      } else {
        super.writeValue(stream, value);
      }
    }
  }


  /** Asynchronous error handling return type for non-nullable API method returns. */
  public interface Result<T> {
    /** Success case callback method for handling returns. */
    void success(@NonNull T result);

    /** Failure case callback method for handling errors. */
    void error(@NonNull Throwable error);
  }
  /** Asynchronous error handling return type for nullable API method returns. */
  public interface NullableResult<T> {
    /** Success case callback method for handling returns. */
    void success(@Nullable T result);

    /** Failure case callback method for handling errors. */
    void error(@NonNull Throwable error);
  }
  /** Asynchronous error handling return type for void API method returns. */
  public interface VoidResult {
    /** Success case callback method for handling returns. */
    void success();

    /** Failure case callback method for handling errors. */
    void error(@NonNull Throwable error);
  }
  /**
   * Handles calls from Dart to the native side.
   *
   * Generated interface from Pigeon that represents a handler of messages from Flutter.
   */
  public interface CameraApi {
    /** Returns the list of available cameras. */
    @NonNull 
    List<PlatformCameraDescription> getAvailableCameras();

    /** The codec used by CameraApi. */
    static @NonNull MessageCodec<Object> getCodec() {
      return PigeonCodec.INSTANCE;
    }
    /**Sets up an instance of `CameraApi` to handle messages through the `binaryMessenger`. */
    static void setUp(@NonNull BinaryMessenger binaryMessenger, @Nullable CameraApi api) {
      setUp(binaryMessenger, "", api);
    }
    static void setUp(@NonNull BinaryMessenger binaryMessenger, @NonNull String messageChannelSuffix, @Nullable CameraApi api) {
      messageChannelSuffix = messageChannelSuffix.isEmpty() ? "" : "." + messageChannelSuffix;
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.camera_android.CameraApi.getAvailableCameras" + messageChannelSuffix, getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<>();
                try {
                  List<PlatformCameraDescription> output = api.getAvailableCameras();
                  wrapped.add(0, output);
                }
 catch (Throwable exception) {
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
  /**
   * Handles calls from native side to Dart that are not camera-specific.
   *
   * Generated class from Pigeon that represents Flutter messages that can be called from Java.
   */
  public static class CameraGlobalEventApi {
    private final @NonNull BinaryMessenger binaryMessenger;
    private final String messageChannelSuffix;

    public CameraGlobalEventApi(@NonNull BinaryMessenger argBinaryMessenger) {
      this(argBinaryMessenger, "");
    }
    public CameraGlobalEventApi(@NonNull BinaryMessenger argBinaryMessenger, @NonNull String messageChannelSuffix) {
      this.binaryMessenger = argBinaryMessenger;
      this.messageChannelSuffix = messageChannelSuffix.isEmpty() ? "" : "." + messageChannelSuffix;
    }

    /**
     * Public interface for sending reply.
     * The codec used by CameraGlobalEventApi.
     */
    static @NonNull MessageCodec<Object> getCodec() {
      return PigeonCodec.INSTANCE;
    }
    /** Called when the device's physical orientation changes. */
    public void deviceOrientationChanged(@NonNull PlatformDeviceOrientation orientationArg, @NonNull VoidResult result) {
      final String channelName = "dev.flutter.pigeon.camera_android.CameraGlobalEventApi.deviceOrientationChanged" + messageChannelSuffix;
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, channelName, getCodec());
      channel.send(
          new ArrayList<>(Collections.singletonList(orientationArg)),
          channelReply -> {
            if (channelReply instanceof List) {
              List<Object> listReply = (List<Object>) channelReply;
              if (listReply.size() > 1) {
                result.error(new FlutterError((String) listReply.get(0), (String) listReply.get(1), listReply.get(2)));
              } else {
                result.success();
              }
            }  else {
              result.error(createConnectionError(channelName));
            } 
          });
    }
  }
  /**
   * Handles device-specific calls from native side to Dart.
   *
   * Generated class from Pigeon that represents Flutter messages that can be called from Java.
   */
  public static class CameraEventApi {
    private final @NonNull BinaryMessenger binaryMessenger;
    private final String messageChannelSuffix;

    public CameraEventApi(@NonNull BinaryMessenger argBinaryMessenger) {
      this(argBinaryMessenger, "");
    }
    public CameraEventApi(@NonNull BinaryMessenger argBinaryMessenger, @NonNull String messageChannelSuffix) {
      this.binaryMessenger = argBinaryMessenger;
      this.messageChannelSuffix = messageChannelSuffix.isEmpty() ? "" : "." + messageChannelSuffix;
    }

    /**
     * Public interface for sending reply.
     * The codec used by CameraEventApi.
     */
    static @NonNull MessageCodec<Object> getCodec() {
      return PigeonCodec.INSTANCE;
    }
    /** Called when the camera is initialized. */
    public void initialized(@NonNull PlatformCameraState initialStateArg, @NonNull VoidResult result) {
      final String channelName = "dev.flutter.pigeon.camera_android.CameraEventApi.initialized" + messageChannelSuffix;
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, channelName, getCodec());
      channel.send(
          new ArrayList<>(Collections.singletonList(initialStateArg)),
          channelReply -> {
            if (channelReply instanceof List) {
              List<Object> listReply = (List<Object>) channelReply;
              if (listReply.size() > 1) {
                result.error(new FlutterError((String) listReply.get(0), (String) listReply.get(1), listReply.get(2)));
              } else {
                result.success();
              }
            }  else {
              result.error(createConnectionError(channelName));
            } 
          });
    }
    /** Called when an error occurs in the camera. */
    public void error(@NonNull String messageArg, @NonNull VoidResult result) {
      final String channelName = "dev.flutter.pigeon.camera_android.CameraEventApi.error" + messageChannelSuffix;
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, channelName, getCodec());
      channel.send(
          new ArrayList<>(Collections.singletonList(messageArg)),
          channelReply -> {
            if (channelReply instanceof List) {
              List<Object> listReply = (List<Object>) channelReply;
              if (listReply.size() > 1) {
                result.error(new FlutterError((String) listReply.get(0), (String) listReply.get(1), listReply.get(2)));
              } else {
                result.success();
              }
            }  else {
              result.error(createConnectionError(channelName));
            } 
          });
    }
  }
}
