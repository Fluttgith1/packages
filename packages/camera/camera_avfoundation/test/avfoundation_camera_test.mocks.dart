// Mocks generated by Mockito 5.4.4 from annotations
// in camera_avfoundation/test/avfoundation_camera_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:camera_avfoundation/src/messages.g.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [CameraApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockCameraApi extends _i1.Mock implements _i2.CameraApi {
  @override
  _i3.Future<List<_i2.PlatformCameraDescription?>> getAvailableCameras() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAvailableCameras,
          [],
        ),
        returnValue: _i3.Future<List<_i2.PlatformCameraDescription?>>.value(
            <_i2.PlatformCameraDescription?>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i2.PlatformCameraDescription?>>.value(
                <_i2.PlatformCameraDescription?>[]),
      ) as _i3.Future<List<_i2.PlatformCameraDescription?>>);

  @override
  _i3.Future<int> create(
    String? cameraName,
    _i2.PlatformMediaSettings? settings,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #create,
          [
            cameraName,
            settings,
          ],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<void> initialize(
    int? cameraId,
    _i2.PlatformImageFormatGroup? imageFormat,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #initialize,
          [
            cameraId,
            imageFormat,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> startImageStream() => (super.noSuchMethod(
        Invocation.method(
          #startImageStream,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> stopImageStream() => (super.noSuchMethod(
        Invocation.method(
          #stopImageStream,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> receivedImageStreamData() => (super.noSuchMethod(
        Invocation.method(
          #receivedImageStreamData,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> dispose(int? cameraId) => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [cameraId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> lockCaptureOrientation(
          _i2.PlatformDeviceOrientation? orientation) =>
      (super.noSuchMethod(
        Invocation.method(
          #lockCaptureOrientation,
          [orientation],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> unlockCaptureOrientation() => (super.noSuchMethod(
        Invocation.method(
          #unlockCaptureOrientation,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<String> takePicture() => (super.noSuchMethod(
        Invocation.method(
          #takePicture,
          [],
        ),
        returnValue: _i3.Future<String>.value(_i4.dummyValue<String>(
          this,
          Invocation.method(
            #takePicture,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<String>.value(_i4.dummyValue<String>(
          this,
          Invocation.method(
            #takePicture,
            [],
          ),
        )),
      ) as _i3.Future<String>);

  @override
  _i3.Future<void> prepareForVideoRecording() => (super.noSuchMethod(
        Invocation.method(
          #prepareForVideoRecording,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> startVideoRecording(bool? enableStream) =>
      (super.noSuchMethod(
        Invocation.method(
          #startVideoRecording,
          [enableStream],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<String> stopVideoRecording() => (super.noSuchMethod(
        Invocation.method(
          #stopVideoRecording,
          [],
        ),
        returnValue: _i3.Future<String>.value(_i4.dummyValue<String>(
          this,
          Invocation.method(
            #stopVideoRecording,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<String>.value(_i4.dummyValue<String>(
          this,
          Invocation.method(
            #stopVideoRecording,
            [],
          ),
        )),
      ) as _i3.Future<String>);

  @override
  _i3.Future<void> pauseVideoRecording() => (super.noSuchMethod(
        Invocation.method(
          #pauseVideoRecording,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> resumeVideoRecording() => (super.noSuchMethod(
        Invocation.method(
          #resumeVideoRecording,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setFlashMode(_i2.PlatformFlashMode? mode) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFlashMode,
          [mode],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setExposureMode(_i2.PlatformExposureMode? mode) =>
      (super.noSuchMethod(
        Invocation.method(
          #setExposureMode,
          [mode],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setExposurePoint(_i2.PlatformPoint? point) =>
      (super.noSuchMethod(
        Invocation.method(
          #setExposurePoint,
          [point],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<double> getMinExposureOffset() => (super.noSuchMethod(
        Invocation.method(
          #getMinExposureOffset,
          [],
        ),
        returnValue: _i3.Future<double>.value(0.0),
        returnValueForMissingStub: _i3.Future<double>.value(0.0),
      ) as _i3.Future<double>);

  @override
  _i3.Future<double> getMaxExposureOffset() => (super.noSuchMethod(
        Invocation.method(
          #getMaxExposureOffset,
          [],
        ),
        returnValue: _i3.Future<double>.value(0.0),
        returnValueForMissingStub: _i3.Future<double>.value(0.0),
      ) as _i3.Future<double>);

  @override
  _i3.Future<void> setExposureOffset(double? offset) => (super.noSuchMethod(
        Invocation.method(
          #setExposureOffset,
          [offset],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setFocusMode(_i2.PlatformFocusMode? mode) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFocusMode,
          [mode],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setFocusPoint(_i2.PlatformPoint? point) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFocusPoint,
          [point],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<double> getMinZoomLevel() => (super.noSuchMethod(
        Invocation.method(
          #getMinZoomLevel,
          [],
        ),
        returnValue: _i3.Future<double>.value(0.0),
        returnValueForMissingStub: _i3.Future<double>.value(0.0),
      ) as _i3.Future<double>);

  @override
  _i3.Future<double> getMaxZoomLevel() => (super.noSuchMethod(
        Invocation.method(
          #getMaxZoomLevel,
          [],
        ),
        returnValue: _i3.Future<double>.value(0.0),
        returnValueForMissingStub: _i3.Future<double>.value(0.0),
      ) as _i3.Future<double>);

  @override
  _i3.Future<void> setZoomLevel(double? zoom) => (super.noSuchMethod(
        Invocation.method(
          #setZoomLevel,
          [zoom],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setVideoStabilizationMode(
          _i2.PlatformVideoStabilizationMode? mode) =>
      (super.noSuchMethod(
        Invocation.method(
          #setVideoStabilizationMode,
          [mode],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<bool> isVideoStabilizationModeSupported(
          _i2.PlatformVideoStabilizationMode? mode) =>
      (super.noSuchMethod(
        Invocation.method(
          #isVideoStabilizationModeSupported,
          [mode],
        ),
        returnValue: _i3.Future<bool>.value(false),
        returnValueForMissingStub: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<void> pausePreview() => (super.noSuchMethod(
        Invocation.method(
          #pausePreview,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> resumePreview() => (super.noSuchMethod(
        Invocation.method(
          #resumePreview,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> updateDescriptionWhileRecording(String? cameraName) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateDescriptionWhileRecording,
          [cameraName],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setImageFileFormat(_i2.PlatformImageFileFormat? format) =>
      (super.noSuchMethod(
        Invocation.method(
          #setImageFileFormat,
          [format],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
