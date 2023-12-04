// Mocks generated by Mockito 5.4.3 from annotations
// in camera_android_camerax/test/pending_recording_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:camera_android_camerax/src/recording.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

import 'test_camerax_library.g.dart' as _i2;

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

/// A class which mocks [TestPendingRecordingHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestPendingRecordingHostApi extends _i1.Mock
    implements _i2.TestPendingRecordingHostApi {
  MockTestPendingRecordingHostApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int start(int? identifier) => (super.noSuchMethod(
        Invocation.method(
          #start,
          [identifier],
        ),
        returnValue: 0,
      ) as int);
}

/// A class which mocks [TestInstanceManagerHostApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestInstanceManagerHostApi extends _i1.Mock
    implements _i2.TestInstanceManagerHostApi {
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

/// A class which mocks [Recording].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockRecording extends _i1.Mock implements _i3.Recording {
  MockRecording() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> pause() => (super.noSuchMethod(
        Invocation.method(
          #pause,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> resume() => (super.noSuchMethod(
        Invocation.method(
          #resume,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> stop() => (super.noSuchMethod(
        Invocation.method(
          #stop,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
