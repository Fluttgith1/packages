// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v9.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package io.flutter.plugins.sharedpreferences;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface SharedPreferencesApi {
    /** Removes property from shared preferences data set. */
    @NonNull
    Boolean remove(@NonNull String key);
    /** Adds property to shared preferences data set of type bool. */
    @NonNull
    Boolean setBool(@NonNull String key, @NonNull Boolean value);
    /** Adds property to shared preferences data set of type String. */
    @NonNull
    Boolean setString(@NonNull String key, @NonNull String value);
    /** Adds property to shared preferences data set of type int. */
    @NonNull
    Boolean setInt(@NonNull String key, @NonNull Long value);
    /** Adds property to shared preferences data set of type double. */
    @NonNull
    Boolean setDouble(@NonNull String key, @NonNull Double value);
    /** Adds property to shared preferences data set of type List<String>. */
    @NonNull
    Boolean setStringList(@NonNull String key, @NonNull List<String> value);
    /** Removes all properties from shared preferences data set with matching prefix. */
    @NonNull
    Boolean clear(@NonNull String prefix, @Nullable List<String> allowList);
    /** Gets all properties from shared preferences data set with matching prefix. */
    @NonNull
    Map<String, Object> getAll(@NonNull String prefix, @Nullable List<String> allowList);

    /** The codec used by SharedPreferencesApi. */
    static @NonNull MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }
    /**
     * Sets up an instance of `SharedPreferencesApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setup(
        @NonNull BinaryMessenger binaryMessenger, @Nullable SharedPreferencesApi api) {
      {
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.SharedPreferencesApi.remove",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                String keyArg = (String) args.get(0);
                try {
                  Boolean output = api.remove(keyArg);
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
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.SharedPreferencesApi.setBool",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                String keyArg = (String) args.get(0);
                Boolean valueArg = (Boolean) args.get(1);
                try {
                  Boolean output = api.setBool(keyArg, valueArg);
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
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.SharedPreferencesApi.setString",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                String keyArg = (String) args.get(0);
                String valueArg = (String) args.get(1);
                try {
                  Boolean output = api.setString(keyArg, valueArg);
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
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.SharedPreferencesApi.setInt",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                String keyArg = (String) args.get(0);
                Number valueArg = (Number) args.get(1);
                try {
                  Boolean output =
                      api.setInt(keyArg, (valueArg == null) ? null : valueArg.longValue());
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
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.SharedPreferencesApi.setDouble",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                String keyArg = (String) args.get(0);
                Double valueArg = (Double) args.get(1);
                try {
                  Boolean output = api.setDouble(keyArg, valueArg);
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
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.SharedPreferencesApi.setStringList",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                String keyArg = (String) args.get(0);
                List<String> valueArg = (List<String>) args.get(1);
                try {
                  Boolean output = api.setStringList(keyArg, valueArg);
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
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.SharedPreferencesApi.clear",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                String prefixArg = (String) args.get(0);
                List<String> allowListArg = (List<String>) args.get(1);
                try {
                  Boolean output = api.clear(prefixArg, allowListArg);
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
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.SharedPreferencesApi.getAll",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                String prefixArg = (String) args.get(0);
                List<String> allowListArg = (List<String>) args.get(1);
                try {
                  Map<String, Object> output = api.getAll(prefixArg, allowListArg);
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
