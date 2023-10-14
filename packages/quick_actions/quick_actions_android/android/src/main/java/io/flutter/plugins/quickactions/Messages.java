// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package io.flutter.plugins.quickactions;

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
import java.util.Collections;
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

  /**
   * Home screen quick-action shortcut item.
   *
   * <p>Generated class from Pigeon that represents data sent in messages.
   */
  public static final class ShortcutItemMessage {
    /** The identifier of this item; should be unique within the app. */
    private @NonNull String type;

    public @NonNull String getType() {
      return type;
    }

    public void setType(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"type\" is null.");
      }
      this.type = setterArg;
    }

    /** Localized title of the item. */
    private @NonNull String localizedTitle;

    public @NonNull String getLocalizedTitle() {
      return localizedTitle;
    }

    public void setLocalizedTitle(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"localizedTitle\" is null.");
      }
      this.localizedTitle = setterArg;
    }

    /** Name of native resource to be displayed as the icon for this item. */
    private @Nullable String icon;

    public @Nullable String getIcon() {
      return icon;
    }

    public void setIcon(@Nullable String setterArg) {
      this.icon = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    ShortcutItemMessage() {}

    public static final class Builder {

      private @Nullable String type;

      public @NonNull Builder setType(@NonNull String setterArg) {
        this.type = setterArg;
        return this;
      }

      private @Nullable String localizedTitle;

      public @NonNull Builder setLocalizedTitle(@NonNull String setterArg) {
        this.localizedTitle = setterArg;
        return this;
      }

      private @Nullable String icon;

      public @NonNull Builder setIcon(@Nullable String setterArg) {
        this.icon = setterArg;
        return this;
      }

      public @NonNull ShortcutItemMessage build() {
        ShortcutItemMessage pigeonReturn = new ShortcutItemMessage();
        pigeonReturn.setType(type);
        pigeonReturn.setLocalizedTitle(localizedTitle);
        pigeonReturn.setIcon(icon);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(3);
      toListResult.add(type);
      toListResult.add(localizedTitle);
      toListResult.add(icon);
      return toListResult;
    }

    static @NonNull ShortcutItemMessage fromList(@NonNull ArrayList<Object> list) {
      ShortcutItemMessage pigeonResult = new ShortcutItemMessage();
      Object type = list.get(0);
      pigeonResult.setType((String) type);
      Object localizedTitle = list.get(1);
      pigeonResult.setLocalizedTitle((String) localizedTitle);
      Object icon = list.get(2);
      pigeonResult.setIcon((String) icon);
      return pigeonResult;
    }
  }

  private static class AndroidQuickActionsApiCodec extends StandardMessageCodec {
    public static final AndroidQuickActionsApiCodec INSTANCE = new AndroidQuickActionsApiCodec();

    private AndroidQuickActionsApiCodec() {}

    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return ShortcutItemMessage.fromList((ArrayList<Object>) readValue(buffer));
        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value) {
      if (value instanceof ShortcutItemMessage) {
        stream.write(128);
        writeValue(stream, ((ShortcutItemMessage) value).toList());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface AndroidQuickActionsApi {
    /** Checks for, and returns the action that launched the app. */
    @Nullable
    String getLaunchAction();
    /** Sets the dynamic shortcuts for the app. */
    void setShortcutItems(@NonNull List<ShortcutItemMessage> itemsList);
    /** Removes all dynamic shortcuts. */
    void clearShortcutItems();

    /** The codec used by AndroidQuickActionsApi. */
    static @NonNull MessageCodec<Object> getCodec() {
      return AndroidQuickActionsApiCodec.INSTANCE;
    }
    /**
     * Sets up an instance of `AndroidQuickActionsApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setup(
        @NonNull BinaryMessenger binaryMessenger, @Nullable AndroidQuickActionsApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.quick_actions_android.AndroidQuickActionsApi.getLaunchAction",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                try {
                  String output = api.getLaunchAction();
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
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.quick_actions_android.AndroidQuickActionsApi.setShortcutItems",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                List<ShortcutItemMessage> itemsListArg = (List<ShortcutItemMessage>) args.get(0);
                try {
                  api.setShortcutItems(itemsListArg);
                  wrapped.add(0, null);
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
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.quick_actions_android.AndroidQuickActionsApi.clearShortcutItems",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                try {
                  api.clearShortcutItems();
                  wrapped.add(0, null);
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
  /** Generated class from Pigeon that represents Flutter messages that can be called from Java. */
  public static class AndroidQuickActionsFlutterApi {
    private final @NonNull BinaryMessenger binaryMessenger;

    public AndroidQuickActionsFlutterApi(@NonNull BinaryMessenger argBinaryMessenger) {
      this.binaryMessenger = argBinaryMessenger;
    }

    /** Public interface for sending reply. */
    @SuppressWarnings("UnknownNullness")
    public interface Reply<T> {
      void reply(T reply);
    }
    /** The codec used by AndroidQuickActionsFlutterApi. */
    static @NonNull MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }
    /** Sends a string representing a shortcut from the native platform to the app. */
    public void launchAction(@NonNull String actionArg, @NonNull Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger,
              "dev.flutter.pigeon.quick_actions_android.AndroidQuickActionsFlutterApi.launchAction",
              getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(actionArg)),
          channelReply -> callback.reply(null));
    }
  }
}
