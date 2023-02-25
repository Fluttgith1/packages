// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v8.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "messages.g.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@interface FLTTextureMessage ()
+ (FLTTextureMessage *)fromList:(NSArray *)list;
+ (nullable FLTTextureMessage *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTLoopingMessage ()
+ (FLTLoopingMessage *)fromList:(NSArray *)list;
+ (nullable FLTLoopingMessage *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTVolumeMessage ()
+ (FLTVolumeMessage *)fromList:(NSArray *)list;
+ (nullable FLTVolumeMessage *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTPlaybackSpeedMessage ()
+ (FLTPlaybackSpeedMessage *)fromList:(NSArray *)list;
+ (nullable FLTPlaybackSpeedMessage *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTPositionMessage ()
+ (FLTPositionMessage *)fromList:(NSArray *)list;
+ (nullable FLTPositionMessage *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTCreateMessage ()
+ (FLTCreateMessage *)fromList:(NSArray *)list;
+ (nullable FLTCreateMessage *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTMixWithOthersMessage ()
+ (FLTMixWithOthersMessage *)fromList:(NSArray *)list;
+ (nullable FLTMixWithOthersMessage *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@implementation FLTTextureMessage
+ (instancetype)makeWithTextureId:(NSNumber *)textureId {
  FLTTextureMessage *pigeonResult = [[FLTTextureMessage alloc] init];
  pigeonResult.textureId = textureId;
  return pigeonResult;
}
+ (FLTTextureMessage *)fromList:(NSArray *)list {
  FLTTextureMessage *pigeonResult = [[FLTTextureMessage alloc] init];
  pigeonResult.textureId = GetNullableObjectAtIndex(list, 0);
  NSAssert(pigeonResult.textureId != nil, @"");
  return pigeonResult;
}
+ (nullable FLTTextureMessage *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTTextureMessage fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.textureId ?: [NSNull null]),
  ];
}
@end

@implementation FLTLoopingMessage
+ (instancetype)makeWithTextureId:(NSNumber *)textureId isLooping:(NSNumber *)isLooping {
  FLTLoopingMessage *pigeonResult = [[FLTLoopingMessage alloc] init];
  pigeonResult.textureId = textureId;
  pigeonResult.isLooping = isLooping;
  return pigeonResult;
}
+ (FLTLoopingMessage *)fromList:(NSArray *)list {
  FLTLoopingMessage *pigeonResult = [[FLTLoopingMessage alloc] init];
  pigeonResult.textureId = GetNullableObjectAtIndex(list, 0);
  NSAssert(pigeonResult.textureId != nil, @"");
  pigeonResult.isLooping = GetNullableObjectAtIndex(list, 1);
  NSAssert(pigeonResult.isLooping != nil, @"");
  return pigeonResult;
}
+ (nullable FLTLoopingMessage *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTLoopingMessage fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.textureId ?: [NSNull null]),
    (self.isLooping ?: [NSNull null]),
  ];
}
@end

@implementation FLTVolumeMessage
+ (instancetype)makeWithTextureId:(NSNumber *)textureId volume:(NSNumber *)volume {
  FLTVolumeMessage *pigeonResult = [[FLTVolumeMessage alloc] init];
  pigeonResult.textureId = textureId;
  pigeonResult.volume = volume;
  return pigeonResult;
}
+ (FLTVolumeMessage *)fromList:(NSArray *)list {
  FLTVolumeMessage *pigeonResult = [[FLTVolumeMessage alloc] init];
  pigeonResult.textureId = GetNullableObjectAtIndex(list, 0);
  NSAssert(pigeonResult.textureId != nil, @"");
  pigeonResult.volume = GetNullableObjectAtIndex(list, 1);
  NSAssert(pigeonResult.volume != nil, @"");
  return pigeonResult;
}
+ (nullable FLTVolumeMessage *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTVolumeMessage fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.textureId ?: [NSNull null]),
    (self.volume ?: [NSNull null]),
  ];
}
@end

@implementation FLTPlaybackSpeedMessage
+ (instancetype)makeWithTextureId:(NSNumber *)textureId speed:(NSNumber *)speed {
  FLTPlaybackSpeedMessage *pigeonResult = [[FLTPlaybackSpeedMessage alloc] init];
  pigeonResult.textureId = textureId;
  pigeonResult.speed = speed;
  return pigeonResult;
}
+ (FLTPlaybackSpeedMessage *)fromList:(NSArray *)list {
  FLTPlaybackSpeedMessage *pigeonResult = [[FLTPlaybackSpeedMessage alloc] init];
  pigeonResult.textureId = GetNullableObjectAtIndex(list, 0);
  NSAssert(pigeonResult.textureId != nil, @"");
  pigeonResult.speed = GetNullableObjectAtIndex(list, 1);
  NSAssert(pigeonResult.speed != nil, @"");
  return pigeonResult;
}
+ (nullable FLTPlaybackSpeedMessage *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTPlaybackSpeedMessage fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.textureId ?: [NSNull null]),
    (self.speed ?: [NSNull null]),
  ];
}
@end

@implementation FLTPositionMessage
+ (instancetype)makeWithTextureId:(NSNumber *)textureId position:(NSNumber *)position {
  FLTPositionMessage *pigeonResult = [[FLTPositionMessage alloc] init];
  pigeonResult.textureId = textureId;
  pigeonResult.position = position;
  return pigeonResult;
}
+ (FLTPositionMessage *)fromList:(NSArray *)list {
  FLTPositionMessage *pigeonResult = [[FLTPositionMessage alloc] init];
  pigeonResult.textureId = GetNullableObjectAtIndex(list, 0);
  NSAssert(pigeonResult.textureId != nil, @"");
  pigeonResult.position = GetNullableObjectAtIndex(list, 1);
  NSAssert(pigeonResult.position != nil, @"");
  return pigeonResult;
}
+ (nullable FLTPositionMessage *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTPositionMessage fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.textureId ?: [NSNull null]),
    (self.position ?: [NSNull null]),
  ];
}
@end

@implementation FLTCreateMessage
+ (instancetype)makeWithAsset:(nullable NSString *)asset
                          uri:(nullable NSString *)uri
                  packageName:(nullable NSString *)packageName
                   formatHint:(nullable NSString *)formatHint
                  httpHeaders:(NSDictionary<NSString *, NSString *> *)httpHeaders {
  FLTCreateMessage *pigeonResult = [[FLTCreateMessage alloc] init];
  pigeonResult.asset = asset;
  pigeonResult.uri = uri;
  pigeonResult.packageName = packageName;
  pigeonResult.formatHint = formatHint;
  pigeonResult.httpHeaders = httpHeaders;
  return pigeonResult;
}
+ (FLTCreateMessage *)fromList:(NSArray *)list {
  FLTCreateMessage *pigeonResult = [[FLTCreateMessage alloc] init];
  pigeonResult.asset = GetNullableObjectAtIndex(list, 0);
  pigeonResult.uri = GetNullableObjectAtIndex(list, 1);
  pigeonResult.packageName = GetNullableObjectAtIndex(list, 2);
  pigeonResult.formatHint = GetNullableObjectAtIndex(list, 3);
  pigeonResult.httpHeaders = GetNullableObjectAtIndex(list, 4);
  NSAssert(pigeonResult.httpHeaders != nil, @"");
  return pigeonResult;
}
+ (nullable FLTCreateMessage *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTCreateMessage fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.asset ?: [NSNull null]),
    (self.uri ?: [NSNull null]),
    (self.packageName ?: [NSNull null]),
    (self.formatHint ?: [NSNull null]),
    (self.httpHeaders ?: [NSNull null]),
  ];
}
@end

@implementation FLTMixWithOthersMessage
+ (instancetype)makeWithMixWithOthers:(NSNumber *)mixWithOthers {
  FLTMixWithOthersMessage *pigeonResult = [[FLTMixWithOthersMessage alloc] init];
  pigeonResult.mixWithOthers = mixWithOthers;
  return pigeonResult;
}
+ (FLTMixWithOthersMessage *)fromList:(NSArray *)list {
  FLTMixWithOthersMessage *pigeonResult = [[FLTMixWithOthersMessage alloc] init];
  pigeonResult.mixWithOthers = GetNullableObjectAtIndex(list, 0);
  NSAssert(pigeonResult.mixWithOthers != nil, @"");
  return pigeonResult;
}
+ (nullable FLTMixWithOthersMessage *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTMixWithOthersMessage fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.mixWithOthers ?: [NSNull null]),
  ];
}
@end

@interface FLTAVFoundationVideoPlayerApiCodecReader : FlutterStandardReader
@end
@implementation FLTAVFoundationVideoPlayerApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128:
      return [FLTCreateMessage fromList:[self readValue]];
    case 129:
      return [FLTLoopingMessage fromList:[self readValue]];
    case 130:
      return [FLTMixWithOthersMessage fromList:[self readValue]];
    case 131:
      return [FLTPlaybackSpeedMessage fromList:[self readValue]];
    case 132:
      return [FLTPositionMessage fromList:[self readValue]];
    case 133:
      return [FLTTextureMessage fromList:[self readValue]];
    case 134:
      return [FLTVolumeMessage fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface FLTAVFoundationVideoPlayerApiCodecWriter : FlutterStandardWriter
@end
@implementation FLTAVFoundationVideoPlayerApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[FLTCreateMessage class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTLoopingMessage class]]) {
    [self writeByte:129];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTMixWithOthersMessage class]]) {
    [self writeByte:130];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTPlaybackSpeedMessage class]]) {
    [self writeByte:131];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTPositionMessage class]]) {
    [self writeByte:132];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTTextureMessage class]]) {
    [self writeByte:133];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTVolumeMessage class]]) {
    [self writeByte:134];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface FLTAVFoundationVideoPlayerApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTAVFoundationVideoPlayerApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTAVFoundationVideoPlayerApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTAVFoundationVideoPlayerApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTAVFoundationVideoPlayerApiGetCodec() {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    FLTAVFoundationVideoPlayerApiCodecReaderWriter *readerWriter =
        [[FLTAVFoundationVideoPlayerApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void FLTAVFoundationVideoPlayerApiSetup(id<FlutterBinaryMessenger> binaryMessenger,
                                        NSObject<FLTAVFoundationVideoPlayerApi> *api) {
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.initialize"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(initialize:)],
                @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(initialize:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api initialize:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.create"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(create:error:)],
          @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(create:error:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTCreateMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        FLTTextureMessage *output = [api create:arg_msg error:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.dispose"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(dispose:error:)],
          @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(dispose:error:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTTextureMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api dispose:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.setLooping"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(setLooping:error:)],
          @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(setLooping:error:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTLoopingMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setLooping:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.setVolume"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(setVolume:error:)],
          @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(setVolume:error:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTVolumeMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setVolume:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.setPlaybackSpeed"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setPlaybackSpeed:error:)],
                @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to "
                @"@selector(setPlaybackSpeed:error:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTPlaybackSpeedMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setPlaybackSpeed:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.play"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(play:error:)],
                @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(play:error:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTTextureMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api play:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.position"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(position:error:)],
          @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(position:error:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTTextureMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        FLTPositionMessage *output = [api position:arg_msg error:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.seekTo"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(seekTo:error:)],
          @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(seekTo:error:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTPositionMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api seekTo:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.pause"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(pause:error:)],
          @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(pause:error:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTTextureMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api pause:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.AVFoundationVideoPlayerApi.setMixWithOthers"
        binaryMessenger:binaryMessenger
                  codec:FLTAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setMixWithOthers:error:)],
                @"FLTAVFoundationVideoPlayerApi api (%@) doesn't respond to "
                @"@selector(setMixWithOthers:error:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTMixWithOthersMessage *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setMixWithOthers:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
