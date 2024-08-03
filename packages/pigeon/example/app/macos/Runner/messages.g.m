// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon, do not edit directly.
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

static NSArray<id> *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}

static FlutterError *createConnectionError(NSString *channelName) {
  return [FlutterError
      errorWithCode:@"channel-error"
            message:[NSString stringWithFormat:@"%@/%@/%@",
                                               @"Unable to establish connection on channel: '",
                                               channelName, @"'."]
            details:@""];
}

static id GetNullableObjectAtIndex(NSArray<id> *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@implementation PGNCodeBox
- (instancetype)initWithValue:(PGNCode)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

@interface PGNMessageData ()
+ (PGNMessageData *)fromList:(NSArray<id> *)list;
+ (nullable PGNMessageData *)nullableFromList:(NSArray<id> *)list;
- (NSArray<id> *)toList;
@end

@implementation PGNMessageData
+ (instancetype)makeWithName:(nullable NSString *)name
                 description:(nullable NSString *)description
                        code:(PGNCode)code
                        data:(NSDictionary<NSString *, NSString *> *)data {
  PGNMessageData *pigeonResult = [[PGNMessageData alloc] init];
  pigeonResult.name = name;
  pigeonResult.description = description;
  pigeonResult.code = code;
  pigeonResult.data = data;
  return pigeonResult;
}
+ (PGNMessageData *)fromList:(NSArray<id> *)list {
  PGNMessageData *pigeonResult = [[PGNMessageData alloc] init];
  pigeonResult.name = GetNullableObjectAtIndex(list, 0);
  pigeonResult.description = GetNullableObjectAtIndex(list, 1);
  PGNCodeBox *anPGNCodeBox = GetNullableObjectAtIndex(list, 2);
  pigeonResult.code = anPGNCodeBox.value;
  pigeonResult.data = GetNullableObjectAtIndex(list, 3);
  return pigeonResult;
}
+ (nullable PGNMessageData *)nullableFromList:(NSArray<id> *)list {
  return (list) ? [PGNMessageData fromList:list] : nil;
}
- (NSArray<id> *)toList {
  return @[
    self.name ?: [NSNull null],
    self.description ?: [NSNull null],
    [[PGNCodeBox alloc] initWithValue:self.code],
    self.data ?: [NSNull null],
  ];
}
@end

@interface PGNMessagesPigeonCodecReader : FlutterStandardReader
@end
@implementation PGNMessagesPigeonCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 129: {
      NSNumber *enumAsNumber = [self readValue];
      return enumAsNumber == nil ? nil
                                 : [[PGNCodeBox alloc] initWithValue:[enumAsNumber integerValue]];
    }
    case 130:
      return [PGNMessageData fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface PGNMessagesPigeonCodecWriter : FlutterStandardWriter
@end
@implementation PGNMessagesPigeonCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[PGNCodeBox class]]) {
    PGNCodeBox *box = (PGNCodeBox *)value;
    [self writeByte:129];
    [self writeValue:(value == nil ? [NSNull null] : [NSNumber numberWithInteger:box.value])];
  } else if ([value isKindOfClass:[PGNMessageData class]]) {
    [self writeByte:130];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface PGNMessagesPigeonCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation PGNMessagesPigeonCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[PGNMessagesPigeonCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[PGNMessagesPigeonCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *PGNGetMessagesCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    PGNMessagesPigeonCodecReaderWriter *readerWriter =
        [[PGNMessagesPigeonCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}
void SetUpPGNExampleHostApi(id<FlutterBinaryMessenger> binaryMessenger,
                            NSObject<PGNExampleHostApi> *api) {
  SetUpPGNExampleHostApiWithSuffix(binaryMessenger, api, @"");
}

void SetUpPGNExampleHostApiWithSuffix(id<FlutterBinaryMessenger> binaryMessenger,
                                      NSObject<PGNExampleHostApi> *api,
                                      NSString *messageChannelSuffix) {
  messageChannelSuffix = messageChannelSuffix.length > 0
                             ? [NSString stringWithFormat:@".%@", messageChannelSuffix]
                             : @"";
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:[NSString stringWithFormat:@"%@%@",
                                                   @"dev.flutter.pigeon.pigeon_example_package."
                                                   @"ExampleHostApi.getHostLanguage",
                                                   messageChannelSuffix]
        binaryMessenger:binaryMessenger
                  codec:PGNGetMessagesCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(getHostLanguageWithError:)],
          @"PGNExampleHostApi api (%@) doesn't respond to @selector(getHostLanguageWithError:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSString *output = [api getHostLanguageWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:
               [NSString
                   stringWithFormat:@"%@%@",
                                    @"dev.flutter.pigeon.pigeon_example_package.ExampleHostApi.add",
                                    messageChannelSuffix]
        binaryMessenger:binaryMessenger
                  codec:PGNGetMessagesCodec()];
    if (api) {
      NSCAssert(
          [api respondsToSelector:@selector(addNumber:toNumber:error:)],
          @"PGNExampleHostApi api (%@) doesn't respond to @selector(addNumber:toNumber:error:)",
          api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        NSInteger arg_a = [GetNullableObjectAtIndex(args, 0) integerValue];
        NSInteger arg_b = [GetNullableObjectAtIndex(args, 1) integerValue];
        FlutterError *error;
        NSNumber *output = [api addNumber:arg_a toNumber:arg_b error:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:[NSString stringWithFormat:@"%@%@",
                                                   @"dev.flutter.pigeon.pigeon_example_package."
                                                   @"ExampleHostApi.sendMessage",
                                                   messageChannelSuffix]
        binaryMessenger:binaryMessenger
                  codec:PGNGetMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(sendMessageMessage:completion:)],
                @"PGNExampleHostApi api (%@) doesn't respond to "
                @"@selector(sendMessageMessage:completion:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        PGNMessageData *arg_message = GetNullableObjectAtIndex(args, 0);
        [api sendMessageMessage:arg_message
                     completion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
                       callback(wrapResult(output, error));
                     }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface PGNMessageFlutterApi ()
@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@property(nonatomic, strong) NSString *messageChannelSuffix;
@end

@implementation PGNMessageFlutterApi

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  return [self initWithBinaryMessenger:binaryMessenger messageChannelSuffix:@""];
}
- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger
                   messageChannelSuffix:(nullable NSString *)messageChannelSuffix {
  self = [self init];
  if (self) {
    _binaryMessenger = binaryMessenger;
    _messageChannelSuffix = [messageChannelSuffix length] == 0
                                ? @""
                                : [NSString stringWithFormat:@".%@", messageChannelSuffix];
  }
  return self;
}
- (void)flutterMethodAString:(nullable NSString *)arg_aString
                  completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion {
  NSString *channelName = [NSString
      stringWithFormat:@"%@%@",
                       @"dev.flutter.pigeon.pigeon_example_package.MessageFlutterApi.flutterMethod",
                       _messageChannelSuffix];
  FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel messageChannelWithName:channelName
                                         binaryMessenger:self.binaryMessenger
                                                   codec:PGNGetMessagesCodec()];
  [channel sendMessage:@[ arg_aString ?: [NSNull null] ]
                 reply:^(NSArray<id> *reply) {
                   if (reply != nil) {
                     if (reply.count > 1) {
                       completion(nil, [FlutterError errorWithCode:reply[0]
                                                           message:reply[1]
                                                           details:reply[2]]);
                     } else {
                       NSString *output = reply[0] == [NSNull null] ? nil : reply[0];
                       completion(output, nil);
                     }
                   } else {
                     completion(nil, createConnectionError(channelName));
                   }
                 }];
}
@end
