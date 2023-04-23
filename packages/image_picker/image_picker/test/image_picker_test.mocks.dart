// Mocks generated by Mockito 5.4.0 from annotations
// in image_picker/test/image_picker_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cross_file/cross_file.dart' as _i5;
import 'package:image_picker_platform_interface/src/platform_interface/image_picker_platform.dart'
    as _i3;
import 'package:image_picker_platform_interface/src/types/types.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeLostData_0 extends _i1.SmartFake implements _i2.LostData {
  _FakeLostData_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLostDataResponse_1 extends _i1.SmartFake
    implements _i2.LostDataResponse {
  _FakeLostDataResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ImagePickerPlatform].
///
/// See the documentation for Mockito's code generation for more information.
class MockImagePickerPlatform extends _i1.Mock
    implements _i3.ImagePickerPlatform {
  MockImagePickerPlatform() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.PickedFile?> pickImage({
    required _i2.ImageSource? source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    _i2.CameraDevice? preferredCameraDevice = _i2.CameraDevice.rear,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pickImage,
          [],
          {
            #source: source,
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
            #preferredCameraDevice: preferredCameraDevice,
          },
        ),
        returnValue: _i4.Future<_i2.PickedFile?>.value(),
      ) as _i4.Future<_i2.PickedFile?>);
  @override
  _i4.Future<List<_i2.PickedFile>?> pickMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pickMultiImage,
          [],
          {
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
          },
        ),
        returnValue: _i4.Future<List<_i2.PickedFile>?>.value(),
      ) as _i4.Future<List<_i2.PickedFile>?>);
  @override
  _i4.Future<_i2.PickedFile?> pickVideo({
    required _i2.ImageSource? source,
    _i2.CameraDevice? preferredCameraDevice = _i2.CameraDevice.rear,
    Duration? maxDuration,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pickVideo,
          [],
          {
            #source: source,
            #preferredCameraDevice: preferredCameraDevice,
            #maxDuration: maxDuration,
          },
        ),
        returnValue: _i4.Future<_i2.PickedFile?>.value(),
      ) as _i4.Future<_i2.PickedFile?>);
  @override
  _i4.Future<_i2.LostData> retrieveLostData() => (super.noSuchMethod(
        Invocation.method(
          #retrieveLostData,
          [],
        ),
        returnValue: _i4.Future<_i2.LostData>.value(_FakeLostData_0(
          this,
          Invocation.method(
            #retrieveLostData,
            [],
          ),
        )),
      ) as _i4.Future<_i2.LostData>);
  @override
  _i4.Future<_i5.XFile?> getImage({
    required _i2.ImageSource? source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    _i2.CameraDevice? preferredCameraDevice = _i2.CameraDevice.rear,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getImage,
          [],
          {
            #source: source,
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
            #preferredCameraDevice: preferredCameraDevice,
          },
        ),
        returnValue: _i4.Future<_i5.XFile?>.value(),
      ) as _i4.Future<_i5.XFile?>);
  @override
  _i4.Future<List<_i5.XFile>?> getMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMultiImage,
          [],
          {
            #maxWidth: maxWidth,
            #maxHeight: maxHeight,
            #imageQuality: imageQuality,
          },
        ),
        returnValue: _i4.Future<List<_i5.XFile>?>.value(),
      ) as _i4.Future<List<_i5.XFile>?>);
  @override
  _i4.Future<_i5.XFile?> getVideo({
    required _i2.ImageSource? source,
    _i2.CameraDevice? preferredCameraDevice = _i2.CameraDevice.rear,
    Duration? maxDuration,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getVideo,
          [],
          {
            #source: source,
            #preferredCameraDevice: preferredCameraDevice,
            #maxDuration: maxDuration,
          },
        ),
        returnValue: _i4.Future<_i5.XFile?>.value(),
      ) as _i4.Future<_i5.XFile?>);
  @override
  _i4.Future<_i2.LostDataResponse> getLostData() => (super.noSuchMethod(
        Invocation.method(
          #getLostData,
          [],
        ),
        returnValue:
            _i4.Future<_i2.LostDataResponse>.value(_FakeLostDataResponse_1(
          this,
          Invocation.method(
            #getLostData,
            [],
          ),
        )),
      ) as _i4.Future<_i2.LostDataResponse>);
  @override
  _i4.Future<_i5.XFile?> getImageFromSource({
    required _i2.ImageSource? source,
    _i2.ImagePickerOptions? options = const _i2.ImagePickerOptions(),
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getImageFromSource,
          [],
          {
            #source: source,
            #options: options,
          },
        ),
        returnValue: _i4.Future<_i5.XFile?>.value(),
      ) as _i4.Future<_i5.XFile?>);
  @override
  _i4.Future<List<_i5.XFile>> getMultiImageWithOptions(
          {_i2.MultiImagePickerOptions? options =
              const _i2.MultiImagePickerOptions()}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMultiImageWithOptions,
          [],
          {#options: options},
        ),
        returnValue: _i4.Future<List<_i5.XFile>>.value(<_i5.XFile>[]),
      ) as _i4.Future<List<_i5.XFile>>);
}
