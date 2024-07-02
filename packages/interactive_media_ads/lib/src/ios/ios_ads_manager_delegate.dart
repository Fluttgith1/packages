// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import '../platform_interface/platform_interface.dart';
import 'enum_converter_extensions.dart';
import 'interactive_media_ads.g.dart' as ima;
import 'interactive_media_ads_proxy.dart';

/// Implementation of [PlatformAdsManagerDelegateCreationParams] for iOS.
final class IOSAdsManagerDelegateCreationParams
    extends PlatformAdsManagerDelegateCreationParams {
  /// Constructs an [IOSAdsManagerDelegateCreationParams].
  const IOSAdsManagerDelegateCreationParams({
    @visibleForTesting InteractiveMediaAdsProxy? proxy,
  })  : _proxy = proxy ?? const InteractiveMediaAdsProxy(),
        super();

  /// Creates an [IOSAdsManagerDelegateCreationParams] from an instance of
  /// [PlatformAdsManagerDelegateCreationParams].
  factory IOSAdsManagerDelegateCreationParams.fromPlatformAdsManagerDelegateCreationParams(
    // This parameter acts as a placeholder to prevent breaking changes when new
    // fields are added to `PlatformAdsManagerDelegateCreationParams`.
    // ignore: avoid_unused_constructor_parameters
    PlatformAdsManagerDelegateCreationParams params, {
    @visibleForTesting InteractiveMediaAdsProxy? proxy,
  }) {
    return IOSAdsManagerDelegateCreationParams(proxy: proxy);
  }

  final InteractiveMediaAdsProxy _proxy;
}

/// Implementation of [PlatformAdsManagerDelegate] for iOS.
final class IOSAdsManagerDelegate extends PlatformAdsManagerDelegate {
  /// Constructs an [IOSAdsManagerDelegate].
  IOSAdsManagerDelegate(super.params) : super.implementation();

  /// The native iOS `IMAAdsManagerDelegate`.
  ///
  /// This handles ad events and errors that occur during ad or stream
  /// initialization and playback.
  @internal
  late final ima.IMAAdsManagerDelegate delegate = _createAdsManagerDelegate(
    WeakReference<IOSAdsManagerDelegate>(this),
  );

  late final IOSAdsManagerDelegateCreationParams _iosParams =
      params is IOSAdsManagerDelegateCreationParams
          ? params as IOSAdsManagerDelegateCreationParams
          : IOSAdsManagerDelegateCreationParams
              .fromPlatformAdsManagerDelegateCreationParams(params);

  // This value is created in a static method because the callback methods for
  // any wrapped classes must not reference the encapsulating object. This is to
  // prevent a circular reference that prevents garbage collection.
  static ima.IMAAdsManagerDelegate _createAdsManagerDelegate(
    WeakReference<IOSAdsManagerDelegate> interfaceDelegate,
  ) {
    return interfaceDelegate.target!._iosParams._proxy.newIMAAdsManagerDelegate(
      didReceiveAdEvent: (
        ima.IMAAdsManagerDelegate instance,
        ima.IMAAdsManager adsManager,
        ima.IMAAdEvent event,
      ) {
        late final AdEventType? eventType = event.type.asInterfaceAdEventType();
        if (eventType == null) {
          return;
        }

        interfaceDelegate.target?.params.onAdEvent
            ?.call(AdEvent(type: eventType));
      },
      didReceiveAdError: (
        ima.IMAAdsManagerDelegate instance,
        ima.IMAAdsManager adsManager,
        ima.IMAAdError event,
      ) {
        interfaceDelegate.target?.params.onAdErrorEvent?.call(
          AdErrorEvent(
            error: AdError(
              type: event.type.asInterfaceErrorType(),
              code: event.code.asInterfaceErrorCode(),
              message: event.message,
            ),
          ),
        );
      },
      didRequestContentPause: (
        ima.IMAAdsManagerDelegate instance,
        ima.IMAAdsManager adsManager,
      ) {
        interfaceDelegate.target?.params.onAdEvent?.call(
          const AdEvent(type: AdEventType.contentPauseRequested),
        );
      },
      didRequestContentResume: (
        ima.IMAAdsManagerDelegate instance,
        ima.IMAAdsManager adsManager,
      ) {
        interfaceDelegate.target?.params.onAdEvent?.call(
          const AdEvent(type: AdEventType.contentResumeRequested),
        );
      },
    );
  }
}
