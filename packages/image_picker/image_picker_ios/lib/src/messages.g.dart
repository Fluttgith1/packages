// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v13.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

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
  });

  MaxSize maxSize;

  int? imageQuality;

  bool requestFullMetadata;

  bool allowMultiple;

  Object encode() {
    return <Object?>[
      maxSize.encode(),
      imageQuality,
      requestFullMetadata,
      allowMultiple,
    ];
  }

  static MediaSelectionOptions decode(Object result) {
    result as List<Object?>;
    return MediaSelectionOptions(
      maxSize: MaxSize.decode(result[0]! as List<Object?>),
      imageQuality: result[1] as int?,
      requestFullMetadata: result[2]! as bool,
      allowMultiple: result[3]! as bool,
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
      type.index,
      camera.index,
    ];
  }

  static SourceSpecification decode(Object result) {
    result as List<Object?>;
    return SourceSpecification(
      type: SourceType.values[result[0]! as int],
      camera: SourceCamera.values[result[1]! as int],
    );
  }
}

class _ImagePickerApiCodec extends StandardMessageCodec {
  const _ImagePickerApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is MaxSize) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is MediaSelectionOptions) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is SourceSpecification) {
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
        return MaxSize.decode(readValue(buffer)!);
      case 129:
        return MediaSelectionOptions.decode(readValue(buffer)!);
      case 130:
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
  ImagePickerApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _ImagePickerApiCodec();

  Future<String?> pickImage(SourceSpecification arg_source, MaxSize arg_maxSize,
      int? arg_imageQuality, bool arg_requestFullMetadata) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.image_picker_ios.ImagePickerApi.pickImage', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(<Object?>[
      arg_source,
      arg_maxSize,
      arg_imageQuality,
      arg_requestFullMetadata
    ]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return (replyList[0] as String?);
    }
  }

  Future<List<String?>> pickMultiImage(MaxSize arg_maxSize,
      int? arg_imageQuality, bool arg_requestFullMetadata) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.image_picker_ios.ImagePickerApi.pickMultiImage',
        codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(
            <Object?>[arg_maxSize, arg_imageQuality, arg_requestFullMetadata])
        as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
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
      return (replyList[0] as List<Object?>?)!.cast<String?>();
    }
  }

  Future<String?> pickVideo(
      SourceSpecification arg_source, int? arg_maxDurationSeconds) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.image_picker_ios.ImagePickerApi.pickVideo', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel
        .send(<Object?>[arg_source, arg_maxDurationSeconds]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return (replyList[0] as String?);
    }
  }

  /// Selects images and videos and returns their paths.
  Future<List<String?>> pickMedia(
      MediaSelectionOptions arg_mediaSelectionOptions) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.image_picker_ios.ImagePickerApi.pickMedia', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel
        .send(<Object?>[arg_mediaSelectionOptions]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
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
      return (replyList[0] as List<Object?>?)!.cast<String?>();
    }
  }
}
