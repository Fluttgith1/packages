// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v9.1.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:camera_android_camerax/src/camerax_library.g.dart';

abstract class TestInstanceManagerHostApi {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  /// Clear the native `InstanceManager`.
  ///
  /// This is typically only used after a hot restart.
  void clear();

  static void setup(TestInstanceManagerHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.InstanceManagerHostApi.clear', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          // ignore message
          api.clear();
          return <Object?>[];
        });
      }
    }
  }
}

abstract class TestJavaObjectHostApi {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  void dispose(int identifier);

  static void setup(TestJavaObjectHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.JavaObjectHostApi.dispose', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.JavaObjectHostApi.dispose was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.JavaObjectHostApi.dispose was null, expected non-null int.');
          api.dispose(arg_identifier!);
          return <Object?>[];
        });
      }
    }
  }
}

abstract class TestCameraInfoHostApi {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  int getSensorRotationDegrees(int identifier);

  int getLiveCameraState(int identifier);

  static void setup(TestCameraInfoHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.CameraInfoHostApi.getSensorRotationDegrees',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.CameraInfoHostApi.getSensorRotationDegrees was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.CameraInfoHostApi.getSensorRotationDegrees was null, expected non-null int.');
          final int output = api.getSensorRotationDegrees(arg_identifier!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.CameraInfoHostApi.getLiveCameraState', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.CameraInfoHostApi.getLiveCameraState was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.CameraInfoHostApi.getLiveCameraState was null, expected non-null int.');
          final int output = api.getLiveCameraState(arg_identifier!);
          return <Object?>[output];
        });
      }
    }
  }
}

abstract class TestCameraSelectorHostApi {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  void create(int identifier, int? lensFacing);

  List<int?> filter(int identifier, List<int?> cameraInfoIds);

  static void setup(TestCameraSelectorHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.CameraSelectorHostApi.create', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.CameraSelectorHostApi.create was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.CameraSelectorHostApi.create was null, expected non-null int.');
          final int? arg_lensFacing = (args[1] as int?);
          api.create(arg_identifier!, arg_lensFacing);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.CameraSelectorHostApi.filter', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.CameraSelectorHostApi.filter was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.CameraSelectorHostApi.filter was null, expected non-null int.');
          final List<int?>? arg_cameraInfoIds =
              (args[1] as List<Object?>?)?.cast<int?>();
          assert(arg_cameraInfoIds != null,
              'Argument for dev.flutter.pigeon.CameraSelectorHostApi.filter was null, expected non-null List<int?>.');
          final List<int?> output =
              api.filter(arg_identifier!, arg_cameraInfoIds!);
          return <Object?>[output];
        });
      }
    }
  }
}

abstract class TestProcessCameraProviderHostApi {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  Future<int> getInstance();

  List<int?> getAvailableCameraInfos(int identifier);

  int bindToLifecycle(
      int identifier, int cameraSelectorIdentifier, List<int?> useCaseIds);

  bool isBound(int identifier, int useCaseIdentifier);

  void unbind(int identifier, List<int?> useCaseIds);

  void unbindAll(int identifier);

  static void setup(TestProcessCameraProviderHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ProcessCameraProviderHostApi.getInstance', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          // ignore message
          final int output = await api.getInstance();
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ProcessCameraProviderHostApi.getAvailableCameraInfos',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.getAvailableCameraInfos was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.getAvailableCameraInfos was null, expected non-null int.');
          final List<int?> output =
              api.getAvailableCameraInfos(arg_identifier!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ProcessCameraProviderHostApi.bindToLifecycle',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.bindToLifecycle was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.bindToLifecycle was null, expected non-null int.');
          final int? arg_cameraSelectorIdentifier = (args[1] as int?);
          assert(arg_cameraSelectorIdentifier != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.bindToLifecycle was null, expected non-null int.');
          final List<int?>? arg_useCaseIds =
              (args[2] as List<Object?>?)?.cast<int?>();
          assert(arg_useCaseIds != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.bindToLifecycle was null, expected non-null List<int?>.');
          final int output = api.bindToLifecycle(
              arg_identifier!, arg_cameraSelectorIdentifier!, arg_useCaseIds!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ProcessCameraProviderHostApi.isBound', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.isBound was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.isBound was null, expected non-null int.');
          final int? arg_useCaseIdentifier = (args[1] as int?);
          assert(arg_useCaseIdentifier != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.isBound was null, expected non-null int.');
          final bool output =
              api.isBound(arg_identifier!, arg_useCaseIdentifier!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ProcessCameraProviderHostApi.unbind', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.unbind was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.unbind was null, expected non-null int.');
          final List<int?>? arg_useCaseIds =
              (args[1] as List<Object?>?)?.cast<int?>();
          assert(arg_useCaseIds != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.unbind was null, expected non-null List<int?>.');
          api.unbind(arg_identifier!, arg_useCaseIds!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ProcessCameraProviderHostApi.unbindAll', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.unbindAll was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.ProcessCameraProviderHostApi.unbindAll was null, expected non-null int.');
          api.unbindAll(arg_identifier!);
          return <Object?>[];
        });
      }
    }
  }
}

abstract class TestCameraHostApi {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  int getCameraInfo(int identifier);

  static void setup(TestCameraHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.CameraHostApi.getCameraInfo', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.CameraHostApi.getCameraInfo was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.CameraHostApi.getCameraInfo was null, expected non-null int.');
          final int output = api.getCameraInfo(arg_identifier!);
          return <Object?>[output];
        });
      }
    }
  }
}

class _TestSystemServicesHostApiCodec extends StandardMessageCodec {
  const _TestSystemServicesHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is CameraPermissionsErrorData) {
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
        return CameraPermissionsErrorData.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestSystemServicesHostApi {
  static const MessageCodec<Object?> codec = _TestSystemServicesHostApiCodec();

  Future<CameraPermissionsErrorData?> requestCameraPermissions(
      bool enableAudio);

  void startListeningForDeviceOrientationChange(
      bool isFrontFacing, int sensorOrientation);

  void stopListeningForDeviceOrientationChange();

  static void setup(TestSystemServicesHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.SystemServicesHostApi.requestCameraPermissions',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.SystemServicesHostApi.requestCameraPermissions was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final bool? arg_enableAudio = (args[0] as bool?);
          assert(arg_enableAudio != null,
              'Argument for dev.flutter.pigeon.SystemServicesHostApi.requestCameraPermissions was null, expected non-null bool.');
          final CameraPermissionsErrorData? output =
              await api.requestCameraPermissions(arg_enableAudio!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.SystemServicesHostApi.startListeningForDeviceOrientationChange',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.SystemServicesHostApi.startListeningForDeviceOrientationChange was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final bool? arg_isFrontFacing = (args[0] as bool?);
          assert(arg_isFrontFacing != null,
              'Argument for dev.flutter.pigeon.SystemServicesHostApi.startListeningForDeviceOrientationChange was null, expected non-null bool.');
          final int? arg_sensorOrientation = (args[1] as int?);
          assert(arg_sensorOrientation != null,
              'Argument for dev.flutter.pigeon.SystemServicesHostApi.startListeningForDeviceOrientationChange was null, expected non-null int.');
          api.startListeningForDeviceOrientationChange(
              arg_isFrontFacing!, arg_sensorOrientation!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.SystemServicesHostApi.stopListeningForDeviceOrientationChange',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          // ignore message
          api.stopListeningForDeviceOrientationChange();
          return <Object?>[];
        });
      }
    }
  }
}

class _TestPreviewHostApiCodec extends StandardMessageCodec {
  const _TestPreviewHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is ResolutionInfo) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is ResolutionInfo) {
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
        return ResolutionInfo.decode(readValue(buffer)!);
      case 129:
        return ResolutionInfo.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestPreviewHostApi {
  static const MessageCodec<Object?> codec = _TestPreviewHostApiCodec();

  void create(int identifier, int? rotation, ResolutionInfo? targetResolution);

  int setSurfaceProvider(int identifier);

  void releaseFlutterSurfaceTexture();

  ResolutionInfo getResolutionInfo(int identifier);

  static void setup(TestPreviewHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PreviewHostApi.create', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.PreviewHostApi.create was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.PreviewHostApi.create was null, expected non-null int.');
          final int? arg_rotation = (args[1] as int?);
          final ResolutionInfo? arg_targetResolution =
              (args[2] as ResolutionInfo?);
          api.create(arg_identifier!, arg_rotation, arg_targetResolution);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PreviewHostApi.setSurfaceProvider', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.PreviewHostApi.setSurfaceProvider was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.PreviewHostApi.setSurfaceProvider was null, expected non-null int.');
          final int output = api.setSurfaceProvider(arg_identifier!);
          return <Object?>[output];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PreviewHostApi.releaseFlutterSurfaceTexture',
          codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          // ignore message
          api.releaseFlutterSurfaceTexture();
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PreviewHostApi.getResolutionInfo', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.PreviewHostApi.getResolutionInfo was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.PreviewHostApi.getResolutionInfo was null, expected non-null int.');
          final ResolutionInfo output = api.getResolutionInfo(arg_identifier!);
          return <Object?>[output];
        });
      }
    }
  }
}

class _TestImageCaptureHostApiCodec extends StandardMessageCodec {
  const _TestImageCaptureHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is ResolutionInfo) {
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
        return ResolutionInfo.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestImageCaptureHostApi {
  static const MessageCodec<Object?> codec = _TestImageCaptureHostApiCodec();

  void create(int identifier, int? flashMode, ResolutionInfo? targetResolution);

  void setFlashMode(int identifier, int flashMode);

  Future<String> takePicture(int identifier);

  static void setup(TestImageCaptureHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ImageCaptureHostApi.create', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ImageCaptureHostApi.create was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.ImageCaptureHostApi.create was null, expected non-null int.');
          final int? arg_flashMode = (args[1] as int?);
          final ResolutionInfo? arg_targetResolution =
              (args[2] as ResolutionInfo?);
          api.create(arg_identifier!, arg_flashMode, arg_targetResolution);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ImageCaptureHostApi.setFlashMode', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ImageCaptureHostApi.setFlashMode was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.ImageCaptureHostApi.setFlashMode was null, expected non-null int.');
          final int? arg_flashMode = (args[1] as int?);
          assert(arg_flashMode != null,
              'Argument for dev.flutter.pigeon.ImageCaptureHostApi.setFlashMode was null, expected non-null int.');
          api.setFlashMode(arg_identifier!, arg_flashMode!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.ImageCaptureHostApi.takePicture', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.ImageCaptureHostApi.takePicture was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.ImageCaptureHostApi.takePicture was null, expected non-null int.');
          final String output = await api.takePicture(arg_identifier!);
          return <Object?>[output];
        });
      }
    }
  }
}

abstract class TestLiveCameraStateHostApi {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  void addObserver(int identifier);

  void removeObservers(int identifier);

  static void setup(TestLiveCameraStateHostApi? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.LiveCameraStateHostApi.addObserver', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.LiveCameraStateHostApi.addObserver was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.LiveCameraStateHostApi.addObserver was null, expected non-null int.');
          api.addObserver(arg_identifier!);
          return <Object?>[];
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.LiveCameraStateHostApi.removeObservers', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMockMessageHandler(null);
      } else {
        channel.setMockMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.LiveCameraStateHostApi.removeObservers was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_identifier = (args[0] as int?);
          assert(arg_identifier != null,
              'Argument for dev.flutter.pigeon.LiveCameraStateHostApi.removeObservers was null, expected non-null int.');
          api.removeObservers(arg_identifier!);
          return <Object?>[];
        });
      }
    }
  }
}
