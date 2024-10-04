// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.4.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class FVPCreationOptions;

@interface FVPCreationOptions : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithAsset:(nullable NSString *)asset
                          uri:(nullable NSString *)uri
                  packageName:(nullable NSString *)packageName
                   formatHint:(nullable NSString *)formatHint
                  httpHeaders:(NSDictionary<NSString *, NSString *> *)httpHeaders;
@property(nonatomic, copy, nullable) NSString *asset;
@property(nonatomic, copy, nullable) NSString *uri;
@property(nonatomic, copy, nullable) NSString *packageName;
@property(nonatomic, copy, nullable) NSString *formatHint;
@property(nonatomic, copy) NSDictionary<NSString *, NSString *> *httpHeaders;
@end

/// The codec used by all APIs.
NSObject<FlutterMessageCodec> *FVPGetMessagesCodec(void);

@protocol FVPAVFoundationVideoPlayerApi
- (void)initialize:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)createWithOptions:(FVPCreationOptions *)creationOptions
                                   error:(FlutterError *_Nullable *_Nonnull)error;
- (void)disposePlayer:(NSInteger)textureId error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setLooping:(BOOL)isLooping
         forPlayer:(NSInteger)textureId
             error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setVolume:(double)volume
        forPlayer:(NSInteger)textureId
            error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setPlaybackSpeed:(double)speed
               forPlayer:(NSInteger)textureId
                   error:(FlutterError *_Nullable *_Nonnull)error;
- (void)playPlayer:(NSInteger)textureId error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)positionForPlayer:(NSInteger)textureId
                                   error:(FlutterError *_Nullable *_Nonnull)error;
- (void)seekTo:(NSInteger)position
     forPlayer:(NSInteger)textureId
    completion:(void (^)(FlutterError *_Nullable))completion;
- (void)pausePlayer:(NSInteger)textureId error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setMixWithOthers:(BOOL)mixWithOthers error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpFVPAVFoundationVideoPlayerApi(
    id<FlutterBinaryMessenger> binaryMessenger,
    NSObject<FVPAVFoundationVideoPlayerApi> *_Nullable api);

extern void SetUpFVPAVFoundationVideoPlayerApiWithSuffix(
    id<FlutterBinaryMessenger> binaryMessenger,
    NSObject<FVPAVFoundationVideoPlayerApi> *_Nullable api, NSString *messageChannelSuffix);

NS_ASSUME_NONNULL_END
