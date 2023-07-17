// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v10.1.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:file_selector_macos/src/messages.g.dart';

class _TestFileSelectorApiCodec extends StandardMessageCodec {
  const _TestFileSelectorApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AllowedTypes) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is OpenPanelOptions) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is SavePanelOptions) {
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
        return AllowedTypes.decode(readValue(buffer)!);
      case 129:
        return OpenPanelOptions.decode(readValue(buffer)!);
      case 130:
        return SavePanelOptions.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestFileSelectorApi {
  static TestDefaultBinaryMessengerBinding? get _testBinaryMessengerBinding =>
      TestDefaultBinaryMessengerBinding.instance;
  static const MessageCodec<Object?> codec = _TestFileSelectorApiCodec();

  /// Shows an open panel with the given [options], returning the list of
  /// selected paths.
  ///
  /// An empty list corresponds to a cancelled selection.
  Future<List<String?>> displayOpenPanel(OpenPanelOptions options);

  /// Shows a save panel with the given [options], returning the selected path.
  ///
  /// A null return corresponds to a cancelled save.
  Future<String?> displaySavePanel(SavePanelOptions options);

  static void setup(TestFileSelectorApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FileSelectorApi.displayOpenPanel', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FileSelectorApi.displayOpenPanel was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final OpenPanelOptions? arg_options = (args[0] as OpenPanelOptions?);
          assert(arg_options != null,
              'Argument for dev.flutter.pigeon.FileSelectorApi.displayOpenPanel was null, expected non-null OpenPanelOptions.');
          final List<String?> output = await api.displayOpenPanel(arg_options!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FileSelectorApi.displaySavePanel', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.FileSelectorApi.displaySavePanel was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final SavePanelOptions? arg_options = (args[0] as SavePanelOptions?);
          assert(arg_options != null,
              'Argument for dev.flutter.pigeon.FileSelectorApi.displaySavePanel was null, expected non-null SavePanelOptions.');
          final String? output = await api.displaySavePanel(arg_options!);
          return <Object?>[output];
        });
      }
    }
  }
}
