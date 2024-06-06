// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_implementing_value_types

import 'dart:async';
import 'dart:js_interop';
import 'dart:ui';

// ignore_for_file: implementation_imports
import 'package:camera_web/src/camera.dart';
import 'package:camera_web/src/camera_service.dart';
import 'package:camera_web/src/shims/dart_js_util.dart';
import 'package:camera_web/src/types/types.dart';
import 'package:cross_file/cross_file.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web/web.dart' as web;

@JSExport()
class MockWindow {
  late web.Navigator navigator;
}

// @JSExport()
class MockScreen {}

// @JSExport()
class MockScreenOrientation {}

// @JSExport()
class MockDocument {}

// @JSExport()
class MockElement {}

@JSExport()
class MockNavigator {
  late web.MediaDevices mediaDevices;
}

@JSExport()
class MockMediaDevices {
  late JSPromise<web.MediaStream> Function([
    web.MediaStreamConstraints? constraints,
  ]) getUserMedia;

  late web.MediaTrackSupportedConstraints Function() getSupportedConstraints;
}

class MockCameraService extends Mock implements CameraService {}

@JSExport()
class MockMediaStreamTrack {
  late web.MediaTrackCapabilities Function() getCapabilities;
  late web.MediaTrackSettings Function() getSettings;
}

class MockCamera extends Mock implements Camera {}

class MockCameraOptions extends Mock implements CameraOptions {}

// @JSExport()
class MockVideoElement {}

class MockXFile extends Mock implements XFile {}

class MockJsUtil extends Mock implements JsUtil {}

// @JSExport()
class MockMediaRecorder {}

/// A fake [MediaStream] that returns the provided [_videoTracks].
@JSExport()
class FakeMediaStream {
  FakeMediaStream(this._videoTracks);

  final List<web.MediaStreamTrack> _videoTracks;

  List<web.MediaStreamTrack> getVideoTracks() => _videoTracks;
}

/// A fake [MediaDeviceInfo] that returns the provided [_deviceId], [_label] and [_kind].
@JSExport()
class FakeMediaDeviceInfo {
  FakeMediaDeviceInfo(this.deviceId, this.label, this.kind);

  final String deviceId;
  final String label;
  final String kind;
}

/// A fake [MediaError] that returns the provided error [_code] and [_message].
@JSExport()
class FakeMediaError {
  FakeMediaError(
    this.code, [
    this.message = '',
  ]);

  final int code;
  final String message;
}

/// A fake [ElementStream] that listens to the provided [_stream] on [listen].
class FakeElementStream<T extends web.Event> extends Fake
    implements web.ElementStream<T> {
  FakeElementStream(this._stream);

  final Stream<T> _stream;

  @override
  StreamSubscription<T> listen(void Function(T event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

/// A fake [BlobEvent] that returns the provided blob [data].
@JSExport()
class FakeBlobEvent {
  FakeBlobEvent(this.data);

  final web.Blob? data;
}

/// A fake [DomException] that returns the provided error [_name] and [_message].
@JSExport()
class FakeErrorEvent {
  FakeErrorEvent(
    this.type, [
    this.message = '',
  ]);

  final String type;
  final String message;
}

/// Returns a video element with a blank stream of size [videoSize].
///
/// Can be used to mock a video stream:
/// ```dart
/// final videoElement = getVideoElementWithBlankStream(Size(100, 100));
/// final videoStream = videoElement.captureStream();
/// ```
web.HTMLVideoElement getVideoElementWithBlankStream(Size videoSize) {
  final web.HTMLCanvasElement canvasElement = web.HTMLCanvasElement()
    ..width = videoSize.width.toInt()
    ..height = videoSize.height.toInt()
    ..context2D.fillRect(0, 0, videoSize.width, videoSize.height);

  final web.HTMLVideoElement videoElement = web.HTMLVideoElement()
    ..srcObject = canvasElement.captureStream();

  return videoElement;
}
