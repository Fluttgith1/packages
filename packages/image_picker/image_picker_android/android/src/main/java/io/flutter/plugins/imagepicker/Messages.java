// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v9.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package io.flutter.plugins.imagepicker;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

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
    ArrayList<Object> errorList = new ArrayList<Object>(3);
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

  public enum SourceCamera {
    REAR(0),
    FRONT(1);

    final int index;

    private SourceCamera(final int index) {
      this.index = index;
    }
  }

  public enum SourceType {
    CAMERA(0),
    GALLERY(1);

    final int index;

    private SourceType(final int index) {
      this.index = index;
    }
  }

  public enum CacheRetrievalType {
    IMAGE(0),
    VIDEO(1);

    final int index;

    private CacheRetrievalType(final int index) {
      this.index = index;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class GeneralOptions {
    private @NonNull Boolean allowMultiple;

    public @NonNull Boolean getAllowMultiple() {
      return allowMultiple;
    }

    public void setAllowMultiple(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"allowMultiple\" is null.");
      }
      this.allowMultiple = setterArg;
    }

    private @NonNull Boolean usePhotoPicker;

    public @NonNull Boolean getUsePhotoPicker() {
      return usePhotoPicker;
    }

    public void setUsePhotoPicker(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"usePhotoPicker\" is null.");
      }
      this.usePhotoPicker = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    GeneralOptions() {}

    public static final class Builder {

      private @Nullable Boolean allowMultiple;

      public @NonNull Builder setAllowMultiple(@NonNull Boolean setterArg) {
        this.allowMultiple = setterArg;
        return this;
      }

      private @Nullable Boolean usePhotoPicker;

      public @NonNull Builder setUsePhotoPicker(@NonNull Boolean setterArg) {
        this.usePhotoPicker = setterArg;
        return this;
      }

      public @NonNull GeneralOptions build() {
        GeneralOptions pigeonReturn = new GeneralOptions();
        pigeonReturn.setAllowMultiple(allowMultiple);
        pigeonReturn.setUsePhotoPicker(usePhotoPicker);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(2);
      toListResult.add(allowMultiple);
      toListResult.add(usePhotoPicker);
      return toListResult;
    }

    static @NonNull GeneralOptions fromList(@NonNull ArrayList<Object> list) {
      GeneralOptions pigeonResult = new GeneralOptions();
      Object allowMultiple = list.get(0);
      pigeonResult.setAllowMultiple((Boolean) allowMultiple);
      Object usePhotoPicker = list.get(1);
      pigeonResult.setUsePhotoPicker((Boolean) usePhotoPicker);
      return pigeonResult;
    }
  }

  /**
   * Options for image selection and output.
   *
   * <p>Generated class from Pigeon that represents data sent in messages.
   */
  public static final class ImageSelectionOptions {
    /** If set, the max width that the image should be resized to fit in. */
    private @Nullable Double maxWidth;

    public @Nullable Double getMaxWidth() {
      return maxWidth;
    }

    public void setMaxWidth(@Nullable Double setterArg) {
      this.maxWidth = setterArg;
    }

    /** If set, the max height that the image should be resized to fit in. */
    private @Nullable Double maxHeight;

    public @Nullable Double getMaxHeight() {
      return maxHeight;
    }

    public void setMaxHeight(@Nullable Double setterArg) {
      this.maxHeight = setterArg;
    }

    /**
     * The quality of the output image, from 0-100.
     *
     * <p>100 indicates original quality.
     */
    private @NonNull Long quality;

    public @NonNull Long getQuality() {
      return quality;
    }

    public void setQuality(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"quality\" is null.");
      }
      this.quality = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    ImageSelectionOptions() {}

    public static final class Builder {

      private @Nullable Double maxWidth;

      public @NonNull Builder setMaxWidth(@Nullable Double setterArg) {
        this.maxWidth = setterArg;
        return this;
      }

      private @Nullable Double maxHeight;

      public @NonNull Builder setMaxHeight(@Nullable Double setterArg) {
        this.maxHeight = setterArg;
        return this;
      }

      private @Nullable Long quality;

      public @NonNull Builder setQuality(@NonNull Long setterArg) {
        this.quality = setterArg;
        return this;
      }

      public @NonNull ImageSelectionOptions build() {
        ImageSelectionOptions pigeonReturn = new ImageSelectionOptions();
        pigeonReturn.setMaxWidth(maxWidth);
        pigeonReturn.setMaxHeight(maxHeight);
        pigeonReturn.setQuality(quality);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(3);
      toListResult.add(maxWidth);
      toListResult.add(maxHeight);
      toListResult.add(quality);
      return toListResult;
    }

    static @NonNull ImageSelectionOptions fromList(@NonNull ArrayList<Object> list) {
      ImageSelectionOptions pigeonResult = new ImageSelectionOptions();
      Object maxWidth = list.get(0);
      pigeonResult.setMaxWidth((Double) maxWidth);
      Object maxHeight = list.get(1);
      pigeonResult.setMaxHeight((Double) maxHeight);
      Object quality = list.get(2);
      pigeonResult.setQuality(
          (quality == null)
              ? null
              : ((quality instanceof Integer) ? (Integer) quality : (Long) quality));
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class MediaSelectionOptions {
    private @NonNull ImageSelectionOptions imageSelectionOptions;

    public @NonNull ImageSelectionOptions getImageSelectionOptions() {
      return imageSelectionOptions;
    }

    public void setImageSelectionOptions(@NonNull ImageSelectionOptions setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"imageSelectionOptions\" is null.");
      }
      this.imageSelectionOptions = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    MediaSelectionOptions() {}

    public static final class Builder {

      private @Nullable ImageSelectionOptions imageSelectionOptions;

      public @NonNull Builder setImageSelectionOptions(@NonNull ImageSelectionOptions setterArg) {
        this.imageSelectionOptions = setterArg;
        return this;
      }

      public @NonNull MediaSelectionOptions build() {
        MediaSelectionOptions pigeonReturn = new MediaSelectionOptions();
        pigeonReturn.setImageSelectionOptions(imageSelectionOptions);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(1);
      toListResult.add((imageSelectionOptions == null) ? null : imageSelectionOptions.toList());
      return toListResult;
    }

    static @NonNull MediaSelectionOptions fromList(@NonNull ArrayList<Object> list) {
      MediaSelectionOptions pigeonResult = new MediaSelectionOptions();
      Object imageSelectionOptions = list.get(0);
      pigeonResult.setImageSelectionOptions(
          (imageSelectionOptions == null)
              ? null
              : ImageSelectionOptions.fromList((ArrayList<Object>) imageSelectionOptions));
      return pigeonResult;
    }
  }

  /**
   * Options for image selection and output.
   *
   * <p>Generated class from Pigeon that represents data sent in messages.
   */
  public static final class VideoSelectionOptions {
    /** The maximum desired length for the video, in seconds. */
    private @Nullable Long maxDurationSeconds;

    public @Nullable Long getMaxDurationSeconds() {
      return maxDurationSeconds;
    }

    public void setMaxDurationSeconds(@Nullable Long setterArg) {
      this.maxDurationSeconds = setterArg;
    }

    public static final class Builder {

      private @Nullable Long maxDurationSeconds;

      public @NonNull Builder setMaxDurationSeconds(@Nullable Long setterArg) {
        this.maxDurationSeconds = setterArg;
        return this;
      }

      public @NonNull VideoSelectionOptions build() {
        VideoSelectionOptions pigeonReturn = new VideoSelectionOptions();
        pigeonReturn.setMaxDurationSeconds(maxDurationSeconds);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(1);
      toListResult.add(maxDurationSeconds);
      return toListResult;
    }

    static @NonNull VideoSelectionOptions fromList(@NonNull ArrayList<Object> list) {
      VideoSelectionOptions pigeonResult = new VideoSelectionOptions();
      Object maxDurationSeconds = list.get(0);
      pigeonResult.setMaxDurationSeconds(
          (maxDurationSeconds == null)
              ? null
              : ((maxDurationSeconds instanceof Integer)
                  ? (Integer) maxDurationSeconds
                  : (Long) maxDurationSeconds));
      return pigeonResult;
    }
  }

  /**
   * Specification for the source of an image or video selection.
   *
   * <p>Generated class from Pigeon that represents data sent in messages.
   */
  public static final class SourceSpecification {
    private @NonNull SourceType type;

    public @NonNull SourceType getType() {
      return type;
    }

    public void setType(@NonNull SourceType setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"type\" is null.");
      }
      this.type = setterArg;
    }

    private @Nullable SourceCamera camera;

    public @Nullable SourceCamera getCamera() {
      return camera;
    }

    public void setCamera(@Nullable SourceCamera setterArg) {
      this.camera = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    SourceSpecification() {}

    public static final class Builder {

      private @Nullable SourceType type;

      public @NonNull Builder setType(@NonNull SourceType setterArg) {
        this.type = setterArg;
        return this;
      }

      private @Nullable SourceCamera camera;

      public @NonNull Builder setCamera(@Nullable SourceCamera setterArg) {
        this.camera = setterArg;
        return this;
      }

      public @NonNull SourceSpecification build() {
        SourceSpecification pigeonReturn = new SourceSpecification();
        pigeonReturn.setType(type);
        pigeonReturn.setCamera(camera);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(2);
      toListResult.add(type == null ? null : type.index);
      toListResult.add(camera == null ? null : camera.index);
      return toListResult;
    }

    static @NonNull SourceSpecification fromList(@NonNull ArrayList<Object> list) {
      SourceSpecification pigeonResult = new SourceSpecification();
      Object type = list.get(0);
      pigeonResult.setType(type == null ? null : SourceType.values()[(int) type]);
      Object camera = list.get(1);
      pigeonResult.setCamera(camera == null ? null : SourceCamera.values()[(int) camera]);
      return pigeonResult;
    }
  }

  /**
   * An error that occurred during lost result retrieval.
   *
   * <p>The data here maps to the `PlatformException` that will be created from it.
   *
   * <p>Generated class from Pigeon that represents data sent in messages.
   */
  public static final class CacheRetrievalError {
    private @NonNull String code;

    public @NonNull String getCode() {
      return code;
    }

    public void setCode(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"code\" is null.");
      }
      this.code = setterArg;
    }

    private @Nullable String message;

    public @Nullable String getMessage() {
      return message;
    }

    public void setMessage(@Nullable String setterArg) {
      this.message = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    CacheRetrievalError() {}

    public static final class Builder {

      private @Nullable String code;

      public @NonNull Builder setCode(@NonNull String setterArg) {
        this.code = setterArg;
        return this;
      }

      private @Nullable String message;

      public @NonNull Builder setMessage(@Nullable String setterArg) {
        this.message = setterArg;
        return this;
      }

      public @NonNull CacheRetrievalError build() {
        CacheRetrievalError pigeonReturn = new CacheRetrievalError();
        pigeonReturn.setCode(code);
        pigeonReturn.setMessage(message);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(2);
      toListResult.add(code);
      toListResult.add(message);
      return toListResult;
    }

    static @NonNull CacheRetrievalError fromList(@NonNull ArrayList<Object> list) {
      CacheRetrievalError pigeonResult = new CacheRetrievalError();
      Object code = list.get(0);
      pigeonResult.setCode((String) code);
      Object message = list.get(1);
      pigeonResult.setMessage((String) message);
      return pigeonResult;
    }
  }

  /**
   * The result of retrieving cached results from a previous run.
   *
   * <p>Generated class from Pigeon that represents data sent in messages.
   */
  public static final class CacheRetrievalResult {
    /** The type of the retrieved data. */
    private @NonNull CacheRetrievalType type;

    public @NonNull CacheRetrievalType getType() {
      return type;
    }

    public void setType(@NonNull CacheRetrievalType setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"type\" is null.");
      }
      this.type = setterArg;
    }

    /** The error from the last selection, if any. */
    private @Nullable CacheRetrievalError error;

    public @Nullable CacheRetrievalError getError() {
      return error;
    }

    public void setError(@Nullable CacheRetrievalError setterArg) {
      this.error = setterArg;
    }

    /**
     * The results from the last selection, if any.
     *
     * <p>Elements must not be null, by convention. See
     * https://github.com/flutter/flutter/issues/97848
     */
    private @NonNull List<String> paths;

    public @NonNull List<String> getPaths() {
      return paths;
    }

    public void setPaths(@NonNull List<String> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"paths\" is null.");
      }
      this.paths = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    CacheRetrievalResult() {}

    public static final class Builder {

      private @Nullable CacheRetrievalType type;

      public @NonNull Builder setType(@NonNull CacheRetrievalType setterArg) {
        this.type = setterArg;
        return this;
      }

      private @Nullable CacheRetrievalError error;

      public @NonNull Builder setError(@Nullable CacheRetrievalError setterArg) {
        this.error = setterArg;
        return this;
      }

      private @Nullable List<String> paths;

      public @NonNull Builder setPaths(@NonNull List<String> setterArg) {
        this.paths = setterArg;
        return this;
      }

      public @NonNull CacheRetrievalResult build() {
        CacheRetrievalResult pigeonReturn = new CacheRetrievalResult();
        pigeonReturn.setType(type);
        pigeonReturn.setError(error);
        pigeonReturn.setPaths(paths);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(3);
      toListResult.add(type == null ? null : type.index);
      toListResult.add((error == null) ? null : error.toList());
      toListResult.add(paths);
      return toListResult;
    }

    static @NonNull CacheRetrievalResult fromList(@NonNull ArrayList<Object> list) {
      CacheRetrievalResult pigeonResult = new CacheRetrievalResult();
      Object type = list.get(0);
      pigeonResult.setType(type == null ? null : CacheRetrievalType.values()[(int) type]);
      Object error = list.get(1);
      pigeonResult.setError(
          (error == null) ? null : CacheRetrievalError.fromList((ArrayList<Object>) error));
      Object paths = list.get(2);
      pigeonResult.setPaths((List<String>) paths);
      return pigeonResult;
    }
  }

  public interface Result<T> {
    @SuppressWarnings("UnknownNullness")
    void success(T result);

    void error(@NonNull Throwable error);
  }

  private static class ImagePickerApiCodec extends StandardMessageCodec {
    public static final ImagePickerApiCodec INSTANCE = new ImagePickerApiCodec();

    private ImagePickerApiCodec() {}

    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return CacheRetrievalError.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 129:
          return CacheRetrievalResult.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 130:
          return GeneralOptions.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 131:
          return ImageSelectionOptions.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 132:
          return MediaSelectionOptions.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 133:
          return SourceSpecification.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 134:
          return VideoSelectionOptions.fromList((ArrayList<Object>) readValue(buffer));
        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value) {
      if (value instanceof CacheRetrievalError) {
        stream.write(128);
        writeValue(stream, ((CacheRetrievalError) value).toList());
      } else if (value instanceof CacheRetrievalResult) {
        stream.write(129);
        writeValue(stream, ((CacheRetrievalResult) value).toList());
      } else if (value instanceof GeneralOptions) {
        stream.write(130);
        writeValue(stream, ((GeneralOptions) value).toList());
      } else if (value instanceof ImageSelectionOptions) {
        stream.write(131);
        writeValue(stream, ((ImageSelectionOptions) value).toList());
      } else if (value instanceof MediaSelectionOptions) {
        stream.write(132);
        writeValue(stream, ((MediaSelectionOptions) value).toList());
      } else if (value instanceof SourceSpecification) {
        stream.write(133);
        writeValue(stream, ((SourceSpecification) value).toList());
      } else if (value instanceof VideoSelectionOptions) {
        stream.write(134);
        writeValue(stream, ((VideoSelectionOptions) value).toList());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface ImagePickerApi {
    /**
     * Selects images and returns their paths.
     *
     * <p>Elements must not be null, by convention. See
     * https://github.com/flutter/flutter/issues/97848
     */
    void pickImages(
        @NonNull SourceSpecification source,
        @NonNull ImageSelectionOptions options,
        @NonNull GeneralOptions generalOptions,
        @NonNull Result<List<String>> result);
    /**
     * Selects video and returns their paths.
     *
     * <p>Elements must not be null, by convention. See
     * https://github.com/flutter/flutter/issues/97848
     */
    void pickVideos(
        @NonNull SourceSpecification source,
        @NonNull VideoSelectionOptions options,
        @NonNull GeneralOptions generalOptions,
        @NonNull Result<List<String>> result);
    /**
     * Selects images and videos and returns their paths.
     *
     * <p>Elements must not be null, by convention. See
     * https://github.com/flutter/flutter/issues/97848
     */
    void pickMedia(
        @NonNull MediaSelectionOptions mediaSelectionOptions,
        @NonNull GeneralOptions generalOptions,
        @NonNull Result<List<String>> result);
    /** Returns results from a previous app session, if any. */
    @Nullable
    CacheRetrievalResult retrieveLostResults();

    /** The codec used by ImagePickerApi. */
    static @NonNull MessageCodec<Object> getCodec() {
      return ImagePickerApiCodec.INSTANCE;
    }
    /** Sets up an instance of `ImagePickerApi` to handle messages through the `binaryMessenger`. */
    static void setup(@NonNull BinaryMessenger binaryMessenger, @Nullable ImagePickerApi api) {
      {
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.ImagePickerApi.pickImages",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                SourceSpecification sourceArg = (SourceSpecification) args.get(0);
                ImageSelectionOptions optionsArg = (ImageSelectionOptions) args.get(1);
                GeneralOptions generalOptionsArg = (GeneralOptions) args.get(2);
                Result<List<String>> resultCallback =
                    new Result<List<String>>() {
                      public void success(List<String> result) {
                        wrapped.add(0, result);
                        reply.reply(wrapped);
                      }

                      public void error(Throwable error) {
                        ArrayList<Object> wrappedError = wrapError(error);
                        reply.reply(wrappedError);
                      }
                    };

                api.pickImages(sourceArg, optionsArg, generalOptionsArg, resultCallback);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.ImagePickerApi.pickVideos",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                SourceSpecification sourceArg = (SourceSpecification) args.get(0);
                VideoSelectionOptions optionsArg = (VideoSelectionOptions) args.get(1);
                GeneralOptions generalOptionsArg = (GeneralOptions) args.get(2);
                Result<List<String>> resultCallback =
                    new Result<List<String>>() {
                      public void success(List<String> result) {
                        wrapped.add(0, result);
                        reply.reply(wrapped);
                      }

                      public void error(Throwable error) {
                        ArrayList<Object> wrappedError = wrapError(error);
                        reply.reply(wrappedError);
                      }
                    };

                api.pickVideos(sourceArg, optionsArg, generalOptionsArg, resultCallback);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.ImagePickerApi.pickMedia", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                MediaSelectionOptions mediaSelectionOptionsArg =
                    (MediaSelectionOptions) args.get(0);
                GeneralOptions generalOptionsArg = (GeneralOptions) args.get(1);
                Result<List<String>> resultCallback =
                    new Result<List<String>>() {
                      public void success(List<String> result) {
                        wrapped.add(0, result);
                        reply.reply(wrapped);
                      }

                      public void error(Throwable error) {
                        ArrayList<Object> wrappedError = wrapError(error);
                        reply.reply(wrappedError);
                      }
                    };

                api.pickMedia(mediaSelectionOptionsArg, generalOptionsArg, resultCallback);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.ImagePickerApi.retrieveLostResults",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                try {
                  CacheRetrievalResult output = api.retrieveLostResults();
                  wrapped.add(0, output);
                } catch (Throwable exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
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
