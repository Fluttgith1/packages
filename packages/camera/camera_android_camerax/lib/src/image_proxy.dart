// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart' show BinaryMessenger;
import 'package:meta/meta.dart' show protected;

import 'android_camera_camerax_flutter_api_impls.dart';
import 'camerax_library.g.dart';
import 'instance_manager.dart';
import 'java_object.dart';
import 'plane_proxy.dart';

/// Representation of a single complete image buffer.
///
/// See https://developer.android.com/reference/androidx/camera/core/ImageProxy.
class ImageProxy extends JavaObject {
  /// Constructs a [ImageProxy] that is not automatically attached to a native object.
  ImageProxy.detached(
      {BinaryMessenger? binaryMessenger, InstanceManager? instanceManager})
      : super.detached(
            binaryMessenger: binaryMessenger,
            instanceManager: instanceManager) {
    _api = _ImageProxyHostApiImpl(
        binaryMessenger: binaryMessenger, instanceManager: instanceManager);
    AndroidCameraXCameraFlutterApis.instance.ensureSetUp();
  }

  late final _ImageProxyHostApiImpl _api;

  /// Returns the list of color planes of image data.
  Future<List<PlaneProxy>> getPlanes() => _api.getPlanesFromInstances(this);

  /// Returns the image format.
  Future<int> getFormat() => _api.getFormatFromInstances(this);

  /// Returns the image height.
  Future<int> getHeight() => _api.getHeightFromInstances(this);

  /// Returns the image width.
  Future<int> getWidth() => _api.getWidthFromInstances(this);

  /// Closes the underlying image.
  Future<void> close() => _api.closeFromInstances(this);
}

/// Host API implementation of [ImageProxy].
class _ImageProxyHostApiImpl extends ImageProxyHostApi {
  _ImageProxyHostApiImpl({
    this.binaryMessenger,
    InstanceManager? instanceManager,
  })  : instanceManager = instanceManager ?? JavaObject.globalInstanceManager,
        super(binaryMessenger: binaryMessenger);

  final BinaryMessenger? binaryMessenger;

  final InstanceManager instanceManager;

  /// Returns the list of color planes of the image data represnted by the
  /// [instance].
  Future<List<PlaneProxy>> getPlanesFromInstances(
    ImageProxy instance,
  ) async {
    final List<int?> planesAsObjects = await getPlanes(
      instanceManager.getIdentifier(instance)!,
    );

    return planesAsObjects.map((int? planeIdentifier) {
      return instanceManager
          .getInstanceWithWeakReference<PlaneProxy>(planeIdentifier!)!;
    }) as List<PlaneProxy>;
  }

  /// Returns the format of the image represented by the [instance].
  Future<int> getFormatFromInstances(
    ImageProxy instance,
  ) {
    return getFormat(
      instanceManager.getIdentifier(instance)!,
    );
  }

  /// Returns the height of the image represented by the [instance].
  Future<int> getHeightFromInstances(
    ImageProxy instance,
  ) {
    return getHeight(
      instanceManager.getIdentifier(instance)!,
    );
  }

  /// Returns the width of the image represented by the [instance].
  Future<int> getWidthFromInstances(
    ImageProxy instance,
  ) {
    return getWidth(
      instanceManager.getIdentifier(instance)!,
    );
  }

  /// Closes the underlying image of the [instance].
  Future<void> closeFromInstances(
    ImageProxy instance,
  ) {
    return close(
      instanceManager.getIdentifier(instance)!,
    );
  }
}

/// Flutter API implementation for [ImageProxy].
///
/// This class may handle instantiating and adding Dart instances that are
/// attached to a native instance or receiving callback methods from an
/// overridden native class.
@protected
class ImageProxyFlutterApiImpl implements ImageProxyFlutterApi {
  /// Constructs a [ImageProxyFlutterApiImpl].
  ImageProxyFlutterApiImpl({
    this.binaryMessenger,
    InstanceManager? instanceManager,
  }) : instanceManager = instanceManager ?? JavaObject.globalInstanceManager;

  /// Receives binary data across the Flutter platform barrier.
  ///
  /// If it is null, the default BinaryMessenger will be used which routes to
  /// the host platform.
  final BinaryMessenger? binaryMessenger;

  /// Maintains instances stored to communicate with native language objects.
  final InstanceManager instanceManager;

  @override
  void create(
    int identifier,
  ) {
    instanceManager.addHostCreatedInstance(
      ImageProxy.detached(
        binaryMessenger: binaryMessenger,
        instanceManager: instanceManager,
      ),
      identifier,
      onCopy: (ImageProxy original) => ImageProxy.detached(
        binaryMessenger: binaryMessenger,
        instanceManager: instanceManager,
      ),
    );
  }
}
