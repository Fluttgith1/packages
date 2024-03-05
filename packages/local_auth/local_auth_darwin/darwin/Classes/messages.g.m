// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v13.1.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "messages.g.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

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

/// Possible outcomes of an authentication attempt.
@implementation FLADAuthResultBox
- (instancetype)initWithValue:(FLADAuthResult)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

/// Pigeon equivalent of the subset of BiometricType used by iOS & macOS.
@implementation FLADAuthBiometricBox
- (instancetype)initWithValue:(FLADAuthBiometric)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

@interface FLADAuthStrings ()
+ (FLADAuthStrings *)fromList:(NSArray *)list;
+ (nullable FLADAuthStrings *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLADAuthOptions ()
+ (FLADAuthOptions *)fromList:(NSArray *)list;
+ (nullable FLADAuthOptions *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLADAuthResultDetails ()
+ (FLADAuthResultDetails *)fromList:(NSArray *)list;
+ (nullable FLADAuthResultDetails *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLADAuthBiometricWrapper ()
+ (FLADAuthBiometricWrapper *)fromList:(NSArray *)list;
+ (nullable FLADAuthBiometricWrapper *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@implementation FLADAuthStrings
+ (instancetype)makeWithReason:(NSString *)reason
                       lockOut:(NSString *)lockOut
            goToSettingsButton:(NSString *)goToSettingsButton
       goToSettingsDescription:(NSString *)goToSettingsDescription
                  cancelButton:(NSString *)cancelButton
        localizedFallbackTitle:(nullable NSString *)localizedFallbackTitle {
  FLADAuthStrings *pigeonResult = [[FLADAuthStrings alloc] init];
  pigeonResult.reason = reason;
  pigeonResult.lockOut = lockOut;
  pigeonResult.goToSettingsButton = goToSettingsButton;
  pigeonResult.goToSettingsDescription = goToSettingsDescription;
  pigeonResult.cancelButton = cancelButton;
  pigeonResult.localizedFallbackTitle = localizedFallbackTitle;
  return pigeonResult;
}
+ (FLADAuthStrings *)fromList:(NSArray *)list {
  FLADAuthStrings *pigeonResult = [[FLADAuthStrings alloc] init];
  pigeonResult.reason = GetNullableObjectAtIndex(list, 0);
  pigeonResult.lockOut = GetNullableObjectAtIndex(list, 1);
  pigeonResult.goToSettingsButton = GetNullableObjectAtIndex(list, 2);
  pigeonResult.goToSettingsDescription = GetNullableObjectAtIndex(list, 3);
  pigeonResult.cancelButton = GetNullableObjectAtIndex(list, 4);
  pigeonResult.localizedFallbackTitle = GetNullableObjectAtIndex(list, 5);
  return pigeonResult;
}
+ (nullable FLADAuthStrings *)nullableFromList:(NSArray *)list {
  return (list) ? [FLADAuthStrings fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    self.reason ?: [NSNull null],
    self.lockOut ?: [NSNull null],
    self.goToSettingsButton ?: [NSNull null],
    self.goToSettingsDescription ?: [NSNull null],
    self.cancelButton ?: [NSNull null],
    self.localizedFallbackTitle ?: [NSNull null],
  ];
}
@end

@implementation FLADAuthOptions
+ (instancetype)makeWithBiometricOnly:(BOOL)biometricOnly
                               sticky:(BOOL)sticky
                      useErrorDialogs:(BOOL)useErrorDialogs {
  FLADAuthOptions *pigeonResult = [[FLADAuthOptions alloc] init];
  pigeonResult.biometricOnly = biometricOnly;
  pigeonResult.sticky = sticky;
  pigeonResult.useErrorDialogs = useErrorDialogs;
  return pigeonResult;
}
+ (FLADAuthOptions *)fromList:(NSArray *)list {
  FLADAuthOptions *pigeonResult = [[FLADAuthOptions alloc] init];
  pigeonResult.biometricOnly = [GetNullableObjectAtIndex(list, 0) boolValue];
  pigeonResult.sticky = [GetNullableObjectAtIndex(list, 1) boolValue];
  pigeonResult.useErrorDialogs = [GetNullableObjectAtIndex(list, 2) boolValue];
  return pigeonResult;
}
+ (nullable FLADAuthOptions *)nullableFromList:(NSArray *)list {
  return (list) ? [FLADAuthOptions fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    @(self.biometricOnly),
    @(self.sticky),
    @(self.useErrorDialogs),
  ];
}
@end

@implementation FLADAuthResultDetails
+ (instancetype)makeWithResult:(FLADAuthResult)result
                  errorMessage:(nullable NSString *)errorMessage
                  errorDetails:(nullable NSString *)errorDetails {
  FLADAuthResultDetails *pigeonResult = [[FLADAuthResultDetails alloc] init];
  pigeonResult.result = result;
  pigeonResult.errorMessage = errorMessage;
  pigeonResult.errorDetails = errorDetails;
  return pigeonResult;
}
+ (FLADAuthResultDetails *)fromList:(NSArray *)list {
  FLADAuthResultDetails *pigeonResult = [[FLADAuthResultDetails alloc] init];
  pigeonResult.result = [GetNullableObjectAtIndex(list, 0) integerValue];
  pigeonResult.errorMessage = GetNullableObjectAtIndex(list, 1);
  pigeonResult.errorDetails = GetNullableObjectAtIndex(list, 2);
  return pigeonResult;
}
+ (nullable FLADAuthResultDetails *)nullableFromList:(NSArray *)list {
  return (list) ? [FLADAuthResultDetails fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    @(self.result),
    self.errorMessage ?: [NSNull null],
    self.errorDetails ?: [NSNull null],
  ];
}
@end

@implementation FLADAuthBiometricWrapper
+ (instancetype)makeWithValue:(FLADAuthBiometric)value {
  FLADAuthBiometricWrapper *pigeonResult = [[FLADAuthBiometricWrapper alloc] init];
  pigeonResult.value = value;
  return pigeonResult;
}
+ (FLADAuthBiometricWrapper *)fromList:(NSArray *)list {
  FLADAuthBiometricWrapper *pigeonResult = [[FLADAuthBiometricWrapper alloc] init];
  pigeonResult.value = [GetNullableObjectAtIndex(list, 0) integerValue];
  return pigeonResult;
}
+ (nullable FLADAuthBiometricWrapper *)nullableFromList:(NSArray *)list {
  return (list) ? [FLADAuthBiometricWrapper fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    @(self.value),
  ];
}
@end

@interface FLADLocalAuthApiCodecReader : FlutterStandardReader
@end
@implementation FLADLocalAuthApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128:
      return [FLADAuthBiometricWrapper fromList:[self readValue]];
    case 129:
      return [FLADAuthOptions fromList:[self readValue]];
    case 130:
      return [FLADAuthResultDetails fromList:[self readValue]];
    case 131:
      return [FLADAuthStrings fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface FLADLocalAuthApiCodecWriter : FlutterStandardWriter
@end
@implementation FLADLocalAuthApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[FLADAuthBiometricWrapper class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLADAuthOptions class]]) {
    [self writeByte:129];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLADAuthResultDetails class]]) {
    [self writeByte:130];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLADAuthStrings class]]) {
    [self writeByte:131];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface FLADLocalAuthApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLADLocalAuthApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLADLocalAuthApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLADLocalAuthApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLADLocalAuthApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    FLADLocalAuthApiCodecReaderWriter *readerWriter =
        [[FLADLocalAuthApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void SetUpFLADLocalAuthApi(id<FlutterBinaryMessenger> binaryMessenger,
                           NSObject<FLADLocalAuthApi> *api) {
  /// Returns true if this device supports authentication.
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.local_auth_darwin.LocalAuthApi.isDeviceSupported"
        binaryMessenger:binaryMessenger
                  codec:FLADLocalAuthApiGetCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(isDeviceSupportedWithError:)],
          @"FLADLocalAuthApi api (%@) doesn't respond to @selector(isDeviceSupportedWithError:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api isDeviceSupportedWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// Returns true if this device can support biometric authentication, whether
  /// any biometrics are enrolled or not.
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:
               @"dev.flutter.pigeon.local_auth_darwin.LocalAuthApi.deviceCanSupportBiometrics"
        binaryMessenger:binaryMessenger
                  codec:FLADLocalAuthApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(deviceCanSupportBiometricsWithError:)],
                @"FLADLocalAuthApi api (%@) doesn't respond to "
                @"@selector(deviceCanSupportBiometricsWithError:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api deviceCanSupportBiometricsWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// Returns the biometric types that are enrolled, and can thus be used
  /// without additional setup.
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.local_auth_darwin.LocalAuthApi.getEnrolledBiometrics"
        binaryMessenger:binaryMessenger
                  codec:FLADLocalAuthApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getEnrolledBiometricsWithError:)],
                @"FLADLocalAuthApi api (%@) doesn't respond to "
                @"@selector(getEnrolledBiometricsWithError:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSArray<FLADAuthBiometricWrapper *> *output = [api getEnrolledBiometricsWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// Attempts to authenticate the user with the provided [options], and using
  /// [strings] for any UI.
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:@"dev.flutter.pigeon.local_auth_darwin.LocalAuthApi.authenticate"
        binaryMessenger:binaryMessenger
                  codec:FLADLocalAuthApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(authenticateWithOptions:strings:completion:)],
                @"FLADLocalAuthApi api (%@) doesn't respond to "
                @"@selector(authenticateWithOptions:strings:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLADAuthOptions *arg_options = GetNullableObjectAtIndex(args, 0);
        FLADAuthStrings *arg_strings = GetNullableObjectAtIndex(args, 1);
        [api authenticateWithOptions:arg_options
                             strings:arg_strings
                          completion:^(FLADAuthResultDetails *_Nullable output,
                                       FlutterError *_Nullable error) {
                            callback(wrapResult(output, error));
                          }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
