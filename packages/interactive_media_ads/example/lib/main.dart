// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:interactive_media_ads/interactive_media_ads.dart';
import 'package:video_player/video_player.dart';
import 'package:interactive_media_ads/src/platform_interface/platform_interface.dart';
import 'package:interactive_media_ads/src/android/android_interactive_media_ads.dart';

/// Entry point for integration tests that require espresso.
@pragma('vm:entry-point')
void integrationTestMain() {
  enableFlutterDriverExtension();
  main();
}

void main() {
  InteractiveMediaAdsPlatform.instance = AndroidInteractiveMediaAds();
  runApp(MaterialApp(home: AdExampleWidget()));
}

class AdExampleWidget extends StatefulWidget {
  @override
  AdExampleWidgetState createState() => AdExampleWidgetState();
}

class AdExampleWidgetState extends State<AdExampleWidget> {
  late final AdsLoader adsLoader;
  AdsManager? adsManager;
  bool shouldShowContentVideo = false;

  late final VideoPlayerController contentVideoController;

  late final AdDisplayContainer adDisplayContainer = AdDisplayContainer(
    onContainerAdded: (AdDisplayContainer container) {
      requestAds(container);
    },
  );

  @override
  void initState() {
    super.initState();
    contentVideoController = VideoPlayerController.networkUrl(Uri.parse(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4'))
      ..addListener(() {
        if (contentVideoController.value.position ==
            contentVideoController.value.duration) {
          adsLoader.contentComplete();
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  Future<void> resumeContent() {
    setState(() {
      shouldShowContentVideo = true;
    });
    return contentVideoController.play();
  }

  Future<void> pauseContent() {
    setState(() {
      shouldShowContentVideo = false;
    });
    return contentVideoController.pause();
  }

  Future<void> requestAds(AdDisplayContainer container) {
    adsLoader = AdsLoader(
      container: container,
      onAdsLoaded: (OnAdsLoadedData data) {
        final AdsManager manager = data.manager;
        adsManager = data.manager;

        manager.setAdsManagerDelegate(AdsManagerDelegate(
          onAdEvent: (AdEvent event) {
            switch (event.type) {
              case AdEventType.loaded:
                manager.start();
              case AdEventType.contentPauseRequested:
                pauseContent();
              case AdEventType.contentResumeRequested:
                resumeContent();
              case AdEventType.allAdsCompleted:
                manager.destroy();
                adsManager = null;
              case AdEventType.clicked:
              case AdEventType.complete:
            }
          },
          onAdErrorEvent: (AdErrorEvent event) {
            print('ERROR:');
            print(event.error.message);
            //manager.discardAdBreak();
            resumeContent();
          },
        ));

        manager.init();
      },
      onAdsLoadError: (AdsLoadErrorData data) {
        print('Error 2:');
        print(data.error.message);
        resumeContent();
      },
    );

    return adsLoader.requestAds(
      AdsRequest(
        adTagUrl:
            'https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=',
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    contentVideoController.dispose();
    adsManager?.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            children: <Widget>[
              if (contentVideoController.value.isInitialized &&
                  shouldShowContentVideo)
                AspectRatio(
                  aspectRatio: contentVideoController.value.aspectRatio,
                  child: VideoPlayer(contentVideoController),
                ),
              // The display container must be on screen before any Ads can be
              // loaded and can't be removed between ads. This handles clicks for
              // ads.
              adDisplayContainer,
            ],
          ),
        ),
      ),
    );
  }
}
