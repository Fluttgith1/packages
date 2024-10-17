// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.4.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

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

List<Object?> wrapResponse(
    {Object? result, PlatformException? error, bool empty = false}) {
  if (empty) {
    return <Object?>[];
  }
  if (error == null) {
    return <Object?>[result];
  }
  return <Object?>[error.code, error.message, error.details];
}

enum SourceCamera {
  rear,
  front,
}

enum SourceType {
  camera,
  gallery,
}

class MaxSize {
  MaxSize({
    this.width,
    this.height,
  });

  double? width;

  double? height;

  Object encode() {
    return <Object?>[
      width,
      height,
    ];
  }

  static MaxSize decode(Object result) {
    result as List<Object?>;
    return MaxSize(
      width: result[0] as double?,
      height: result[1] as double?,
    );
  }
}

class MediaSelectionOptions {
  MediaSelectionOptions({
    required this.maxSize,
    this.imageQuality,
    required this.requestFullMetadata,
    required this.allowMultiple,
    this.limit,
  });

  MaxSize maxSize;

  int? imageQuality;

  bool requestFullMetadata;

  bool allowMultiple;

  int? limit;

  Object encode() {
    return <Object?>[
      maxSize,
      imageQuality,
      requestFullMetadata,
      allowMultiple,
      limit,
    ];
  }

  static MediaSelectionOptions decode(Object result) {
    result as List<Object?>;
    return MediaSelectionOptions(
      maxSize: result[0]! as MaxSize,
      imageQuality: result[1] as int?,
      requestFullMetadata: result[2]! as bool,
      allowMultiple: result[3]! as bool,
      limit: result[4] as int?,
    );
  }
}

class SourceSpecification {
  SourceSpecification({
    required this.type,
    required this.camera,
  });

  SourceType type;

  SourceCamera camera;

  Object encode() {
    return <Object?>[
      type,
      camera,
    ];
  }

  static SourceSpecification decode(Object result) {
    result as List<Object?>;
    return SourceSpecification(
      type: result[0]! as SourceType,
      camera: result[1]! as SourceCamera,
    );
  }
}

class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    } else if (value is SourceCamera) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    } else if (value is SourceType) {
      buffer.putUint8(130);
      writeValue(buffer, value.index);
    } else if (value is MaxSize) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is MediaSelectionOptions) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is SourceSpecification) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : SourceCamera.values[value];
      case 130:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : SourceType.values[value];
      case 131:
        return MaxSize.decode(readValue(buffer)!);
      case 132:
        return MediaSelectionOptions.decode(readValue(buffer)!);
      case 133:
        return SourceSpecification.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class ImagePickerApi {
  /// Constructor for [ImagePickerApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  ImagePickerApi(
      {BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix =
            messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  Future<String?> pickImage(SourceSpecification source, MaxSize maxSize,
      int? imageQuality, bool requestFullMetadata) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.image_picker_ios.ImagePickerApi.pickImage$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[source, maxSize, imageQuality, requestFullMetadata])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return (pigeonVar_replyList[0] as String?);
    }
  }

  Future<List<String>> pickMultiImage(MaxSize maxSize, int? imageQuality,
      bool requestFullMetadata, int? limit) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.image_picker_ios.ImagePickerApi.pickMultiImage$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
            .send(<Object?>[maxSize, imageQuality, requestFullMetadata, limit])
        as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as List<Object?>?)!.cast<String>();
    }
  }

  Future<String?> pickVideo(
      SourceSpecification source, int? maxDurationSeconds) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.image_picker_ios.ImagePickerApi.pickVideo$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
        .send(<Object?>[source, maxDurationSeconds]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return (pigeonVar_replyList[0] as String?);
    }
  }

  /// Selects images and videos and returns their paths.
  Future<List<String>> pickMedia(
      MediaSelectionOptions mediaSelectionOptions) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.image_picker_ios.ImagePickerApi.pickMedia$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel =
        BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList = await pigeonVar_channel
        .send(<Object?>[mediaSelectionOptions]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as List<Object?>?)!.cast<String>();
    }
  }
}
