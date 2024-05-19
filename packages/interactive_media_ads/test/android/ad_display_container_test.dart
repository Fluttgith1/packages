// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_media_ads/src/android/android_ad_display_container.dart';
import 'package:interactive_media_ads/src/android/interactive_media_ads.g.dart'
    as ima;
import 'package:interactive_media_ads/src/android/interactive_media_ads_proxy.dart';
import 'package:interactive_media_ads/src/android/platform_views_service_proxy.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ad_display_container_test.mocks.dart';

@GenerateNiceMocks(<MockSpec<Object>>[
  MockSpec<ima.AdDisplayContainer>(),
  MockSpec<ima.AdMediaInfo>(),
  MockSpec<ima.AdPodInfo>(),
  MockSpec<ima.FrameLayout>(),
  MockSpec<ima.MediaPlayer>(),
  MockSpec<ima.VideoAdPlayer>(),
  MockSpec<ima.VideoAdPlayerCallback>(),
  MockSpec<ima.VideoView>(),
  MockSpec<SurfaceAndroidViewController>(),
  MockSpec<PlatformViewsServiceProxy>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AndroidAdDisplayContainer', () {
    testWidgets('build with key', (WidgetTester tester) async {
      final AndroidAdDisplayContainer container = AndroidAdDisplayContainer(
        AndroidAdDisplayContainerCreationParams(
          key: const Key('testKey'),
          onContainerAdded: (_) {},
        ),
      );

      await tester.pumpWidget(Builder(
        builder: (BuildContext context) => container.build(context),
      ));

      expect(find.byType(PlatformViewLink), findsOneWidget);
      expect(find.byKey(const Key('testKey')), findsOneWidget);
    });

    testWidgets('onContainerAdded is called', (WidgetTester tester) async {
      final InteractiveMediaAdsProxy imaProxy = InteractiveMediaAdsProxy(
        newFrameLayout: () => MockFrameLayout(),
        newVideoView: ({
          required dynamic onError,
          dynamic onPrepared,
          dynamic onCompletion,
        }) =>
            MockVideoView(),
        createAdDisplayContainerImaSdkFactory: (
          _,
          __,
        ) async {
          return MockAdDisplayContainer();
        },
        newVideoAdPlayer: ({
          required dynamic addCallback,
          required dynamic loadAd,
          required dynamic pauseAd,
          required dynamic playAd,
          required dynamic release,
          required dynamic removeCallback,
          required dynamic stopAd,
        }) =>
            MockVideoAdPlayer(),
      );

      final MockPlatformViewsServiceProxy mockPlatformViewsProxy =
          MockPlatformViewsServiceProxy();
      final MockSurfaceAndroidViewController mockAndroidViewController =
          MockSurfaceAndroidViewController();

      late final int platformViewId;
      when(
        mockPlatformViewsProxy.initSurfaceAndroidView(
          id: anyNamed('id'),
          viewType: anyNamed('viewType'),
          layoutDirection: anyNamed('layoutDirection'),
          creationParams: anyNamed('creationParams'),
          creationParamsCodec: anyNamed('creationParamsCodec'),
          onFocus: anyNamed('onFocus'),
        ),
      ).thenAnswer((Invocation invocation) {
        platformViewId = invocation.namedArguments[const Symbol('id')] as int;
        return mockAndroidViewController;
      });

      final AndroidAdDisplayContainer container = AndroidAdDisplayContainer(
        AndroidAdDisplayContainerCreationParams(
          onContainerAdded: expectAsync1((_) {}),
          platformViewsProxy: mockPlatformViewsProxy,
          imaProxy: imaProxy,
        ),
      );

      await tester.pumpWidget(Builder(
        builder: (BuildContext context) => container.build(context),
      ));

      (verify(mockAndroidViewController
                  .addOnPlatformViewCreatedListener(captureAny))
              .captured[0] as void Function(int))
          .call(platformViewId);

      await tester.pumpAndSettle();
    });

    test('completing the ad notifies IMA SDK the ad has ended', () {
      late final void Function(
        ima.VideoAdPlayer,
        ima.AdMediaInfo,
        ima.AdPodInfo,
      ) loadAdCallback;

      late final void Function(
        ima.VideoAdPlayer,
        ima.VideoAdPlayerCallback,
      ) addCallbackCallback;

      late final void Function(
        ima.VideoView,
        ima.MediaPlayer,
      ) onCompletionCallback;

      final InteractiveMediaAdsProxy imaProxy = InteractiveMediaAdsProxy(
        newFrameLayout: () => MockFrameLayout(),
        newVideoView: ({
          required dynamic onError,
          dynamic onPrepared,
          void Function(
            ima.VideoView,
            ima.MediaPlayer,
          )? onCompletion,
        }) {
          onCompletionCallback = onCompletion!;
          return MockVideoView();
        },
        createAdDisplayContainerImaSdkFactory: (
          _,
          __,
        ) async {
          return MockAdDisplayContainer();
        },
        newVideoAdPlayer: ({
          required void Function(
            ima.VideoAdPlayer,
            ima.VideoAdPlayerCallback,
          ) addCallback,
          required void Function(
            ima.VideoAdPlayer,
            ima.AdMediaInfo,
            ima.AdPodInfo,
          ) loadAd,
          required dynamic pauseAd,
          required dynamic playAd,
          required dynamic release,
          required dynamic removeCallback,
          required dynamic stopAd,
        }) {
          loadAdCallback = loadAd;
          addCallbackCallback = addCallback;
          return MockVideoAdPlayer();
        },
      );

      AndroidAdDisplayContainer(
        AndroidAdDisplayContainerCreationParams(
          onContainerAdded: (_) {},
          imaProxy: imaProxy,
        ),
      );

      final ima.AdMediaInfo mockAdMediaInfo = MockAdMediaInfo();

      loadAdCallback(MockVideoAdPlayer(), mockAdMediaInfo, MockAdPodInfo());

      final MockVideoAdPlayerCallback mockPlayerCallback =
          MockVideoAdPlayerCallback();
      addCallbackCallback(MockVideoAdPlayer(), mockPlayerCallback);

      onCompletionCallback(MockVideoView(), MockMediaPlayer());

      verify(mockPlayerCallback.onEnded(mockAdMediaInfo));
    });

    test('error loading the ad notifies IMA SDK of error', () {
      late final void Function(
        ima.VideoAdPlayer,
        ima.AdMediaInfo,
        ima.AdPodInfo,
      ) loadAdCallback;

      late final void Function(
        ima.VideoAdPlayer,
        ima.VideoAdPlayerCallback,
      ) addCallbackCallback;

      late final void Function(
        ima.VideoView,
        ima.MediaPlayer,
        int,
        int,
      ) onErrorCallback;

      final InteractiveMediaAdsProxy imaProxy = InteractiveMediaAdsProxy(
        newFrameLayout: () => MockFrameLayout(),
        newVideoView: ({
          required void Function(
            ima.VideoView,
            ima.MediaPlayer,
            int,
            int,
          ) onError,
          dynamic onPrepared,
          dynamic onCompletion,
        }) {
          onErrorCallback = onError;
          return MockVideoView();
        },
        createAdDisplayContainerImaSdkFactory: (
          _,
          __,
        ) async {
          return MockAdDisplayContainer();
        },
        newVideoAdPlayer: ({
          required void Function(
            ima.VideoAdPlayer,
            ima.VideoAdPlayerCallback,
          ) addCallback,
          required void Function(
            ima.VideoAdPlayer,
            ima.AdMediaInfo,
            ima.AdPodInfo,
          ) loadAd,
          required dynamic pauseAd,
          required dynamic playAd,
          required dynamic release,
          required dynamic removeCallback,
          required dynamic stopAd,
        }) {
          loadAdCallback = loadAd;
          addCallbackCallback = addCallback;
          return MockVideoAdPlayer();
        },
      );

      AndroidAdDisplayContainer(
        AndroidAdDisplayContainerCreationParams(
          onContainerAdded: (_) {},
          imaProxy: imaProxy,
        ),
      );

      final ima.AdMediaInfo mockAdMediaInfo = MockAdMediaInfo();

      loadAdCallback(MockVideoAdPlayer(), mockAdMediaInfo, MockAdPodInfo());

      final MockVideoAdPlayerCallback mockPlayerCallback =
          MockVideoAdPlayerCallback();
      addCallbackCallback(MockVideoAdPlayer(), mockPlayerCallback);

      onErrorCallback(MockVideoView(), MockMediaPlayer(), 0, 0);

      verify(mockPlayerCallback.onError(mockAdMediaInfo));
    });
  });
}
