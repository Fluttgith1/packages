// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// Autogenerated from Pigeon, do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

class FlutterSearchRequest {
  FlutterSearchRequest({
    this.query,
  });

  String? query;

  Object encode() {
    return <Object?>[
      query,
    ];
  }

  static FlutterSearchRequest decode(Object result) {
    result as List<Object?>;
    return FlutterSearchRequest(
      query: result[0] as String?,
    );
  }
}

class FlutterSearchReply {
  FlutterSearchReply({
    this.result,
    this.error,
  });

  String? result;

  String? error;

  Object encode() {
    return <Object?>[
      result,
      error,
    ];
  }

  static FlutterSearchReply decode(Object result) {
    result as List<Object?>;
    return FlutterSearchReply(
      result: result[0] as String?,
      error: result[1] as String?,
    );
  }
}

class FlutterSearchRequests {
  FlutterSearchRequests({
    this.requests,
  });

  List<Object?>? requests;

  Object encode() {
    return <Object?>[
      requests,
    ];
  }

  static FlutterSearchRequests decode(Object result) {
    result as List<Object?>;
    return FlutterSearchRequests(
      requests: result[0] as List<Object?>?,
    );
  }
}

class FlutterSearchReplies {
  FlutterSearchReplies({
    this.replies,
  });

  List<Object?>? replies;

  Object encode() {
    return <Object?>[
      replies,
    ];
  }

  static FlutterSearchReplies decode(Object result) {
    result as List<Object?>;
    return FlutterSearchReplies(
      replies: result[0] as List<Object?>?,
    );
  }
}

class _ApiCodec extends StandardMessageCodec {
  const _ApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is FlutterSearchReplies) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is FlutterSearchReply) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is FlutterSearchRequest) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is FlutterSearchRequests) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return FlutterSearchReplies.decode(readValue(buffer)!);
      case 129:
        return FlutterSearchReply.decode(readValue(buffer)!);
      case 130:
        return FlutterSearchRequest.decode(readValue(buffer)!);
      case 131:
        return FlutterSearchRequests.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class Api {
  /// Constructor for [Api].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  Api({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _ApiCodec();

  Future<FlutterSearchReply> search(FlutterSearchRequest arg_request) async {
    const String channelName =
        'dev.flutter.pigeon.pigeon_integration_tests.Api.search';
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      channelName,
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_request]) as List<Object?>?;
    if (replyList == null) {
      throw _createConnectionError(channelName);
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as FlutterSearchReply?)!;
    }
  }

  Future<FlutterSearchReplies> doSearches(
      FlutterSearchRequests arg_request) async {
    const String channelName =
        'dev.flutter.pigeon.pigeon_integration_tests.Api.doSearches';
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      channelName,
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_request]) as List<Object?>?;
    if (replyList == null) {
      throw _createConnectionError(channelName);
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as FlutterSearchReplies?)!;
    }
  }

  Future<FlutterSearchRequests> echo(FlutterSearchRequests arg_requests) async {
    const String channelName =
        'dev.flutter.pigeon.pigeon_integration_tests.Api.echo';
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      channelName,
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_requests]) as List<Object?>?;
    if (replyList == null) {
      throw _createConnectionError(channelName);
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as FlutterSearchRequests?)!;
    }
  }

  Future<int> anInt(int arg_value) async {
    const String channelName =
        'dev.flutter.pigeon.pigeon_integration_tests.Api.anInt';
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
      channelName,
      codec,
      binaryMessenger: _binaryMessenger,
    );
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_value]) as List<Object?>?;
    if (replyList == null) {
      throw _createConnectionError(channelName);
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as int?)!;
    }
  }
}
