// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:meta/meta.dart' show immutable;

import 'android_camera_camerax_flutter_api_impls.dart';
import 'camerax_library.g.dart';
import 'instance_manager.dart';
import 'java_object.dart';

/// A bundle of Camera2 capture request options.
///
/// See https://developer.android.com/reference/androidx/camera/camera2/interop/CaptureRequestOptions.
@immutable
class CaptureRequestOptions extends JavaObject {
  /// Creates a [CaptureRequestOptions].
  ///
  /// Any value specified as null for a particular
  /// [CaptureRequestKeySupportedType] key will clear the pre-existing value.
  CaptureRequestOptions({
    BinaryMessenger? binaryMessenger,
    InstanceManager? instanceManager,
    required this.requestedOptions,
  }) : super.detached(
            binaryMessenger: binaryMessenger,
            instanceManager: instanceManager) {
    _api = _CaptureRequestOptionsHostApiImpl(
        binaryMessenger: binaryMessenger, instanceManager: instanceManager);
    AndroidCameraXCameraFlutterApis.instance.ensureSetUp();
    _api.createFromInstances(this, requestedOptions);
  }

  /// Constructs an [CaptureRequestOptions] that is not automatically attached to a
  /// native object.
  CaptureRequestOptions.detached({
    BinaryMessenger? binaryMessenger,
    InstanceManager? instanceManager,
    required this.requestedOptions,
  }) : super.detached(
            binaryMessenger: binaryMessenger,
            instanceManager: instanceManager) {
    _api = _CaptureRequestOptionsHostApiImpl(
        binaryMessenger: binaryMessenger, instanceManager: instanceManager);
    AndroidCameraXCameraFlutterApis.instance.ensureSetUp();
  }

  late final _CaptureRequestOptionsHostApiImpl _api;

  List<(CaptureRequestKeySupportedType type, dynamic value)> requestedOptions;

  /// Error message indicating a [CaptureRequestOption] was constructed with a
  /// capture request key currently unsupported by the wrapping of this class.
  static const String unsupportedCaptureRequestKeyTypeErrorMessage =
      'The type of capture request key passed to this method is current unspported; please see CaptureRequestKeySupportedType in pigeons/camerax_library.dart if you wish to support a new type.';
}

/// Host API implementation of [CaptureRequestOptions].
class _CaptureRequestOptionsHostApiImpl extends CaptureRequestOptionsHostApi {
  /// Constructs a [_CaptureRequestOptionsHostApiImpl].
  ///
  /// If [binaryMessenger] is null, the default [BinaryMessenger] will be used,
  /// which routes to the host platform.
  ///
  /// An [instanceManager] is typically passed when a copy of an instance
  /// contained by an [InstanceManager] is being created. If left null, it
  /// will default to the global instance defined in [JavaObject].
  _CaptureRequestOptionsHostApiImpl({
    this.binaryMessenger,
    InstanceManager? instanceManager,
  })  : instanceManager = instanceManager ?? JavaObject.globalInstanceManager,
        super(binaryMessenger: binaryMessenger);

  /// Receives binary data across the Flutter platform barrier.
  ///
  /// If it is null, the default [BinaryMessenger] will be used which routes to
  /// the host platform.
  final BinaryMessenger? binaryMessenger;

  /// Maintains instances stored to communicate with native language objects.
  final InstanceManager instanceManager;

  /// Creates a [CaptureRequestOptions] instance based on the specified
  /// capture request key and value pairs.
  Future<void> createFromInstances(
    CaptureRequestOptions instance,
    List<(CaptureRequestKeySupportedType type, dynamic value)> options,
  ) {
    if (options.isEmpty) {
      throw ArgumentError(
          'At least one capture request option must be specified.');
    }

    final List<CaptureRequestOption> captureRequestOptions =
        <CaptureRequestOption>[];

    // Validate values have type that matches paired key that is supported by
    // this plugin (CaptureRequestKeySupportedType).
    for (final (CaptureRequestKeySupportedType key, dynamic value) option
        in options) {
      final CaptureRequestKeySupportedType key = option.$1;
      final dynamic value = option.$2;
      if (value == null) {
        captureRequestOptions.add(CaptureRequestOption(key: key, value: ''));
        continue;
      }

      switch (key) {
        case CaptureRequestKeySupportedType.controlAeLock:
          if (value.runtimeType != bool) {
            throw ArgumentError(
                'A controlAeLock value must be specified as a bool.');
          }
        // This ignore statement is safe beause this error will be useful when
        // a new CaptureRequestKeySupportedType is being added, but the logic in
        // this method has not yet been updated.
        // ignore: no_default_cases
        default:
          throw ArgumentError(CaptureRequestOptions
              .unsupportedCaptureRequestKeyTypeErrorMessage);
      }

      captureRequestOptions
          .add(CaptureRequestOption(key: key, value: value.toString()));
    }
    return create(
      instanceManager.addDartCreatedInstance(
        instance,
        onCopy: (CaptureRequestOptions original) =>
            CaptureRequestOptions.detached(
          requestedOptions: original.requestedOptions,
          binaryMessenger: binaryMessenger,
          instanceManager: instanceManager,
        ),
      ),
      captureRequestOptions,
    );
  }
}
