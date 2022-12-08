// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// Autogenerated from Pigeon (v4.2.10), do not edit directly.
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
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['aBool'] = aBool;
    pigeonMap['anInt'] = anInt;
    pigeonMap['aDouble'] = aDouble;
    pigeonMap['aString'] = aString;
    pigeonMap['aByteArray'] = aByteArray;
    pigeonMap['a4ByteArray'] = a4ByteArray;
    pigeonMap['a8ByteArray'] = a8ByteArray;
    pigeonMap['aFloatArray'] = aFloatArray;
    pigeonMap['aList'] = aList;
    pigeonMap['aMap'] = aMap;
    pigeonMap['nestedList'] = nestedList;
    pigeonMap['mapWithAnnotations'] = mapWithAnnotations;
    pigeonMap['mapWithObject'] = mapWithObject;
    return pigeonMap;
  }

  static AllTypes decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return AllTypes(
      aBool: pigeonMap['aBool'] as bool?,
      anInt: pigeonMap['anInt'] as int?,
      aDouble: pigeonMap['aDouble'] as double?,
      aString: pigeonMap['aString'] as String?,
      aByteArray: pigeonMap['aByteArray'] as Uint8List?,
      a4ByteArray: pigeonMap['a4ByteArray'] as Int32List?,
      a8ByteArray: pigeonMap['a8ByteArray'] as Int64List?,
      aFloatArray: pigeonMap['aFloatArray'] as Float64List?,
      aList: pigeonMap['aList'] as List<Object?>?,
      aMap: pigeonMap['aMap'] as Map<Object?, Object?>?,
      nestedList:
          (pigeonMap['nestedList'] as List<Object?>?)?.cast<List<bool?>?>(),
      mapWithAnnotations:
          (pigeonMap['mapWithAnnotations'] as Map<Object?, Object?>?)
              ?.cast<String?, String?>(),
      mapWithObject: (pigeonMap['mapWithObject'] as Map<Object?, Object?>?)
          ?.cast<String?, Object?>(),
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
        return AllTypes.decode(readValue(buffer)!);

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

  /// Returns the passed object, to test serialization and deserialization.
  Future<AllTypes> echoAllTypes(AllTypes arg_everything) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.echoAllTypes', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_everything]) as Map<Object?, Object?>?;
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
      return (replyMap['result'] as AllTypes?)!;
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

  /// Returns passed in arguments of multiple types.
  Future<AllTypes> sendMultipleTypes(
      bool arg_aBool, int arg_anInt, String arg_aString) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.sendMultipleTypes', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_aBool, arg_anInt, arg_aString])
            as Map<Object?, Object?>?;
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
      return (replyMap['result'] as AllTypes?)!;
    }
  }

  /// Returns passed in int.
  Future<int> echoInt(int arg_anInt) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.echoInt', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_anInt]) as Map<Object?, Object?>?;
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
      return (replyMap['result'] as int?)!;
    }
  }

  /// Returns the passed in boolean asynchronously.
  Future<bool> echoBool(bool arg_aBool) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.echoBool', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_aBool]) as Map<Object?, Object?>?;
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
      return (replyMap['result'] as bool?)!;
    }
  }

  /// A no-op function taking no arguments and returning no value, to sanity
  /// test basic asynchronous calling.
  Future<void> noopAsync() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.noopAsync', codec,
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

  /// Returns the passed string asynchronously.
  Future<String> echoAsyncString(String arg_aString) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.echoAsyncString', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_aString]) as Map<Object?, Object?>?;
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
      return (replyMap['result'] as String?)!;
    }
  }

  Future<void> callFlutterNoop() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.callFlutterNoop', codec,
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

  Future<String> callFlutterEchoString(String arg_aString) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostIntegrationCoreApi.callFlutterEchoString',
        codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_aString]) as Map<Object?, Object?>?;
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
      return (replyMap['result'] as String?)!;
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
        return AllTypes.decode(readValue(buffer)!);

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

  /// Returns the passed string, to test serialization and deserialization.
  String echoString(String aString);
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
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterIntegrationCoreApi.echoString', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FlutterIntegrationCoreApi.echoString was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_aString = (args[0] as String?);
          assert(arg_aString != null,
              'Argument for dev.flutter.pigeon.FlutterIntegrationCoreApi.echoString was null, expected non-null String.');
          final String output = api.echoString(arg_aString!);
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
}
