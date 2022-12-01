// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// Autogenerated from Pigeon (v4.2.9), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class AllTypes {
  AllTypes({
    this.aBool,
    this.anInt,
    this.aDouble,
    this.aString,
    this.aByteArray,
    this.a4ByteArray,
    this.a8ByteArray,
    this.aFloatArray,
    this.aList,
    this.aMap,
    this.nestedList,
    this.mapWithAnnotations,
    this.mapWithObject,
  });

  bool? aBool;

  int? anInt;

  double? aDouble;

  String? aString;

  Uint8List? aByteArray;

  Int32List? a4ByteArray;

  Int64List? a8ByteArray;

  Float64List? aFloatArray;

  List<Object?>? aList;

  Map<Object?, Object?>? aMap;

  List<List<bool?>?>? nestedList;

  Map<String?, String?>? mapWithAnnotations;

  Map<String?, Object?>? mapWithObject;

  Object encode() {
    final List<Object?> pigeonList = <Object?>[];
    pigeonList.add(aBool);
    pigeonList.add(anInt);
    pigeonList.add(aDouble);
    pigeonList.add(aString);
    pigeonList.add(aByteArray);
    pigeonList.add(a4ByteArray);
    pigeonList.add(a8ByteArray);
    pigeonList.add(aFloatArray);
    pigeonList.add(aList);
    pigeonList.add(aMap);
    pigeonList.add(nestedList);
    pigeonList.add(mapWithAnnotations);
    pigeonList.add(mapWithObject);
    return pigeonList;
  }

  static AllTypes decode(Object result) {
    result as List<Object?>;
    return AllTypes(
      aBool: result[0] as bool?,
      anInt: result[1] as int?,
      aDouble: result[2] as double?,
      aString: result[3] as String?,
      aByteArray: result[4] as Uint8List?,
      a4ByteArray: result[5] as Int32List?,
      a8ByteArray: result[6] as Int64List?,
      aFloatArray: result[7] as Float64List?,
      aList: result[8] as List<Object?>?,
      aMap: result[9] as Map<Object?, Object?>?,
      nestedList: (result[10] as List<Object?>?)?.cast<List<bool?>?>(),
      mapWithAnnotations:
          (result[11] as Map<Object?, Object?>?)?.cast<String?, String?>(),
      mapWithObject:
          (result[12] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
    );
  }
}

class AllTypesWrapper {
  AllTypesWrapper({
    required this.values,
  });

  AllTypes values;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['values'] = values.encode();
    return pigeonMap;
  }

  static AllTypesWrapper decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return AllTypesWrapper(
      values: AllTypes.decode(pigeonMap['values']!),
    );
  }
}

class _HostIntegrationCoreApiCodec extends StandardMessageCodec {
  const _HostIntegrationCoreApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AllTypes) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is AllTypesWrapper) {
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
        return AllTypes.decode(readValue(buffer)! as List<Object?>);

      case 129:
        return AllTypesWrapper.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

/// The core interface that each host language plugin must implement in
/// platform_test integration tests.
class HostIntegrationCoreApi {
  /// Constructor for [HostIntegrationCoreApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  HostIntegrationCoreApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _HostIntegrationCoreApiCodec();

  /// A no-op function taking no arguments and returning no value, to sanity
  /// test basic calling.
  Future<void> noop() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.noop', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: (replyList[0] as String?)!,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  /// Returns the passed object, to test serialization and deserialization.
  Future<AllTypes> echoAllTypes(AllTypes arg_everything) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.echoAllTypes', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_everything]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: (replyList[0] as String?)!,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as AllTypes?)!;
    }
  }

  /// Returns an error, to test error handling.
  Future<void> throwError() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.throwError', codec,
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

  /// Returns the inner `aString` value from the wrapped object, to test
  /// sending of nested objects.
  Future<String?> extractNestedString(AllTypesWrapper arg_wrapper) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.extractNestedString', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_wrapper]) as Map<Object?, Object?>?;
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
      return (replyMap['result'] as String?);
    }
  }

  /// Returns the inner `aString` value from the wrapped object, to test
  /// sending of nested objects.
  Future<AllTypesWrapper> createNestedString(String arg_string) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.createNestedString', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_string]) as Map<Object?, Object?>?;
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
      return (replyMap['result'] as AllTypesWrapper?)!;
    }
  }
}

class _FlutterIntegrationCoreApiCodec extends StandardMessageCodec {
  const _FlutterIntegrationCoreApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AllTypes) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return AllTypes.decode(readValue(buffer)! as List<Object?>);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

/// The core interface that the Dart platform_test code implements for host
/// integration tests to call into.
abstract class FlutterIntegrationCoreApi {
  static const MessageCodec<Object?> codec = _FlutterIntegrationCoreApiCodec();

  /// A no-op function taking no arguments and returning no value, to sanity
  /// test basic calling.
  void noop();

  /// Returns the passed object, to test serialization and deserialization.
  AllTypes echoAllTypes(AllTypes everything);

  static void setup(FlutterIntegrationCoreApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterIntegrationCoreApi.noop', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          // ignore message
          api.noop();
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterIntegrationCoreApi.echoAllTypes', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterIntegrationCoreApi.echoAllTypes was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final AllTypes? arg_everything = (args[0] as AllTypes?);
          assert(arg_everything != null,
              'Argument for dev.flutter.pigeon.FlutterIntegrationCoreApi.echoAllTypes was null, expected non-null AllTypes.');
          final AllTypes output = api.echoAllTypes(arg_everything!);
          return output;
        });
      }
    }
  }
}

/// An API that can be implemented for minimal, compile-only tests.
class HostTrivialApi {
  /// Constructor for [HostTrivialApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  HostTrivialApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = StandardMessageCodec();

  Future<void> noop() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostTrivialApi.noop', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: (replyList[0] as String?)!,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}
