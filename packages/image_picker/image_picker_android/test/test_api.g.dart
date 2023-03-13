// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v9.0.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:image_picker_android/src/messages.g.dart';

class _TestHostImagePickerApiCodec extends StandardMessageCodec {
  const _TestHostImagePickerApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is CacheRetrievalError) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is CacheRetrievalResult) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is ImageSelectionOptions) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is SourceSpecification) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is VideoSelectionOptions) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return CacheRetrievalError.decode(readValue(buffer)!);
      case 129: 
        return CacheRetrievalResult.decode(readValue(buffer)!);
      case 130: 
        return ImageSelectionOptions.decode(readValue(buffer)!);
      case 131: 
        return SourceSpecification.decode(readValue(buffer)!);
      case 132: 
        return VideoSelectionOptions.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestHostImagePickerApi {
  static const MessageCodec<Object?> codec = _TestHostImagePickerApiCodec();

  /// Selects images and returns their paths.
  ///
  /// Elements must not be null, by convention. See
  /// https://github.com/flutter/flutter/issues/97848
  Future<List<String?>> pickImages(SourceSpecification source, ImageSelectionOptions options, bool allowMultiple, bool useAndroidPhotoPicker);

  /// Selects video and returns their paths.
  ///
  /// Elements must not be null, by convention. See
  /// https://github.com/flutter/flutter/issues/97848
  Future<List<String?>> pickVideos(SourceSpecification source, VideoSelectionOptions options, bool allowMultiple, bool useAndroidPhotoPicker);

  /// Returns results from a previous app session, if any.
  CacheRetrievalResult? retrieveLostResults();

  static void setup(TestHostImagePickerApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ImagePickerApi.pickImages', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.ImagePickerApi.pickImages was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final SourceSpecification? arg_source = (args[0] as SourceSpecification?);
          assert(arg_source != null,
              'Argument for dev.flutter.pigeon.ImagePickerApi.pickImages was null, expected non-null SourceSpecification.');
          final ImageSelectionOptions? arg_options = (args[1] as ImageSelectionOptions?);
          assert(arg_options != null,
              'Argument for dev.flutter.pigeon.ImagePickerApi.pickImages was null, expected non-null ImageSelectionOptions.');
          final bool? arg_allowMultiple = (args[2] as bool?);
          assert(arg_allowMultiple != null,
              'Argument for dev.flutter.pigeon.ImagePickerApi.pickImages was null, expected non-null bool.');
          final bool? arg_useAndroidPhotoPicker = (args[3] as bool?);
          assert(arg_useAndroidPhotoPicker != null,
              'Argument for dev.flutter.pigeon.ImagePickerApi.pickImages was null, expected non-null bool.');
          final List<String?> output = await api.pickImages(arg_source!, arg_options!, arg_allowMultiple!, arg_useAndroidPhotoPicker!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ImagePickerApi.pickVideos', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.ImagePickerApi.pickVideos was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final SourceSpecification? arg_source = (args[0] as SourceSpecification?);
          assert(arg_source != null,
              'Argument for dev.flutter.pigeon.ImagePickerApi.pickVideos was null, expected non-null SourceSpecification.');
          final VideoSelectionOptions? arg_options = (args[1] as VideoSelectionOptions?);
          assert(arg_options != null,
              'Argument for dev.flutter.pigeon.ImagePickerApi.pickVideos was null, expected non-null VideoSelectionOptions.');
          final bool? arg_allowMultiple = (args[2] as bool?);
          assert(arg_allowMultiple != null,
              'Argument for dev.flutter.pigeon.ImagePickerApi.pickVideos was null, expected non-null bool.');
          final bool? arg_useAndroidPhotoPicker = (args[3] as bool?);
          assert(arg_useAndroidPhotoPicker != null,
              'Argument for dev.flutter.pigeon.ImagePickerApi.pickVideos was null, expected non-null bool.');
          final List<String?> output = await api.pickVideos(arg_source!, arg_options!, arg_allowMultiple!, arg_useAndroidPhotoPicker!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ImagePickerApi.retrieveLostResults', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          // ignore message
          final CacheRetrievalResult? output = api.retrieveLostResults();
          return <Object?>[output];
        });
      }
    }
  }
}
