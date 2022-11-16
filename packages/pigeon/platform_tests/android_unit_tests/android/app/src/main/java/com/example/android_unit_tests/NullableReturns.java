// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// Autogenerated from Pigeon (v4.2.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.example.android_unit_tests;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class NullableReturns {
  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface NullableReturnHostApi {
    @Nullable
    Long doit();

    /** The codec used by NullableReturnHostApi. */
    static MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }
    /**
     * Sets up an instance of `NullableReturnHostApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, NullableReturnHostApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.NullableReturnHostApi.doit", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList wrapped = new ArrayList<>();
                try {
                  Long output = api.doit();
                  wrapped.add(output);
                } catch (Error | RuntimeException exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped.add(wrappedError.get(0));
                  wrapped.add(wrappedError.get(1));
                  wrapped.add(wrappedError.get(2));
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
  public static class NullableReturnFlutterApi {
    private final BinaryMessenger binaryMessenger;

    public NullableReturnFlutterApi(BinaryMessenger argBinaryMessenger) {
      this.binaryMessenger = argBinaryMessenger;
    }

    public interface Reply<T> {
      void reply(T reply);
    }
    /** The codec used by NullableReturnFlutterApi. */
    static MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }

    public void doit(Reply<Long> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.NullableReturnFlutterApi.doit", getCodec());
      channel.send(
          null,
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            Long output = channelReply == null ? null : ((Number) channelReply).longValue();
            callback.reply(output);
          });
    }
  }
  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface NullableArgHostApi {
    @NonNull
    Long doit(@Nullable Long x);

    /** The codec used by NullableArgHostApi. */
    static MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }
    /**
     * Sets up an instance of `NullableArgHostApi` to handle messages through the `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, NullableArgHostApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.NullableArgHostApi.doit", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList wrapped = new ArrayList<>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  assert args != null;
                  Number xArg = (Number) args.get(0);
                  Long output = api.doit((xArg == null) ? null : xArg.longValue());
                  wrapped.add(output);
                } catch (Error | RuntimeException exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped.add(wrappedError.get(0));
                  wrapped.add(wrappedError.get(1));
                  wrapped.add(wrappedError.get(2));
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
  public static class NullableArgFlutterApi {
    private final BinaryMessenger binaryMessenger;

    public NullableArgFlutterApi(BinaryMessenger argBinaryMessenger) {
      this.binaryMessenger = argBinaryMessenger;
    }

    public interface Reply<T> {
      void reply(T reply);
    }
    /** The codec used by NullableArgFlutterApi. */
    static MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }

    public void doit(@Nullable Long xArg, Reply<Long> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.NullableArgFlutterApi.doit", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(xArg)),
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            Long output = channelReply == null ? null : ((Number) channelReply).longValue();
            callback.reply(output);
          });
    }
  }
  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface NullableCollectionReturnHostApi {
    @Nullable
    List<String> doit();

    /** The codec used by NullableCollectionReturnHostApi. */
    static MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }
    /**
     * Sets up an instance of `NullableCollectionReturnHostApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, NullableCollectionReturnHostApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.NullableCollectionReturnHostApi.doit",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList wrapped = new ArrayList<>();
                try {
                  List<String> output = api.doit();
                  wrapped.add(output);
                } catch (Error | RuntimeException exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped.add(wrappedError.get(0));
                  wrapped.add(wrappedError.get(1));
                  wrapped.add(wrappedError.get(2));
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
  public static class NullableCollectionReturnFlutterApi {
    private final BinaryMessenger binaryMessenger;

    public NullableCollectionReturnFlutterApi(BinaryMessenger argBinaryMessenger) {
      this.binaryMessenger = argBinaryMessenger;
    }

    public interface Reply<T> {
      void reply(T reply);
    }
    /** The codec used by NullableCollectionReturnFlutterApi. */
    static MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }

    public void doit(Reply<List<String>> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger,
              "dev.flutter.pigeon.NullableCollectionReturnFlutterApi.doit",
              getCodec());
      channel.send(
          null,
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            List<String> output = (List<String>) channelReply;
            callback.reply(output);
          });
    }
  }
  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface NullableCollectionArgHostApi {
    @NonNull
    List<String> doit(@Nullable List<String> x);

    /** The codec used by NullableCollectionArgHostApi. */
    static MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }
    /**
     * Sets up an instance of `NullableCollectionArgHostApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, NullableCollectionArgHostApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.NullableCollectionArgHostApi.doit",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList wrapped = new ArrayList<>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  assert args != null;
                  List<String> xArg = (List<String>) args.get(0);
                  List<String> output = api.doit(xArg);
                  wrapped.add(output);
                } catch (Error | RuntimeException exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped.add(wrappedError.get(0));
                  wrapped.add(wrappedError.get(1));
                  wrapped.add(wrappedError.get(2));
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
  public static class NullableCollectionArgFlutterApi {
    private final BinaryMessenger binaryMessenger;

    public NullableCollectionArgFlutterApi(BinaryMessenger argBinaryMessenger) {
      this.binaryMessenger = argBinaryMessenger;
    }

    public interface Reply<T> {
      void reply(T reply);
    }
    /** The codec used by NullableCollectionArgFlutterApi. */
    static MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }

    public void doit(@Nullable List<String> xArg, Reply<List<String>> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger,
              "dev.flutter.pigeon.NullableCollectionArgFlutterApi.doit",
              getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(xArg)),
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            List<String> output = (List<String>) channelReply;
            callback.reply(output);
          });
    }
  }

  @NonNull
  private static ArrayList<Object> wrapError(@NonNull Throwable exception) {
    ArrayList<Object> errorList = new ArrayList<>();
    errorList.add(exception.toString());
    errorList.add(exception.getClass().getSimpleName());
    errorList.add(
        "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorList;
  }
}
