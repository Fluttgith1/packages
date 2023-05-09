// Mocks generated by Mockito 5.4.0 from annotations
// in camera_android_camerax/test/recorder_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:camera_android_camerax/src/pending_recording.dart' as _i4;
import 'package:camera_android_camerax/src/recording.dart' as _i2;
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

class _FakeRecording_0 extends _i1.SmartFake implements _i2.Recording {
  _FakeRecording_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TestRecorderHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestRecorderHostApi extends _i1.Mock
    implements _i3.TestRecorderHostApi {
  MockTestRecorderHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void create(
    int? identifier,
    int? aspectRatio,
    int? bitRate,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #create,
          [
            identifier,
            aspectRatio,
            bitRate,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  int getAspectRatio(int? identifier) => (super.noSuchMethod(
        Invocation.method(
          #getAspectRatio,
          [identifier],
        ),
        returnValue: 0,
      ) as int);
  @override
  int getTargetVideoEncodingBitRate(int? identifier) => (super.noSuchMethod(
        Invocation.method(
          #getTargetVideoEncodingBitRate,
          [identifier],
        ),
        returnValue: 0,
      ) as int);
  @override
  int prepareRecording(
    int? identifier,
    String? path,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #prepareRecording,
          [
            identifier,
            path,
          ],
        ),
        returnValue: 0,
      ) as int);
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

/// A class which mocks [PendingRecording].
///
/// See the documentation for Mockito's code generation for more information.
class MockPendingRecording extends _i1.Mock implements _i4.PendingRecording {
  MockPendingRecording() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Recording> start() => (super.noSuchMethod(
        Invocation.method(
          #start,
          [],
        ),
        returnValue: _i5.Future<_i2.Recording>.value(_FakeRecording_0(
          this,
          Invocation.method(
            #start,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Recording>);
}
