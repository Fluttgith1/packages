// Mocks generated by Mockito 5.4.1 from annotations
// in camera_android_camerax/test/video_capture_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:camera_android_camerax/src/pending_recording.dart' as _i2;
import 'package:camera_android_camerax/src/recorder.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

import 'test_camerax_library.g.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePendingRecording_0 extends _i1.SmartFake
    implements _i2.PendingRecording {
  _FakePendingRecording_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TestVideoCaptureHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestVideoCaptureHostApi extends _i1.Mock
    implements _i3.TestVideoCaptureHostApi {
  MockTestVideoCaptureHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int withOutput(int? videoOutputId) => (super.noSuchMethod(
        Invocation.method(
          #withOutput,
          [videoOutputId],
        ),
        returnValue: 0,
      ) as int);
  @override
  int getOutput(int? identifier) => (super.noSuchMethod(
        Invocation.method(
          #getOutput,
          [identifier],
        ),
        returnValue: 0,
      ) as int);
  @override
  void setTargetRotation(
    int? identifier,
    int? rotation,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setTargetRotation,
          [
            identifier,
            rotation,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TestInstanceManagerHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestInstanceManagerHostApi extends _i1.Mock
    implements _i3.TestInstanceManagerHostApi {
  MockTestInstanceManagerHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void clear() => super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [Recorder].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockRecorder extends _i1.Mock implements _i4.Recorder {
  MockRecorder() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.PendingRecording> prepareRecording(String? path) =>
      (super.noSuchMethod(
        Invocation.method(
          #prepareRecording,
          [path],
        ),
        returnValue:
            _i5.Future<_i2.PendingRecording>.value(_FakePendingRecording_0(
          this,
          Invocation.method(
            #prepareRecording,
            [path],
          ),
        )),
      ) as _i5.Future<_i2.PendingRecording>);
}
