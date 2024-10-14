// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  javaOptions: JavaOptions(package: 'io.flutter.plugins.camera'),
  javaOut: 'android/src/main/java/io/flutter/plugins/camera/Messages.java',
  copyrightHeader: 'pigeons/copyright.txt',
))

/// Pigeon equivalent of [CameraLensDirection].
enum PlatformCameraLensDirection {
  front,
  back,
  external,
}

/// Pigeon equivalent of [CameraDescription].
class PlatformCameraDescription {
  PlatformCameraDescription(
      {required this.name,
      required this.lensDirection,
      required this.sensorOrientation});

  final String name;
  final PlatformCameraLensDirection lensDirection;
  final int sensorOrientation;
}

/// Pigeon equivalent of [DeviceOrientation].
enum PlatformDeviceOrientation {
  portraitUp,
  portraitDown,
  landscapeLeft,
  landscapeRight,
}

/// Pigeon equivalent of [ExposureMode].
enum PlatformExposureMode {
  auto,
  locked,
}

/// Pigeon equivalent of [FocusMode].
enum PlatformFocusMode {
  auto,
  locked,
}

/// Data needed for [CameraInitializedEvent].
class PlatformCameraState {
  PlatformCameraState(
      {required this.previewSize,
      required this.exposureMode,
      required this.focusMode,
      required this.exposurePointSupported,
      required this.focusPointSupported});

  final PlatformSize previewSize;
  final PlatformExposureMode exposureMode;
  final PlatformFocusMode focusMode;
  final bool exposurePointSupported;
  final bool focusPointSupported;
}

/// Pigeon equivalent of [Size].
class PlatformSize {
  PlatformSize({required this.width, required this.height});

  final double width;
  final double height;
}

/// Pigeon equivalent of [Point].
class PlatformPoint {
  PlatformPoint({required this.x, required this.y});

  final double x;
  final double y;
}

/// Pigeon equivalent of [ResolutionPreset].
enum PlatformResolutionPreset {
  low,
  medium,
  high,
  veryHigh,
  ultraHigh,
  max,
}

/// Pigeon equivalent of [MediaSettings].
class PlatformMediaSettings {
  PlatformMediaSettings(
      {required this.resolutionPreset,
      required this.enableAudio,
      this.fps,
      this.videoBitrate,
      this.audioBitrate});
  final PlatformResolutionPreset resolutionPreset;
  final int? fps;
  final int? videoBitrate;
  final int? audioBitrate;
  final bool enableAudio;
}

/// Pigeon equivalent of [ImageFormatGroup].
enum PlatformImageFormatGroup {
  /// The default for Android.
  yuv420,
  jpeg,
  nv21,
}

/// Pigeon equivalent of [FlashMode].
enum PlatformFlashMode {
  off,
  auto,
  always,
  torch,
}

/// Handles calls from Dart to the native side.
@HostApi()
abstract class CameraApi {
  /// Returns the list of available cameras.
  List<PlatformCameraDescription> getAvailableCameras();

  /// Creates a new camera with the given name and settings and returns its ID.
  @async
  int create(String cameraName, PlatformMediaSettings mediaSettings);

  /// Initializes the camera with the given ID for the given image format.
  @async
  void initialize(int cameraId, PlatformImageFormatGroup imageFormat);

  /// Disposes of the camera with the given ID.
  @async
  void dispose(int cameraId);

  /// Locks the camera with the given ID to the given orientation.
  @async
  void lockCaptureOrientation(
      int cameraId, PlatformDeviceOrientation orientation);

  /// Unlocks the orientation for the camera with the given ID.
  @async
  void unlockCaptureOrientation(int cameraId);

  /// Takes a picture on the camera with the given ID and returns a path to the
  /// resulting file.
  @async
  String takePicture(int cameraId);

  /// Handles any necessary preprocessing before beginning video recording.
  @async
  void prepareForVideoRecording();

  /// Starts recording a video on the camera with the given ID.
  @async
  void startVideoRecording(int cameraId, bool enableStream);

  /// Ends video recording on the camera with the given ID and returns the path
  /// to the resulting file.
  @async
  String stopVideoRecording(int cameraId);

  /// Pauses video recording on the camera with the given ID.
  @async
  void pauseVideoRecording(int cameraId);

  /// Resumes previously paused video recording on the camera with the given ID.
  @async
  void resumeVideoRecording(int cameraId);

  /// Begins streaming frames from the camera.
  @async
  void startImageStream();

  /// Stops streaming frames from the camera.
  @async
  void stopImageStream();

  /// Sets the flash mode of the camera with the given ID.
  @async
  void setFlashMode(int cameraId, PlatformFlashMode flashMode);

  /// Sets the exposure mode of the camera with the given ID.
  @async
  void setExposureMode(int cameraId, PlatformExposureMode exposureMode);

  /// Sets the exposure point of the camera with the given ID.
  ///
  /// A null value resets to the default exposure point.
  @async
  void setExposurePoint(int cameraId, PlatformPoint? point);

  /// Returns the minimum exposure offset of the camera with the given ID.
  @async
  double getMinExposureOffset(int cameraId);

  /// Returns the maximum exposure offset of the camera with the given ID.
  @async
  double getMaxExposureOffset(int cameraId);

  /// Returns the exposure step size of the camera with the given ID.
  @async
  double getExposureOffsetStepSize(int cameraId);

  /// Sets the exposure offset of the camera with the given ID and returns the
  /// actual exposure offset.
  @async
  double setExposureOffset(int cameraId, double offset);

  /// Sets the focus mode of the camera with the given ID.
  @async
  void setFocusMode(int cameraId, PlatformFocusMode focusMode);

  /// Sets the focus point of the camera with the given ID.
  ///
  /// A null value resets to the default focus point.
  @async
  void setFocusPoint(int cameraId, PlatformPoint? point);

  /// Returns the maximum zoom level of the camera with the given ID.
  @async
  double getMaxZoomLevel(int cameraId);

  /// Returns the minimum zoom level of the camera with the given ID.
  @async
  double getMinZoomLevel(int cameraId);

  /// Sets the zoom level of the camera with the given ID.
  @async
  void setZoomLevel(int cameraId, double zoom);

  /// Pauses streaming of preview frames.
  @async
  void pausePreview(int cameraId);

  /// Resumes previously paused streaming of preview frames.
  @async
  void resumePreview(int cameraId);

  /// Changes the camera while recording video.
  ///
  /// This should be called only while video recording is active.
  @async
  void setDescriptionWhileRecording(String description);
}

/// Handles calls from native side to Dart that are not camera-specific.
@FlutterApi()
abstract class CameraGlobalEventApi {
  /// Called when the device's physical orientation changes.
  void deviceOrientationChanged(PlatformDeviceOrientation orientation);
}

/// Handles device-specific calls from native side to Dart.
@FlutterApi()
abstract class CameraEventApi {
  /// Called when the camera is initialized.
  void initialized(PlatformCameraState initialState);

  /// Called when an error occurs in the camera.
  void error(String message);

  /// Called when the camera closes.
  void closed();
}
