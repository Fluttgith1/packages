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

enum class NullFieldsSearchReplyType(val raw: Int) {
  SUCCESS(0),
  FAILURE(1);

  companion object {
    fun ofRaw(raw: Int): NullFieldsSearchReplyType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class NullFieldsSearchRequest (
  val query: String? = null,
  val identifier: Long

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(result: List<Any?>): NullFieldsSearchRequest {
      val list = result.first() as List<Any?>
      val query = list[0] as? String
      val identifier = list[1] as Long

      return NullFieldsSearchRequest(query, identifier)
    }
  }
  fun toList(): MutableList<MutableList<Any?>> {
    val list = mutableListOf<Any?>()
    list.add(query)
    list.add(identifier)
    return mutableListOf<MutableList<Any?>>(list)
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class NullFieldsSearchReply (
  val result: String? = null,
  val error: String? = null,
  val indices: List<Long?>? = null,
  val request: NullFieldsSearchRequest? = null,
  val type: NullFieldsSearchReplyType? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(result: List<Any?>): NullFieldsSearchReply {
      val list = result.first() as List<Any?>
      val result = list[0] as? String
      val error = list[1] as? String
      val indices = list[2] as? List<Long?>
      val request: NullFieldsSearchRequest? = (list[3] as? List<Any?>)?.let {
        NullFieldsSearchRequest.fromList(it)
      }
      val type: NullFieldsSearchReplyType? = (list[4] as? Int)?.let {
        NullFieldsSearchReplyType.ofRaw(it)
      }

      return NullFieldsSearchReply(result, error, indices, request, type)
    }
  }
  fun toList(): MutableList<MutableList<Any?>> {
    val list = mutableListOf<Any?>()
    list.add(result)
    list.add(error)
    list.add(indices)
    list.add(request?.toList())
    list.add(type?.raw)
    return mutableListOf<MutableList<Any?>>(list)
  }
}
@Suppress("UNCHECKED_CAST")
private object NullFieldsHostApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          NullFieldsSearchReply.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          NullFieldsSearchRequest.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is NullFieldsSearchReply -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is NullFieldsSearchRequest -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface NullFieldsHostApi {
  fun search(nested: NullFieldsSearchRequest): NullFieldsSearchReply

  companion object {
    /** The codec used by NullFieldsHostApi. */
    val codec: MessageCodec<Any?> by lazy {
      NullFieldsHostApiCodec
    }
    /** Sets up an instance of `NullFieldsHostApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: NullFieldsHostApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.NullFieldsHostApi.search", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val wrapped = mutableListOf<Any?>()
            try {
              val args = message as List<Any?>
              val nestedArg = args[0] as NullFieldsSearchRequest
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
private object NullFieldsFlutterApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          NullFieldsSearchReply.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          NullFieldsSearchRequest.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is NullFieldsSearchReply -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is NullFieldsSearchRequest -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class NullFieldsFlutterApi(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by NullFieldsFlutterApi. */
    val codec: MessageCodec<Any?> by lazy {
      NullFieldsFlutterApiCodec
    }
  }
  fun search(requestArg: NullFieldsSearchRequest, callback: (NullFieldsSearchReply) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.NullFieldsFlutterApi.search", codec)
    channel.send(listOf(requestArg)) {
      val result = it as NullFieldsSearchReply
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
