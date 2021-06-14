// Mocks generated by Mockito 5.0.7 from annotations
// in flutter_unit_tests/test/all_datatypes_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;
import 'dart:typed_data' as _i4;
import 'dart:ui' as _i5;

import 'package:flutter/src/services/binary_messenger.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: always_specify_types
// ignore_for_file: implicit_dynamic_type
// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

/// A class which mocks [BinaryMessenger].
///
/// See the documentation for Mockito's code generation for more information.
class MockBinaryMessenger extends _i1.Mock implements _i2.BinaryMessenger {
  MockBinaryMessenger() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> handlePlatformMessage(String? channel, _i4.ByteData? data,
          _i5.PlatformMessageResponseCallback? callback) =>
      (super.noSuchMethod(
          Invocation.method(#handlePlatformMessage, [channel, data, callback]),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  _i3.Future<_i4.ByteData?>? send(String? channel, _i4.ByteData? message) =>
      (super.noSuchMethod(Invocation.method(#send, [channel, message]))
          as _i3.Future<_i4.ByteData?>?);
  @override
  void setMessageHandler(String? channel, _i2.MessageHandler? handler) => super
      .noSuchMethod(Invocation.method(#setMessageHandler, [channel, handler]),
          returnValueForMissingStub: null);
}
