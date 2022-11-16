// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// Autogenerated from Pigeon (v4.2.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.example.android_unit_tests;

import android.util.Log;
import androidx.annotation.NonNull;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.util.ArrayList;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class BackgroundPlatformChannels {
  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface BackgroundApi2Host {
    @NonNull
    Long add(@NonNull Long x, @NonNull Long y);

    /** The codec used by BackgroundApi2Host. */
    static MessageCodec<Object> getCodec() {
      return new StandardMessageCodec();
    }
    /**
     * Sets up an instance of `BackgroundApi2Host` to handle messages through the `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, BackgroundApi2Host api) {
      {
        BinaryMessenger.TaskQueue taskQueue = binaryMessenger.makeBackgroundTaskQueue();
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.BackgroundApi2Host.add",
                getCodec(),
                taskQueue);
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList wrapped = new ArrayList<>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  assert args != null;
                  Number xArg = (Number) args.get(0);
                  if (xArg == null) {
                    throw new NullPointerException("xArg unexpectedly null.");
                  }
                  Number yArg = (Number) args.get(1);
                  if (yArg == null) {
                    throw new NullPointerException("yArg unexpectedly null.");
                  }
                  Long output =
                      api.add(
                          (xArg == null) ? null : xArg.longValue(),
                          (yArg == null) ? null : yArg.longValue());
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
