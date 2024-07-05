// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_media_ads/src/ios/interactive_media_ads.g.dart'
    as ima;
import 'package:interactive_media_ads/src/ios/interactive_media_ads_proxy.dart';
import 'package:interactive_media_ads/src/ios/ios_ads_manager.dart';
import 'package:interactive_media_ads/src/ios/ios_ads_manager_delegate.dart';
import 'package:interactive_media_ads/src/platform_interface/platform_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(<MockSpec<Object>>[MockSpec<ima.IMAAdsManager>()])
void main() {
  group('IOSAdsManagerDelegate', () {
    test('didReceiveAdEvent calls onAdEvent', () {
      late final void Function(
        ima.IMAAdsManagerDelegate,
        ima.IMAAdsManager,
        ima.IMAAdEvent,
      ) didReceiveAdEventCallback;

      late final ima.IMAAdsManagerDelegate delegate;
      final InteractiveMediaAdsProxy imaProxy = InteractiveMediaAdsProxy(
        newIMAAdsManagerDelegate: ({
          required void Function(
            ima.IMAAdsManagerDelegate,
            ima.IMAAdsManager,
            ima.IMAAdEvent,
          ) didReceiveAdEvent,
          required void Function(
            ima.IMAAdsManagerDelegate,
            ima.IMAAdsManager,
            ima.IMAAdError,
          ) didReceiveAdError,
          required void Function(ima.IMAAdsManagerDelegate, ima.IMAAdsManager)
              didRequestContentPause,
          required void Function(ima.IMAAdsManagerDelegate, ima.IMAAdsManager)
              didRequestContentResume,
        }) {
          didReceiveAdEventCallback = didReceiveAdEvent;
          delegate = ima.IMAAdsManagerDelegate.pigeon_detached(
            didReceiveAdEvent: didReceiveAdEvent,
            didReceiveAdError: didReceiveAdError,
            didRequestContentPause: didRequestContentPause,
            didRequestContentResume: didRequestContentResume,
          );
          return delegate;
        },
      );

      final IOSAdsManagerDelegate adsManagerDelegate = IOSAdsManagerDelegate(
        IOSAdsManagerDelegateCreationParams(
          onAdEvent: expectAsync1((AdEvent event) {
            expect(event.type, AdEventType.allAdsCompleted);
          }),
          proxy: imaProxy,
        ),
      );

      // Calls the field because the value is instantiated lazily.
      // ignore: unnecessary_statements
      adsManagerDelegate.delegate;

      didReceiveAdEventCallback(
        delegate,
        ima.IMAAdsManager.pigeon_detached(),
        ima.IMAAdEvent.pigeon_detached(
          type: ima.AdEventType.allAdsCompleted,
          typeString: 'typeString',
        ),
      );
    });
  });
}
