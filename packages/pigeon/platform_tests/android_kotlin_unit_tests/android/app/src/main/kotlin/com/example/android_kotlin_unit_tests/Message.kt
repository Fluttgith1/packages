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

/**
 * This comment is to test enum documentation comments.
 *
 * This comment also tests multiple line comments.
 */
enum class MessageRequestState(val raw: Int) {
  PENDING(0),
  SUCCESS(1),
  FAILURE(2);

  companion object {
    fun ofRaw(raw: Int): MessageRequestState? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/**
 * This comment is to test class documentation comments.
 *
 * This comment also tests multiple line comments.
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class MessageSearchRequest (
  /** This comment is to test field documentation comments. */
  val query: String? = null,
  /** This comment is to test field documentation comments. */
  val anInt: Long? = null,
  /** This comment is to test field documentation comments. */
  val aBool: Boolean? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(result: List<Any?>): MessageSearchRequest {
      val list = result.first() as List<Any?>
      val query = list[0] as? String
      val anInt = list[1].let { if (it is Int) it.toLong() else it as? Long }
      val aBool = list[2] as? Boolean

      return MessageSearchRequest(query, anInt, aBool)
    }
  }
  fun toList(): MutableList<MutableList<Any?>> {
    val list = mutableListOf<Any?>()
    list.add(query)
    list.add(anInt)
    list.add(aBool)
    return mutableListOf<MutableList<Any?>>(list)
  }
}

/**
 * This comment is to test class documentation comments.
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class MessageSearchReply (
  /**
   * This comment is to test field documentation comments.
   *
   * This comment also tests multiple line comments.
   */
  val result: String? = null,
  /** This comment is to test field documentation comments. */
  val error: String? = null,
  /** This comment is to test field documentation comments. */
  val state: MessageRequestState? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(result: List<Any?>): MessageSearchReply {
      val list = result.first() as List<Any?>
      val result = list[0] as? String
      val error = list[1] as? String
      val state: MessageRequestState? = (list[2] as? Int)?.let {
        MessageRequestState.ofRaw(it)
      }

      return MessageSearchReply(result, error, state)
    }
  }
  fun toList(): MutableList<MutableList<Any?>> {
    val list = mutableListOf<Any?>()
    list.add(result)
    list.add(error)
    list.add(state?.raw)
    return mutableListOf<MutableList<Any?>>(list)
  }
}

/**
 * This comment is to test class documentation comments.
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class MessageNested (
  /** This comment is to test field documentation comments. */
  val request: MessageSearchRequest? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(result: List<Any?>): MessageNested {
      val list = result.first() as List<Any?>
      val request: MessageSearchRequest? = (list[0] as? List<Any?>)?.let {
        MessageSearchRequest.fromList(it)
      }

      return MessageNested(request)
    }
  }
  fun toList(): MutableList<MutableList<Any?>> {
    val list = mutableListOf<Any?>()
    list.add(request?.toList())
    return mutableListOf<MutableList<Any?>>(list)
  }
}
@Suppress("UNCHECKED_CAST")
private object MessageApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MessageSearchReply.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MessageSearchRequest.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is MessageSearchReply -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is MessageSearchRequest -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/**
 * This comment is to test api documentation comments.
 *
 * This comment also tests multiple line comments.
 *
 * Generated interface from Pigeon that represents a handler of messages from Flutter.
 */
interface MessageApi {
  /**
   * This comment is to test documentation comments.
   *
   * This comment also tests multiple line comments.
   */
  fun initialize()
  /** This comment is to test method documentation comments. */
  fun search(request: MessageSearchRequest): MessageSearchReply

  companion object {
    /** The codec used by MessageApi. */
    val codec: MessageCodec<Any?> by lazy {
      MessageApiCodec
    }
    /** Sets up an instance of `MessageApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: MessageApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.MessageApi.initialize", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            val wrapped = mutableListOf<Any?>()
            try {
              api.initialize()
              wrapped.add(null)
            } catch (exception: Error) {
              wrapped.add(wrapError(exception))
            
            reply.reply(wrapped)
          }
        }} else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.MessageApi.search", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val wrapped = mutableListOf<Any?>()
            try {
              val args = message as List<Any?>
              val requestArg = args[0] as MessageSearchRequest
              wrapped.add(api.search(requestArg))
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
private object MessageNestedApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MessageNested.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MessageSearchReply.fromList(it)
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MessageSearchRequest.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is MessageNested -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is MessageSearchReply -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      is MessageSearchRequest -> {
        stream.write(130)
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
interface MessageNestedApi {
  /**
   * This comment is to test method documentation comments.
   *
   * This comment also tests multiple line comments.
   */
  fun search(nested: MessageNested): MessageSearchReply

  companion object {
    /** The codec used by MessageNestedApi. */
    val codec: MessageCodec<Any?> by lazy {
      MessageNestedApiCodec
    }
    /** Sets up an instance of `MessageNestedApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: MessageNestedApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.MessageNestedApi.search", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val wrapped = mutableListOf<Any?>()
            try {
              val args = message as List<Any?>
              val nestedArg = args[0] as MessageNested
              wrapped.add(api.search(nestedArg))
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
private object MessageFlutterSearchApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MessageSearchReply.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MessageSearchRequest.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is MessageSearchReply -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is MessageSearchRequest -> {
        stream.write(129)
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
class MessageFlutterSearchApi(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by MessageFlutterSearchApi. */
    val codec: MessageCodec<Any?> by lazy {
      MessageFlutterSearchApiCodec
    }
  }
  /** This comment is to test method documentation comments. */
  fun search(requestArg: MessageSearchRequest, callback: (MessageSearchReply) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.MessageFlutterSearchApi.search", codec)
    channel.send(listOf(requestArg)) {
      val result = it as MessageSearchReply
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
