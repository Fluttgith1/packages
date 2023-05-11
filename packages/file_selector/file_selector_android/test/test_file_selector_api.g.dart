// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v9.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:file_selector_android/src/file_selector_api.g.dart';

class _TestFileSelectorApiCodec extends StandardMessageCodec {
  const _TestFileSelectorApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is FileResponse) {
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
        return FileResponse.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestFileSelectorApi {
  static TestDefaultBinaryMessengerBinding? get _testBinaryMessengerBinding => TestDefaultBinaryMessengerBinding.instance;
  static const MessageCodec<Object?> codec = _TestFileSelectorApiCodec();

  Future<FileResponse?> openFile(String? initialDirectory, List<String?>? mimeTypes);

  Future<List<FileResponse?>> openFiles(String? initialDirectory, List<String?>? mimeTypes);

  Future<String?> getDirectoryPath(String? initialDirectory);

  Future<List<String?>> getDirectoryPaths(String? initialDirectory);

  static void setup(TestFileSelectorApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FileSelectorApi.openFile', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FileSelectorApi.openFile was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_initialDirectory = (args[0] as String?);
          final List<String?>? arg_mimeTypes = (args[1] as List<Object?>?)?.cast<String?>();
          final FileResponse? output = await api.openFile(arg_initialDirectory, arg_mimeTypes);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FileSelectorApi.openFiles', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FileSelectorApi.openFiles was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_initialDirectory = (args[0] as String?);
          final List<String?>? arg_mimeTypes = (args[1] as List<Object?>?)?.cast<String?>();
          final List<FileResponse?> output = await api.openFiles(arg_initialDirectory, arg_mimeTypes);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FileSelectorApi.getDirectoryPath', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FileSelectorApi.getDirectoryPath was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_initialDirectory = (args[0] as String?);
          final String? output = await api.getDirectoryPath(arg_initialDirectory);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FileSelectorApi.getDirectoryPaths', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger.setMockDecodedMessageHandler<Object?>(channel, (Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FileSelectorApi.getDirectoryPaths was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_initialDirectory = (args[0] as String?);
          final List<String?> output = await api.getDirectoryPaths(arg_initialDirectory);
          return <Object?>[output];
        });
      }
    }
  }
}
