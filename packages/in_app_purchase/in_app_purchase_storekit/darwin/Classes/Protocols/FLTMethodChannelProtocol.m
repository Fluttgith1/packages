#import "FLTMethodChannelProtocol.h"

@interface DefaultMethodChannel ()
// The wrapped FlutterMethodChannel
@property(strong, nonatomic) FlutterMethodChannel *channel;
@end

@implementation DefaultMethodChannel
- (void)invokeMethod:(nonnull NSString *)method arguments:(id _Nullable)arguments {
  [self.channel invokeMethod:method arguments:arguments];
}

- (void)invokeMethod:(nonnull NSString *)method
           arguments:(id _Nullable)arguments
              result:(FlutterResult _Nullable)callback {
  [self.channel invokeMethod:method arguments:arguments result:callback];
}

- (instancetype)initWithChannel:(nonnull FlutterMethodChannel *)channel {
  self = [super init];
  if (self) {
    _channel = channel;
  }
  return self;
}

@end
