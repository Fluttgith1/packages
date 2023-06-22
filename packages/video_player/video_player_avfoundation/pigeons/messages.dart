// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartTestOut: 'test/test_api.g.dart',
  objcHeaderOut: 'ios/Classes/messages.g.h',
  objcSourceOut: 'ios/Classes/messages.g.m',
  objcOptions: ObjcOptions(
    prefix: 'FLT',
  ),
  copyrightHeader: 'pigeons/copyright.txt',
))
class TextureMessage {
  TextureMessage(this.textureId);
  int textureId;
}

class CacheMessage {
  CacheMessage(this.can);
  bool can;
}

class LoopingMessage {
  LoopingMessage(this.textureId, this.isLooping);
  int textureId;
  bool isLooping;
}

class IsSupportedMessage {
  IsSupportedMessage(this.isSupported);
  bool isSupported;
}

class IsCachingSupportedMessage {
  IsCachingSupportedMessage(this.url);
  String url;
}

class VolumeMessage {
  VolumeMessage(this.textureId, this.volume);
  int textureId;
  double volume;
}

class ClearCacheMessage {
  ClearCacheMessage(this.textureId);
  int textureId;
}

class PlaybackSpeedMessage {
  PlaybackSpeedMessage(this.textureId, this.speed);
  int textureId;
  double speed;
}

class PositionMessage {
  PositionMessage(this.textureId, this.position);
  int textureId;
  int position;
}

class CreateMessage {
  CreateMessage({required this.httpHeaders, required this.cache});
  String? asset;
  String? uri;
  String? packageName;
  String? formatHint;
  bool? cache;
  Map<String?, String?> httpHeaders;
}

class MixWithOthersMessage {
  MixWithOthersMessage(this.mixWithOthers);
  bool mixWithOthers;
}

@HostApi(dartHostTestHandler: 'TestHostVideoPlayerApi')
abstract class AVFoundationVideoPlayerApi {
  @ObjCSelector('initialize')
  void initialize();
  @ObjCSelector('create:')
  TextureMessage create(CreateMessage msg);
  @ObjCSelector('dispose:')
  void dispose(TextureMessage msg);
  @ObjCSelector('setLooping:')
  void setLooping(LoopingMessage msg);
  @ObjCSelector('clearCache:')
  void clearCache(ClearCacheMessage msg);
  @ObjCSelector('setVolume:')
  void setVolume(VolumeMessage msg);
  @ObjCSelector('isCacheSupportedForNetworkMedia:')
  IsSupportedMessage isCacheSupportedForNetworkMedia(
      IsCachingSupportedMessage msg);
  @ObjCSelector('setPlaybackSpeed:')
  void setPlaybackSpeed(PlaybackSpeedMessage msg);
  @ObjCSelector('play:')
  void play(TextureMessage msg);
  @ObjCSelector('position:')
  PositionMessage position(TextureMessage msg);
  @async
  @ObjCSelector('seekTo:')
  void seekTo(PositionMessage msg);
  @ObjCSelector('pause:')
  void pause(TextureMessage msg);
  @ObjCSelector('setMixWithOthers:')
  void setMixWithOthers(MixWithOthersMessage msg);
}
