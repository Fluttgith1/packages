// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_unused_constructor_parameters

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    copyrightHeader: 'pigeons/copyright.txt',
    dartOut: 'lib/src/ios/interactive_media_ads.g.dart',
    swiftOut:
        'ios/interactive_media_ads/Sources/interactive_media_ads/InteractiveMediaAdsLibrary.g.swift',
  ),
)

/// Possible error types while loading or playing ads.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Enums/IMAErrorType.html.
enum AdErrorType {
  /// An error occurred while loading the ads.
  loadingFailed,

  /// An error occurred while playing the ads.
  adPlayingFailed,

  /// An unexpected error occurred while loading or playing the ads.
  ///
  /// This may mean that the SDK wasn’t loaded properly or the wrapper doesn't
  /// recognize this value.
  unknown,
}

/// Possible error codes raised while loading or playing ads.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Enums/IMAErrorCode.html.
enum AdErrorCode {
  /// The ad slot is not visible on the page.
  adslotNotVisible,

  /// Generic invalid usage of the API.
  apiError,

  /// A companion ad failed to load or render.
  companionAdLoadingFailed,

  /// Content playhead was not passed in, but list of ads has been returned from
  /// the server.
  contentPlayheadMissing,

  /// There was an error loading the ad.
  failedLoadingAd,

  /// There was a problem requesting ads from the server.
  failedToRequestAds,

  /// Invalid arguments were provided to SDK methods.
  invalidArguments,

  /// The version of the runtime is too old.
  osRuntimeTooOld,

  /// Ads list response was malformed.
  playlistMalformedResponse,

  /// Listener for at least one of the required vast events was not added.
  requiredListenersNotAdded,

  /// There was an error initializing the stream.
  streamInitializationFailed,

  /// An unexpected error occurred and the cause is not known.
  unknownError,

  /// No assets were found in the VAST ad response.
  vastAssetNotFound,

  /// A VAST response containing a single `<VAST>` tag with no child tags.
  vastEmptyResponse,

  /// At least one VAST wrapper loaded and a subsequent wrapper or inline ad
  /// load has resulted in a 404 response code.
  vastInvalidUrl,

  /// Assets were found in the VAST ad response for a linear ad, but none of
  /// them matched the video player's capabilities.
  vastLinearAssetMismatch,

  /// The VAST URI provided, or a VAST URI provided in a subsequent Wrapper
  /// element, was either unavailable or reached a timeout, as defined by the
  /// video player.
  vastLoadTimeout,

  /// The ad response was not recognized as a valid VAST ad.
  vastMalformedResponse,

  /// Failed to load media assets from a VAST response.
  vastMediaLoadTimeout,

  /// The maximum number of VAST wrapper redirects has been reached.
  vastTooManyRedirects,

  /// Trafficking error.
  ///
  /// Video player received an ad type that it was not expecting and/or cannot
  /// display.
  vastTraffickingError,

  /// Another VideoAdsManager is still using the video.
  videoElementUsed,

  /// A video element was not specified where it was required.
  videoElementRequired,

  /// There was an error playing the video ad.
  videoPlayError,
}

/// Different event types sent by the IMAAdsManager to its delegate.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Enums/IMAAdEventType.html.
enum AdEventType {
  /// Fired the first time each ad break ends.
  adBreakEnded,

  /// Fired when an ad break will not play back any ads.
  adBreakFetchError,

  /// Fired when an ad break is ready.
  adBreakReady,

  /// Fired first time each ad break begins playback.
  adBreakStarted,

  /// Fired every time the stream switches from advertising or slate to content.
  adPeriodEnded,

  /// Fired every time the stream switches from content to advertising or slate.
  adPeriodStarted,

  /// All valid ads managed by the ads manager have completed or the ad response
  /// did not return any valid ads.
  allAdsCompleted,

  /// Fired when an ad is clicked.
  clicked,

  /// Single ad has finished.
  completed,

  /// Cuepoints changed for VOD stream (only used for dynamic ad insertion).
  cuepointsChanged,

  /// First quartile of a linear ad was reached.
  firstQuartile,

  /// The user has closed the icon fallback image dialog.
  iconFallbackImageClosed,

  /// The user has tapped an ad icon.
  iconTapped,

  /// An ad was loaded.
  loaded,

  /// A log event for the ads being played.
  log,

  /// Midpoint of a linear ad was reached.
  midpoint,

  /// Ad paused.
  pause,

  /// Ad resumed.
  resume,

  /// Fired when an ad was skipped.
  skipped,

  /// Fired when an ad starts playing.
  started,

  /// Stream request has loaded (only used for dynamic ad insertion).
  streamLoaded,

  /// Stream has started playing (only used for dynamic ad insertion).
  streamStarted,

  /// Ad tapped.
  tapped,

  /// Third quartile of a linear ad was reached..
  thirdQuartile,

  /// The event type is not recognized by this wrapper.
  unknown,
}

/// The `IMAAdDisplayContainer` is responsible for managing the ad container
/// view and companion ad slots used for ad playback.
///
/// See https://developers.google.com/ad-manager/dynamic-ad-insertion/sdk/ios/reference/Classes/IMAAdDisplayContainer.
@ProxyApi(
  swiftOptions: SwiftProxyApiOptions(import: 'GoogleInteractiveMediaAds'),
)
abstract class IMAAdDisplayContainer {
  IMAAdDisplayContainer(
    UIView adContainer,
    UIViewController? adContainerViewController,
  );
}

/// An object that manages the content for a rectangular area on the screen.
///
/// See https://developer.apple.com/documentation/uikit/uiview.
@ProxyApi(swiftOptions: SwiftProxyApiOptions(import: 'UIKit'))
abstract class UIView {}

/// An object that manages a view hierarchy for your UIKit app.
///
/// See. https://developer.apple.com/documentation/uikit/uiviewcontroller.
@ProxyApi()
abstract class UIViewController {
  UIViewController();

  /// Retrieves the view that the controller manages.
  ///
  /// For convenience this is a `final` attached field despite this being
  /// settable. Since this is not a part of the IMA SDK this is slightly changed
  /// for convenience. Note that this wrapper should not add the ability to set
  /// this property as it should not be needed anyways.
  @attached
  late final UIView view;
}

/// Defines an interface for a class that tracks video content progress and
/// exposes a key value observable property |currentTime|.
///
/// See https://developers.google.com/ad-manager/dynamic-ad-insertion/sdk/ios/reference/Protocols/IMAContentPlayhead.
@ProxyApi()
abstract class IMAContentPlayhead {
  IMAContentPlayhead();

  /// Reflects the current playback time in seconds for the content.
  void setCurrentTime(double timeInterval);
}

/// Allows the requesting of ads from the ad server.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Classes/IMAAdsLoader.
@ProxyApi()
abstract class IMAAdsLoader {
  IMAAdsLoader(IMASettings? settings);

  /// Signal to the SDK that the content has completed.
  void contentComplete();

  /// Request ads from the ad server.
  void requestAds(IMAAdsRequest request);

  /// Delegate that receives `IMAAdsLoaderDelegate` callbacks.
  ///
  /// Note that this sets to a `weak` property in Swift.
  void setDelegate(IMAAdsLoaderDelegate? delegate);
}

/// The IMASettings class stores SDK wide settings.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Classes/IMASettings.html.
@ProxyApi()
abstract class IMASettings {}

/// Data class describing the ad request.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Classes/IMAAdsRequest.
@ProxyApi()
abstract class IMAAdsRequest {
  /// Initializes an ads request instance with the given ad tag URL and ad
  /// display container.
  IMAAdsRequest(
    String adTagUrl,
    IMAAdDisplayContainer adDisplayContainer,
    IMAContentPlayhead? contentPlayhead,
  );
}

/// Delegate object that receives state change callbacks from `IMAAdsLoader`.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Protocols/IMAAdsLoaderDelegate.html.
@ProxyApi()
abstract class IMAAdsLoaderDelegate {
  IMAAdsLoaderDelegate();

  /// Called when ads are successfully loaded from the ad servers by the loader.
  late final void Function(
    IMAAdsLoader loader,
    IMAAdsLoadedData adsLoadedData,
  ) adLoaderLoadedWith;

  /// Error reported by the ads loader when loading or requesting an ad fails.
  late final void Function(
    IMAAdsLoader loader,
    IMAAdLoadingErrorData adErrorData,
  ) adsLoaderFailedWithErrorData;
}

/// Ad data that is returned when the ads loader loads the ad.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Classes/IMAAdsLoadedData.html.
@ProxyApi()
abstract class IMAAdsLoadedData {
  /// The ads manager instance created by the ads loader.
  ///
  /// Will be null when using dynamic ad insertion.
  IMAAdsManager? adsManager;
}

/// Ad error data that is returned when the ads loader fails to load the ad.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Classes/IMAAdLoadingErrorData.html.
@ProxyApi()
abstract class IMAAdLoadingErrorData {
  /// The ad error that occurred while loading the ad.
  late final IMAAdError adError;
}

/// Surfaces an error that occurred during ad loading or playing.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Classes/IMAAdError.html.
@ProxyApi()
abstract class IMAAdError {
  /// The type of error that occurred during ad loading or ad playing.
  late final AdErrorType type;

  /// The error code for obtaining more specific information about the error.
  late final AdErrorCode code;

  /// A brief description about the error.
  late final String? message;
}

/// Responsible for playing ads.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Classes/IMAAdsManager.html.
@ProxyApi()
abstract class IMAAdsManager {
  /// The `IMAAdsManagerDelegate` to notify with events during ad playback.
  void setDelegate(IMAAdsManagerDelegate? delegate);

  /// Initializes and loads the ad.
  void initialize(IMAAdsRenderingSettings? adsRenderingSettings);

  /// Starts advertisement playback.
  void start();

  /// Causes the ads manager to stop the ad and clean its internal state.
  void destroy();
}

/// A callback protocol for IMAAdsManager.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Protocols/IMAAdsManagerDelegate.html.
@ProxyApi()
abstract class IMAAdsManagerDelegate {
  IMAAdsManagerDelegate();

  /// Called when there is an IMAAdEvent.
  late final void Function(
    IMAAdsManager adsManager,
    IMAAdEvent event,
  ) didReceiveAdEvent;

  /// Called when there was an error playing the ad.
  late final void Function(
    IMAAdsManager adsManager,
    IMAAdError error,
  ) didReceiveAdError;

  /// Called when an ad is ready to play.
  late final void Function(IMAAdsManager adsManager) didRequestContentPause;

  /// Called when an ad has finished or an error occurred during the playback.
  late final void Function(IMAAdsManager adsManager) didRequestContentResume;
}

/// Simple data class used to transport ad playback information.
///
/// See https://developers.google.com/interactive-media-ads/docs/sdks/ios/client-side/reference/Classes/IMAAdEvent.html.
@ProxyApi()
abstract class IMAAdEvent {
  /// Type of the event.
  late final AdEventType type;

  /// Stringified type of the event.
  late final String typeString;
}

/// Set of properties that influence how ads are rendered.
@ProxyApi()
abstract class IMAAdsRenderingSettings {
  IMAAdsRenderingSettings();
}
