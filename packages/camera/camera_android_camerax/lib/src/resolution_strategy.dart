// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';

import 'camerax_library.g.dart';
import 'instance_manager.dart';
import 'java_object.dart';

/// The resolution strategy defines the resolution selection sequence to select
/// the best size.
///
/// See https://developer.android.com/reference/androidx/camera/core/resolutionselector/ResolutionStrategy.
class ResolutionStrategy extends JavaObject {
  /// Construct a [ResolutionStrategy].
  ResolutionStrategy({
    required this.boundSize,
    required this.fallbackRule,
    super.binaryMessenger,
    super.instanceManager,
  })  : _api = _ResolutionStrategyHostApiImpl(
          instanceManager: instanceManager,
          binaryMessenger: binaryMessenger,
        ),
        super.detached() {
    _api.createFromInstances(this, boundSize, fallbackRule);
  }

  /// Instantiates a [ResolutionStrategy] without creating and attaching to an
  /// instance of the associated native class.
  ///
  /// This should only be used outside of tests by subclasses created by this
  /// library or to create a copy for an [InstanceManager].
  ResolutionStrategy.detached({
    required this.boundSize,
    required this.fallbackRule,
    super.binaryMessenger,
    super.instanceManager,
  })  : _api = _ResolutionStrategyHostApiImpl(
          instanceManager: instanceManager,
          binaryMessenger: binaryMessenger,
        ),
        super.detached();

  /// CameraX doesn't select an alternate size when the specified bound size is
  /// unavailable.
  ///
  /// Applications will receive [PlatformException] when binding the [UseCase]s
  /// with this fallback rule if the device doesn't support the specified bound
  /// size.
  ///
  /// See https://developer.android.com/reference/androidx/camera/core/resolutionselector/ResolutionStrategy#FALLBACK_RULE_NONE().
  static const int fallbackRuleNone = 0;

  /// When the specified bound size is unavailable, CameraX falls back to select
  /// the closest higher resolution size.
  ///
  /// See https://developer.android.com/reference/androidx/camera/core/resolutionselector/ResolutionStrategy#FALLBACK_RULE_CLOSEST_HIGHER_THEN_LOWER().
  static const int fallbackRuleClosestHigherThenLower = 1;

  /// When the specified bound size is unavailable, CameraX falls back to the
  /// closest higher resolution size.
  ///
  /// If CameraX still cannot find any available resolution, it will fallback to
  /// select other lower resolutions.
  ///
  /// See https://developer.android.com/reference/androidx/camera/core/resolutionselector/ResolutionStrategy#FALLBACK_RULE_CLOSEST_HIGHER().
  static const int fallbackRuleClosestHigher = 2;

  /// When the specified bound size is unavailable, CameraX falls back to select
  /// the closest lower resolution size.
  ///
  /// If CameraX still cannot find any available resolution, it will fallback to
  /// select other higher resolutions.
  ///
  /// See https://developer.android.com/reference/androidx/camera/core/resolutionselector/ResolutionStrategy#FALLBACK_RULE_CLOSEST_LOWER_THEN_HIGHER().
  static const int fallbackRuleClosestLowerThenHigher = 3;

  /// When the specified bound size is unavailable, CameraX falls back to the
  /// closest lower resolution size.
  ///
  /// See https://developer.android.com/reference/androidx/camera/core/resolutionselector/ResolutionStrategy#FALLBACK_RULE_CLOSEST_LOWER()
  static const int fallbackRuleClosestLower = 4;

  final _ResolutionStrategyHostApiImpl _api;

  /// The specified bound size for the desired resolution of the camera.
  final Size boundSize;

  /// The fallback rule for choosing an alternate size when the specified bound
  /// size is unavailable.
  final int fallbackRule;
}

class _ResolutionStrategyHostApiImpl extends ResolutionStrategyHostApi {
  _ResolutionStrategyHostApiImpl({
    this.binaryMessenger,
    InstanceManager? instanceManager,
  })  : instanceManager = instanceManager ?? JavaObject.globalInstanceManager,
        super(binaryMessenger: binaryMessenger);

  final BinaryMessenger? binaryMessenger;

  final InstanceManager instanceManager;

  Future<void> createFromInstances(
    ResolutionStrategy instance,
    Size boundSize,
    int fallbackRule,
  ) {
    return create(
      instanceManager.addDartCreatedInstance(
        instance,
        onCopy: (ResolutionStrategy original) => ResolutionStrategy.detached(
          boundSize: original.boundSize,
          fallbackRule: original.fallbackRule,
          binaryMessenger: binaryMessenger,
          instanceManager: instanceManager,
        ),
      ),
      CameraSize(
        width: boundSize.width.toInt(),
        height: boundSize.height.toInt(),
      ),
      fallbackRule,
    );
  }
}
