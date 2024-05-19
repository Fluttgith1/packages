// Mocks generated by Mockito 5.4.4 from annotations
// in interactive_media_ads/test/android/ad_display_container_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i3;

import 'package:flutter/services.dart' as _i4;
import 'package:interactive_media_ads/src/android/interactive_media_ads.g.dart'
    as _i2;
import 'package:interactive_media_ads/src/android/platform_views_service_proxy.dart'
    as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePigeonInstanceManager_0 extends _i1.SmartFake
    implements _i2.PigeonInstanceManager {
  _FakePigeonInstanceManager_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAdDisplayContainer_1 extends _i1.SmartFake
    implements _i2.AdDisplayContainer {
  _FakeAdDisplayContainer_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAdMediaInfo_2 extends _i1.SmartFake implements _i2.AdMediaInfo {
  _FakeAdMediaInfo_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAdPodInfo_3 extends _i1.SmartFake implements _i2.AdPodInfo {
  _FakeAdPodInfo_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFrameLayout_4 extends _i1.SmartFake implements _i2.FrameLayout {
  _FakeFrameLayout_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMediaPlayer_5 extends _i1.SmartFake implements _i2.MediaPlayer {
  _FakeMediaPlayer_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeVideoAdPlayer_6 extends _i1.SmartFake implements _i2.VideoAdPlayer {
  _FakeVideoAdPlayer_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeVideoAdPlayerCallback_7 extends _i1.SmartFake
    implements _i2.VideoAdPlayerCallback {
  _FakeVideoAdPlayerCallback_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeVideoView_8 extends _i1.SmartFake implements _i2.VideoView {
  _FakeVideoView_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOffset_9 extends _i1.SmartFake implements _i3.Offset {
  _FakeOffset_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSize_10 extends _i1.SmartFake implements _i3.Size {
  _FakeSize_10(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeExpensiveAndroidViewController_11 extends _i1.SmartFake
    implements _i4.ExpensiveAndroidViewController {
  _FakeExpensiveAndroidViewController_11(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSurfaceAndroidViewController_12 extends _i1.SmartFake
    implements _i4.SurfaceAndroidViewController {
  _FakeSurfaceAndroidViewController_12(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AdDisplayContainer].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdDisplayContainer extends _i1.Mock
    implements _i2.AdDisplayContainer {
  @override
  _i2.PigeonInstanceManager get pigeon_instanceManager => (super.noSuchMethod(
        Invocation.getter(#pigeon_instanceManager),
        returnValue: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
        returnValueForMissingStub: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
      ) as _i2.PigeonInstanceManager);

  @override
  _i2.AdDisplayContainer pigeon_copy() => (super.noSuchMethod(
        Invocation.method(
          #pigeon_copy,
          [],
        ),
        returnValue: _FakeAdDisplayContainer_1(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeAdDisplayContainer_1(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
      ) as _i2.AdDisplayContainer);
}

/// A class which mocks [AdMediaInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdMediaInfo extends _i1.Mock implements _i2.AdMediaInfo {
  @override
  String get url => (super.noSuchMethod(
        Invocation.getter(#url),
        returnValue: _i5.dummyValue<String>(
          this,
          Invocation.getter(#url),
        ),
        returnValueForMissingStub: _i5.dummyValue<String>(
          this,
          Invocation.getter(#url),
        ),
      ) as String);

  @override
  _i2.PigeonInstanceManager get pigeon_instanceManager => (super.noSuchMethod(
        Invocation.getter(#pigeon_instanceManager),
        returnValue: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
        returnValueForMissingStub: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
      ) as _i2.PigeonInstanceManager);

  @override
  _i2.AdMediaInfo pigeon_copy() => (super.noSuchMethod(
        Invocation.method(
          #pigeon_copy,
          [],
        ),
        returnValue: _FakeAdMediaInfo_2(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeAdMediaInfo_2(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
      ) as _i2.AdMediaInfo);
}

/// A class which mocks [AdPodInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdPodInfo extends _i1.Mock implements _i2.AdPodInfo {
  @override
  int get adPosition => (super.noSuchMethod(
        Invocation.getter(#adPosition),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  double get maxDuration => (super.noSuchMethod(
        Invocation.getter(#maxDuration),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  int get podIndex => (super.noSuchMethod(
        Invocation.getter(#podIndex),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  double get timeOffset => (super.noSuchMethod(
        Invocation.getter(#timeOffset),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  int get totalAds => (super.noSuchMethod(
        Invocation.getter(#totalAds),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  bool get isBumper => (super.noSuchMethod(
        Invocation.getter(#isBumper),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i2.PigeonInstanceManager get pigeon_instanceManager => (super.noSuchMethod(
        Invocation.getter(#pigeon_instanceManager),
        returnValue: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
        returnValueForMissingStub: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
      ) as _i2.PigeonInstanceManager);

  @override
  _i2.AdPodInfo pigeon_copy() => (super.noSuchMethod(
        Invocation.method(
          #pigeon_copy,
          [],
        ),
        returnValue: _FakeAdPodInfo_3(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeAdPodInfo_3(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
      ) as _i2.AdPodInfo);
}

/// A class which mocks [FrameLayout].
///
/// See the documentation for Mockito's code generation for more information.
class MockFrameLayout extends _i1.Mock implements _i2.FrameLayout {
  @override
  _i2.PigeonInstanceManager get pigeon_instanceManager => (super.noSuchMethod(
        Invocation.getter(#pigeon_instanceManager),
        returnValue: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
        returnValueForMissingStub: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
      ) as _i2.PigeonInstanceManager);

  @override
  _i2.FrameLayout pigeon_copy() => (super.noSuchMethod(
        Invocation.method(
          #pigeon_copy,
          [],
        ),
        returnValue: _FakeFrameLayout_4(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeFrameLayout_4(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
      ) as _i2.FrameLayout);

  @override
  _i6.Future<void> addView(_i2.View? view) => (super.noSuchMethod(
        Invocation.method(
          #addView,
          [view],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [MediaPlayer].
///
/// See the documentation for Mockito's code generation for more information.
class MockMediaPlayer extends _i1.Mock implements _i2.MediaPlayer {
  @override
  _i2.PigeonInstanceManager get pigeon_instanceManager => (super.noSuchMethod(
        Invocation.getter(#pigeon_instanceManager),
        returnValue: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
        returnValueForMissingStub: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
      ) as _i2.PigeonInstanceManager);

  @override
  _i6.Future<int> getDuration() => (super.noSuchMethod(
        Invocation.method(
          #getDuration,
          [],
        ),
        returnValue: _i6.Future<int>.value(0),
        returnValueForMissingStub: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);

  @override
  _i6.Future<void> seekTo(int? mSec) => (super.noSuchMethod(
        Invocation.method(
          #seekTo,
          [mSec],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> start() => (super.noSuchMethod(
        Invocation.method(
          #start,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> pause() => (super.noSuchMethod(
        Invocation.method(
          #pause,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> stop() => (super.noSuchMethod(
        Invocation.method(
          #stop,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i2.MediaPlayer pigeon_copy() => (super.noSuchMethod(
        Invocation.method(
          #pigeon_copy,
          [],
        ),
        returnValue: _FakeMediaPlayer_5(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeMediaPlayer_5(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
      ) as _i2.MediaPlayer);
}

/// A class which mocks [VideoAdPlayer].
///
/// See the documentation for Mockito's code generation for more information.
class MockVideoAdPlayer extends _i1.Mock implements _i2.VideoAdPlayer {
  @override
  void Function(
    _i2.VideoAdPlayer,
    _i2.VideoAdPlayerCallback,
  ) get addCallback => (super.noSuchMethod(
        Invocation.getter(#addCallback),
        returnValue: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.VideoAdPlayerCallback callback,
        ) {},
        returnValueForMissingStub: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.VideoAdPlayerCallback callback,
        ) {},
      ) as void Function(
        _i2.VideoAdPlayer,
        _i2.VideoAdPlayerCallback,
      ));

  @override
  void Function(
    _i2.VideoAdPlayer,
    _i2.AdMediaInfo,
    _i2.AdPodInfo,
  ) get loadAd => (super.noSuchMethod(
        Invocation.getter(#loadAd),
        returnValue: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.AdMediaInfo adMediaInfo,
          _i2.AdPodInfo adPodInfo,
        ) {},
        returnValueForMissingStub: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.AdMediaInfo adMediaInfo,
          _i2.AdPodInfo adPodInfo,
        ) {},
      ) as void Function(
        _i2.VideoAdPlayer,
        _i2.AdMediaInfo,
        _i2.AdPodInfo,
      ));

  @override
  void Function(
    _i2.VideoAdPlayer,
    _i2.AdMediaInfo,
  ) get pauseAd => (super.noSuchMethod(
        Invocation.getter(#pauseAd),
        returnValue: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.AdMediaInfo adMediaInfo,
        ) {},
        returnValueForMissingStub: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.AdMediaInfo adMediaInfo,
        ) {},
      ) as void Function(
        _i2.VideoAdPlayer,
        _i2.AdMediaInfo,
      ));

  @override
  void Function(
    _i2.VideoAdPlayer,
    _i2.AdMediaInfo,
  ) get playAd => (super.noSuchMethod(
        Invocation.getter(#playAd),
        returnValue: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.AdMediaInfo adMediaInfo,
        ) {},
        returnValueForMissingStub: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.AdMediaInfo adMediaInfo,
        ) {},
      ) as void Function(
        _i2.VideoAdPlayer,
        _i2.AdMediaInfo,
      ));

  @override
  void Function(_i2.VideoAdPlayer) get release => (super.noSuchMethod(
        Invocation.getter(#release),
        returnValue: (_i2.VideoAdPlayer pigeon_instance) {},
        returnValueForMissingStub: (_i2.VideoAdPlayer pigeon_instance) {},
      ) as void Function(_i2.VideoAdPlayer));

  @override
  void Function(
    _i2.VideoAdPlayer,
    _i2.VideoAdPlayerCallback,
  ) get removeCallback => (super.noSuchMethod(
        Invocation.getter(#removeCallback),
        returnValue: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.VideoAdPlayerCallback callback,
        ) {},
        returnValueForMissingStub: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.VideoAdPlayerCallback callback,
        ) {},
      ) as void Function(
        _i2.VideoAdPlayer,
        _i2.VideoAdPlayerCallback,
      ));

  @override
  void Function(
    _i2.VideoAdPlayer,
    _i2.AdMediaInfo,
  ) get stopAd => (super.noSuchMethod(
        Invocation.getter(#stopAd),
        returnValue: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.AdMediaInfo adMediaInfo,
        ) {},
        returnValueForMissingStub: (
          _i2.VideoAdPlayer pigeon_instance,
          _i2.AdMediaInfo adMediaInfo,
        ) {},
      ) as void Function(
        _i2.VideoAdPlayer,
        _i2.AdMediaInfo,
      ));

  @override
  _i2.PigeonInstanceManager get pigeon_instanceManager => (super.noSuchMethod(
        Invocation.getter(#pigeon_instanceManager),
        returnValue: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
        returnValueForMissingStub: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
      ) as _i2.PigeonInstanceManager);

  @override
  _i6.Future<void> setVolume(int? value) => (super.noSuchMethod(
        Invocation.method(
          #setVolume,
          [value],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> setAdProgress(_i2.VideoProgressUpdate? progress) =>
      (super.noSuchMethod(
        Invocation.method(
          #setAdProgress,
          [progress],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i2.VideoAdPlayer pigeon_copy() => (super.noSuchMethod(
        Invocation.method(
          #pigeon_copy,
          [],
        ),
        returnValue: _FakeVideoAdPlayer_6(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeVideoAdPlayer_6(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
      ) as _i2.VideoAdPlayer);
}

/// A class which mocks [VideoAdPlayerCallback].
///
/// See the documentation for Mockito's code generation for more information.
class MockVideoAdPlayerCallback extends _i1.Mock
    implements _i2.VideoAdPlayerCallback {
  @override
  _i2.PigeonInstanceManager get pigeon_instanceManager => (super.noSuchMethod(
        Invocation.getter(#pigeon_instanceManager),
        returnValue: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
        returnValueForMissingStub: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
      ) as _i2.PigeonInstanceManager);

  @override
  _i6.Future<void> onAdProgress(
    _i2.AdMediaInfo? adMediaInfo,
    _i2.VideoProgressUpdate? videoProgressUpdate,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onAdProgress,
          [
            adMediaInfo,
            videoProgressUpdate,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> onBuffering(_i2.AdMediaInfo? adMediaInfo) =>
      (super.noSuchMethod(
        Invocation.method(
          #onBuffering,
          [adMediaInfo],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> onContentComplete() => (super.noSuchMethod(
        Invocation.method(
          #onContentComplete,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> onEnded(_i2.AdMediaInfo? adMediaInfo) => (super.noSuchMethod(
        Invocation.method(
          #onEnded,
          [adMediaInfo],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> onError(_i2.AdMediaInfo? adMediaInfo) => (super.noSuchMethod(
        Invocation.method(
          #onError,
          [adMediaInfo],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> onLoaded(_i2.AdMediaInfo? adMediaInfo) =>
      (super.noSuchMethod(
        Invocation.method(
          #onLoaded,
          [adMediaInfo],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> onPause(_i2.AdMediaInfo? adMediaInfo) => (super.noSuchMethod(
        Invocation.method(
          #onPause,
          [adMediaInfo],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> onPlay(_i2.AdMediaInfo? adMediaInfo) => (super.noSuchMethod(
        Invocation.method(
          #onPlay,
          [adMediaInfo],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> onResume(_i2.AdMediaInfo? adMediaInfo) =>
      (super.noSuchMethod(
        Invocation.method(
          #onResume,
          [adMediaInfo],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> onVolumeChanged(
    _i2.AdMediaInfo? adMediaInfo,
    int? percentage,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onVolumeChanged,
          [
            adMediaInfo,
            percentage,
          ],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i2.VideoAdPlayerCallback pigeon_copy() => (super.noSuchMethod(
        Invocation.method(
          #pigeon_copy,
          [],
        ),
        returnValue: _FakeVideoAdPlayerCallback_7(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeVideoAdPlayerCallback_7(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
      ) as _i2.VideoAdPlayerCallback);
}

/// A class which mocks [VideoView].
///
/// See the documentation for Mockito's code generation for more information.
class MockVideoView extends _i1.Mock implements _i2.VideoView {
  @override
  void Function(
    _i2.VideoView,
    _i2.MediaPlayer,
    int,
    int,
  ) get onError => (super.noSuchMethod(
        Invocation.getter(#onError),
        returnValue: (
          _i2.VideoView pigeon_instance,
          _i2.MediaPlayer player,
          int what,
          int extra,
        ) {},
        returnValueForMissingStub: (
          _i2.VideoView pigeon_instance,
          _i2.MediaPlayer player,
          int what,
          int extra,
        ) {},
      ) as void Function(
        _i2.VideoView,
        _i2.MediaPlayer,
        int,
        int,
      ));

  @override
  _i2.PigeonInstanceManager get pigeon_instanceManager => (super.noSuchMethod(
        Invocation.getter(#pigeon_instanceManager),
        returnValue: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
        returnValueForMissingStub: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
      ) as _i2.PigeonInstanceManager);

  @override
  _i6.Future<void> setVideoUri(String? uri) => (super.noSuchMethod(
        Invocation.method(
          #setVideoUri,
          [uri],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<int> getCurrentPosition() => (super.noSuchMethod(
        Invocation.method(
          #getCurrentPosition,
          [],
        ),
        returnValue: _i6.Future<int>.value(0),
        returnValueForMissingStub: _i6.Future<int>.value(0),
      ) as _i6.Future<int>);

  @override
  _i2.VideoView pigeon_copy() => (super.noSuchMethod(
        Invocation.method(
          #pigeon_copy,
          [],
        ),
        returnValue: _FakeVideoView_8(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeVideoView_8(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
      ) as _i2.VideoView);
}

/// A class which mocks [SurfaceAndroidViewController].
///
/// See the documentation for Mockito's code generation for more information.
class MockSurfaceAndroidViewController extends _i1.Mock
    implements _i4.SurfaceAndroidViewController {
  @override
  bool get requiresViewComposition => (super.noSuchMethod(
        Invocation.getter(#requiresViewComposition),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  int get viewId => (super.noSuchMethod(
        Invocation.getter(#viewId),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);

  @override
  bool get awaitingCreation => (super.noSuchMethod(
        Invocation.getter(#awaitingCreation),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  _i4.PointTransformer get pointTransformer => (super.noSuchMethod(
        Invocation.getter(#pointTransformer),
        returnValue: (_i3.Offset position) => _FakeOffset_9(
          this,
          Invocation.getter(#pointTransformer),
        ),
        returnValueForMissingStub: (_i3.Offset position) => _FakeOffset_9(
          this,
          Invocation.getter(#pointTransformer),
        ),
      ) as _i4.PointTransformer);

  @override
  set pointTransformer(_i4.PointTransformer? transformer) => super.noSuchMethod(
        Invocation.setter(
          #pointTransformer,
          transformer,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get isCreated => (super.noSuchMethod(
        Invocation.getter(#isCreated),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  List<_i4.PlatformViewCreatedCallback> get createdCallbacks =>
      (super.noSuchMethod(
        Invocation.getter(#createdCallbacks),
        returnValue: <_i4.PlatformViewCreatedCallback>[],
        returnValueForMissingStub: <_i4.PlatformViewCreatedCallback>[],
      ) as List<_i4.PlatformViewCreatedCallback>);

  @override
  _i6.Future<void> setOffset(_i3.Offset? off) => (super.noSuchMethod(
        Invocation.method(
          #setOffset,
          [off],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> create({
    _i3.Size? size,
    _i3.Offset? position,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #create,
          [],
          {
            #size: size,
            #position: position,
          },
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i3.Size> setSize(_i3.Size? size) => (super.noSuchMethod(
        Invocation.method(
          #setSize,
          [size],
        ),
        returnValue: _i6.Future<_i3.Size>.value(_FakeSize_10(
          this,
          Invocation.method(
            #setSize,
            [size],
          ),
        )),
        returnValueForMissingStub: _i6.Future<_i3.Size>.value(_FakeSize_10(
          this,
          Invocation.method(
            #setSize,
            [size],
          ),
        )),
      ) as _i6.Future<_i3.Size>);

  @override
  _i6.Future<void> sendMotionEvent(_i4.AndroidMotionEvent? event) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendMotionEvent,
          [event],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  void addOnPlatformViewCreatedListener(
          _i4.PlatformViewCreatedCallback? listener) =>
      super.noSuchMethod(
        Invocation.method(
          #addOnPlatformViewCreatedListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeOnPlatformViewCreatedListener(
          _i4.PlatformViewCreatedCallback? listener) =>
      super.noSuchMethod(
        Invocation.method(
          #removeOnPlatformViewCreatedListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<void> setLayoutDirection(_i3.TextDirection? layoutDirection) =>
      (super.noSuchMethod(
        Invocation.method(
          #setLayoutDirection,
          [layoutDirection],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> dispatchPointerEvent(_i4.PointerEvent? event) =>
      (super.noSuchMethod(
        Invocation.method(
          #dispatchPointerEvent,
          [event],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> clearFocus() => (super.noSuchMethod(
        Invocation.method(
          #clearFocus,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [PlatformViewsServiceProxy].
///
/// See the documentation for Mockito's code generation for more information.
// ignore: must_be_immutable
class MockPlatformViewsServiceProxy extends _i1.Mock
    implements _i7.PlatformViewsServiceProxy {
  @override
  _i4.ExpensiveAndroidViewController initExpensiveAndroidView({
    required int? id,
    required String? viewType,
    required _i3.TextDirection? layoutDirection,
    dynamic creationParams,
    _i4.MessageCodec<dynamic>? creationParamsCodec,
    _i3.VoidCallback? onFocus,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #initExpensiveAndroidView,
          [],
          {
            #id: id,
            #viewType: viewType,
            #layoutDirection: layoutDirection,
            #creationParams: creationParams,
            #creationParamsCodec: creationParamsCodec,
            #onFocus: onFocus,
          },
        ),
        returnValue: _FakeExpensiveAndroidViewController_11(
          this,
          Invocation.method(
            #initExpensiveAndroidView,
            [],
            {
              #id: id,
              #viewType: viewType,
              #layoutDirection: layoutDirection,
              #creationParams: creationParams,
              #creationParamsCodec: creationParamsCodec,
              #onFocus: onFocus,
            },
          ),
        ),
        returnValueForMissingStub: _FakeExpensiveAndroidViewController_11(
          this,
          Invocation.method(
            #initExpensiveAndroidView,
            [],
            {
              #id: id,
              #viewType: viewType,
              #layoutDirection: layoutDirection,
              #creationParams: creationParams,
              #creationParamsCodec: creationParamsCodec,
              #onFocus: onFocus,
            },
          ),
        ),
      ) as _i4.ExpensiveAndroidViewController);

  @override
  _i4.SurfaceAndroidViewController initSurfaceAndroidView({
    required int? id,
    required String? viewType,
    required _i3.TextDirection? layoutDirection,
    dynamic creationParams,
    _i4.MessageCodec<dynamic>? creationParamsCodec,
    _i3.VoidCallback? onFocus,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #initSurfaceAndroidView,
          [],
          {
            #id: id,
            #viewType: viewType,
            #layoutDirection: layoutDirection,
            #creationParams: creationParams,
            #creationParamsCodec: creationParamsCodec,
            #onFocus: onFocus,
          },
        ),
        returnValue: _FakeSurfaceAndroidViewController_12(
          this,
          Invocation.method(
            #initSurfaceAndroidView,
            [],
            {
              #id: id,
              #viewType: viewType,
              #layoutDirection: layoutDirection,
              #creationParams: creationParams,
              #creationParamsCodec: creationParamsCodec,
              #onFocus: onFocus,
            },
          ),
        ),
        returnValueForMissingStub: _FakeSurfaceAndroidViewController_12(
          this,
          Invocation.method(
            #initSurfaceAndroidView,
            [],
            {
              #id: id,
              #viewType: viewType,
              #layoutDirection: layoutDirection,
              #creationParams: creationParams,
              #creationParamsCodec: creationParamsCodec,
              #onFocus: onFocus,
            },
          ),
        ),
      ) as _i4.SurfaceAndroidViewController);
}
