// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// Autogenerated from Pigeon (v3.0.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

enum MessageRequestState {
  pending,
  success,
  failure,
}

class MessageSearchRequest {
  MessageSearchRequest({
    this.query,
    this.anInt,
    this.aBool,
  });

  String? query;
  int? anInt;
  bool? aBool;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['query'] = query;
    pigeonMap['anInt'] = anInt;
    pigeonMap['aBool'] = aBool;
    return pigeonMap;
  }

  static MessageSearchRequest decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MessageSearchRequest(
      query: pigeonMap['query'] as String?,
      anInt: pigeonMap['anInt'] as int?,
      aBool: pigeonMap['aBool'] as bool?,
    );
  }
}

class MessageSearchReply {
  MessageSearchReply({
    this.result,
    this.error,
    this.state,
  });

  String? result;
  String? error;
  MessageRequestState? state;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['result'] = result;
    pigeonMap['error'] = error;
    pigeonMap['state'] = state?.index;
    return pigeonMap;
  }

  static MessageSearchReply decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MessageSearchReply(
      result: pigeonMap['result'] as String?,
      error: pigeonMap['error'] as String?,
      state: pigeonMap['state'] != null
          ? MessageRequestState.values[pigeonMap['state']! as int]
          : null,
    );
  }
}

class MessageNested {
  MessageNested({
    this.request,
  });

  MessageSearchRequest? request;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['request'] = request?.encode();
    return pigeonMap;
  }

  static MessageNested decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return MessageNested(
      request: pigeonMap['request'] != null
          ? MessageSearchRequest.decode(pigeonMap['request']!)
          : null,
    );
  }
}

class _MessageApiCodec extends StandardMessageCodec {
  const _MessageApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is MessageSearchReply) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is MessageSearchRequest) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return MessageSearchReply.decode(readValue(buffer)!);

      case 129:
        return MessageSearchRequest.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class MessageApi {
  /// Constructor for [MessageApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MessageApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _MessageApiCodec();

  Future<void> initialize() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MessageApi.initialize', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<MessageSearchReply> search(MessageSearchRequest arg_request) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MessageApi.search', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_request]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as MessageSearchReply?)!;
    }
  }
}

class _MessageNestedApiCodec extends StandardMessageCodec {
  const _MessageNestedApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is MessageNested) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is MessageSearchReply) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is MessageSearchRequest) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return MessageNested.decode(readValue(buffer)!);

      case 129:
        return MessageSearchReply.decode(readValue(buffer)!);

      case 130:
        return MessageSearchRequest.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class MessageNestedApi {
  /// Constructor for [MessageNestedApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MessageNestedApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _MessageNestedApiCodec();

  Future<MessageSearchReply> search(MessageNested arg_nested) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.MessageNestedApi.search', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_nested]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as MessageSearchReply?)!;
    }
  }
}

class _MessageFlutterSearchApiCodec extends StandardMessageCodec {
  const _MessageFlutterSearchApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is MessageSearchReply) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is MessageSearchRequest) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return MessageSearchReply.decode(readValue(buffer)!);

      case 129:
        return MessageSearchRequest.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class MessageFlutterSearchApi {
  static const MessageCodec<Object?> codec = _MessageFlutterSearchApiCodec();

  MessageSearchReply search(MessageSearchRequest request);
  static void setup(MessageFlutterSearchApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.MessageFlutterSearchApi.search', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.MessageFlutterSearchApi.search was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final MessageSearchRequest? arg_request =
              (args[0] as MessageSearchRequest?);
          assert(arg_request != null,
              'Argument for dev.flutter.pigeon.MessageFlutterSearchApi.search was null, expected non-null MessageSearchRequest.');
          final MessageSearchReply output = api.search(arg_request!);
          return output;
        });
      }
    }
  }
}
