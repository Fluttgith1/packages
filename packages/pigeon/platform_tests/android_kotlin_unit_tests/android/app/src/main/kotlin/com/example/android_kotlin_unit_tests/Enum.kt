// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// 
// Autogenerated from Pigeon (v4.2.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.example.android_kotlin_unit_tests

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

/** Generated class from Pigeon. */

/** This comment is to test enum documentation comments. */
enum class EnumState(val raw: Int) {
  PENDING(0),
  SUCCESS(1),
  ERROR(2);

  companion object {
    fun ofRaw(raw: Int): EnumState? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/**
 * This comment is to test class documentation comments.
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class DataWithEnum (
  /** This comment is to test field documentation comments. */
  val state: EnumState? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(result: List<Any?>): DataWithEnum {
      val list = result.first() as List<Any?>
      val state: EnumState? = (list[0] as? Int)?.let {
        EnumState.ofRaw(it)
      }

      return DataWithEnum(state)
    }
  }
  fun toList(): MutableList<MutableList<Any?>> {
    val list = mutableListOf<Any?>()
    list.add(state?.raw)
    return mutableListOf<MutableList<Any?>>(list)
  }
}
@Suppress("UNCHECKED_CAST")
private object EnumApi2HostCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          DataWithEnum.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is DataWithEnum -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/**
 * This comment is to test api documentation comments.
 *
 * Generated interface from Pigeon that represents a handler of messages from Flutter.
 */
interface EnumApi2Host {
  /** This comment is to test method documentation comments. */
  fun echo(data: DataWithEnum): DataWithEnum

  companion object {
    /** The codec used by EnumApi2Host. */
    val codec: MessageCodec<Any?> by lazy {
      EnumApi2HostCodec
    }
    /** Sets up an instance of `EnumApi2Host` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: EnumApi2Host?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.EnumApi2Host.echo", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val wrapped = mutableListOf<Any?>()
            try {
              val args = message as List<Any?>
              val dataArg = args[0] as DataWithEnum
              wrapped.add(api.echo(dataArg))
            } catch (exception: Error) {
              wrapped.add(wrapError(exception))
            
            reply.reply(wrapped)
          }
        }} else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
@Suppress("UNCHECKED_CAST")
private object EnumApi2FlutterCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          DataWithEnum.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is DataWithEnum -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/**
 * This comment is to test api documentation comments.
 *
 * Generated class from Pigeon that represents Flutter messages that can be called from Kotlin.
 */
@Suppress("UNCHECKED_CAST")
class EnumApi2Flutter(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by EnumApi2Flutter. */
    val codec: MessageCodec<Any?> by lazy {
      EnumApi2FlutterCodec
    }
  }
  /** This comment is to test method documentation comments. */
  fun echo(dataArg: DataWithEnum, callback: (DataWithEnum) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.EnumApi2Flutter.echo", codec)
    channel.send(listOf(dataArg)) {
      val result = it as DataWithEnum
      callback(result)
    }
  }
}

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any> {
  return listOf<Any>(
    exception.javaClass.simpleName,
    exception.toString(),
    "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
  )
}
