// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
#import "FLALocalAuthPlugin.h"
#import "FLALocalAuthPlugin_Test.h"

#import <LocalAuthentication/LocalAuthentication.h>

typedef void (^FLADAuthCompletion)(FLADAuthResultDetails *_Nullable, FlutterError *_Nullable);

/// A default context factory that wraps standard LAContext allocation.
@interface FLADefaultAuthContextFactory : NSObject <FLADAuthContextFactory>
@end

@implementation FLADefaultAuthContextFactory
- (LAContext *)createAuthContext {
  return [[LAContext alloc] init];
}
@end

#pragma mark -

/// A data container for sticky auth state.
@interface FLAStickyAuthState : NSObject
@property(nonatomic, strong, nonnull) FLADAuthOptions *options;
@property(nonatomic, strong, nonnull) FLADAuthStrings *strings;
@property(nonatomic, copy, nonnull) FLADAuthCompletion resultHandler;
- (instancetype)initWithOptions:(nonnull FLADAuthOptions *)options
                        strings:(nonnull FLADAuthStrings *)strings
                  resultHandler:(nonnull FLADAuthCompletion)resultHandler;
@end

@implementation FLAStickyAuthState
- (instancetype)initWithOptions:(nonnull FLADAuthOptions *)options
                        strings:(nonnull FLADAuthStrings *)strings
                  resultHandler:(nonnull FLADAuthCompletion)resultHandler {
  self = [super init];
  if (self) {
    _options = options;
    _strings = strings;
    _resultHandler = resultHandler;
  }
  return self;
}
@end

#pragma mark -

@interface FLALocalAuthPlugin ()
@property(nonatomic, strong, nullable) FLAStickyAuthState *lastCallState;
@property(nonatomic, strong) NSObject<FLADAuthContextFactory> *authContextFactory;
@end

@implementation FLALocalAuthPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FLALocalAuthPlugin *instance = [[FLALocalAuthPlugin alloc] init];
  [registrar addApplicationDelegate:instance];
  SetUpFLADLocalAuthApi([registrar messenger], instance);
}

- (instancetype)init {
  return [self initWithContextFactory:[[FLADefaultAuthContextFactory alloc] init]];
}

- (instancetype)initWithContextFactory:(NSObject<FLADAuthContextFactory> *)factory {
  self = [super init];
  if (self) {
    _authContextFactory = factory;
  }
  return self;
}

#pragma mark FLADLocalAuthApi

- (void)authenticateWithOptions:(nonnull FLADAuthOptions *)options
                        strings:(nonnull FLADAuthStrings *)strings
                     completion:(nonnull void (^)(FLADAuthResultDetails *_Nullable,
                                                  FlutterError *_Nullable))completion {
  LAContext *context = [self.authContextFactory createAuthContext];
  NSError *authError = nil;
  self.lastCallState = nil;
  context.localizedFallbackTitle = strings.localizedFallbackTitle;

  LAPolicy policy = options.biometricOnly ? LAPolicyDeviceOwnerAuthenticationWithBiometrics
                                          : LAPolicyDeviceOwnerAuthentication;
  if ([context canEvaluatePolicy:policy error:&authError]) {
    [context evaluatePolicy:policy
            localizedReason:strings.reason
                      reply:^(BOOL success, NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                          [self handleAuthReplyWithSuccess:success
                                                     error:error
                                                   options:options
                                                   strings:strings
                                                completion:completion];
                        });
                      }];
  } else {
    [self handleError:authError withOptions:options strings:strings completion:completion];
  }
}

- (nullable NSNumber *)deviceCanSupportBiometricsWithError:
    (FlutterError *_Nullable __autoreleasing *_Nonnull)error {
  LAContext *context = [self.authContextFactory createAuthContext];
  NSError *authError = nil;
  // Check if authentication with biometrics is possible.
  if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                           error:&authError]) {
    if (authError == nil) {
      return @YES;
    }
  }
  // If not, check if it is because no biometrics are enrolled (but still present).
  if (authError != nil) {
    if (authError.code == LAErrorBiometryNotEnrolled) {
      return @YES;
    }
  }

  return @NO;
}

- (nullable NSArray<FLADAuthBiometricWrapper *> *)getEnrolledBiometricsWithError:
    (FlutterError *_Nullable __autoreleasing *_Nonnull)error {
  LAContext *context = [self.authContextFactory createAuthContext];
  NSError *authError = nil;
  NSMutableArray<FLADAuthBiometricWrapper *> *biometrics = [[NSMutableArray alloc] init];
  if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                           error:&authError]) {
    if (authError == nil) {
      #if TARGET_OS_OSX
        // @available(macOS 10.15, *) is not a BOOL expression. 
        // It does not return an indication of whether the code is being run on that version of iOS or not.
        // So there needs to be a separate check for macOS 10.15 and on the biometry type
        // https://stackoverflow.com/questions/52251973/ios-available-does-not-guard-availability-here-use-if-available-instead
        if (@available(macOS 10.15, *)) {
          if (context.biometryType == LABiometryTypeFaceID) {
            [biometrics addObject:[FLADAuthBiometricWrapper makeWithValue:FLADAuthBiometricFace]];
            return biometrics;
          }
        }
        if (context.biometryType == LABiometryTypeTouchID) {
          [biometrics addObject:[FLADAuthBiometricWrapper makeWithValue:FLADAuthBiometricFingerprint]];          
        } 
      #endif

      #if TARGET_OS_IOS
        if (context.biometryType == LABiometryTypeFaceID) {
          [biometrics addObject:[FLADAuthBiometricWrapper makeWithValue:FLADAuthBiometricFace]];
        } else if (context.biometryType == LABiometryTypeTouchID) {
          [biometrics
              addObject:[FLADAuthBiometricWrapper makeWithValue:FLADAuthBiometricFingerprint]];
        }
      #endif
    }
  }
  return biometrics;
}

- (nullable NSNumber *)isDeviceSupportedWithError:
    (FlutterError *_Nullable __autoreleasing *_Nonnull)error {
  LAContext *context = [self.authContextFactory createAuthContext];
  return @([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:NULL]);
}

#pragma mark Private Methods

- (void)showAlertWithMessage:(NSString *)message
          dismissButtonTitle:(NSString *)dismissButtonTitle
     openSettingsButtonTitle:(NSString *)openSettingsButtonTitle
                  completion:(FLADAuthCompletion)completion {
#if TARGET_OS_OSX
  NSAlert *alert = [[NSAlert alloc] init];
  [alert setMessageText:message];
  [alert addButtonWithTitle:dismissButtonTitle];
  if (openSettingsButtonTitle != nil) {
    [alert addButtonWithTitle:openSettingsButtonTitle];
  }
  [alert beginSheetModalForWindow:NSApp.keyWindow
                completionHandler:^(NSModalResponse returnCode) {
                  if (returnCode == NSAlertSecondButtonReturn) {
                    NSURL *url = [NSURL URLWithString:@"x-apple.systempreferences:com.apple."
                                                      @"preference.security?Privacy_Biometry"];
                    [[NSWorkspace sharedWorkspace] openURL:url];
                  }
                  [self handleSucceeded:NO withCompletion:completion];
                }];
  return;
#endif

#if TARGET_OS_IOS
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:@""
                                          message:message
                                   preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:dismissButtonTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                          [self handleSucceeded:NO
                                                                 withCompletion:completion];
                                                        }];

  [alert addAction:defaultAction];
  if (openSettingsButtonTitle != nil) {
    UIAlertAction *additionalAction = [UIAlertAction
        actionWithTitle:openSettingsButtonTitle
                  style:UIAlertActionStyleDefault
                handler:^(UIAlertAction *action) {
                  NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                  [[UIApplication sharedApplication] openURL:url
                                                     options:@{}
                                           completionHandler:NULL];
                  [self handleSucceeded:NO withCompletion:completion];
                }];
    [alert addAction:additionalAction];
  }
  [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert
                                                                                     animated:YES
                                                                                   completion:nil];

#endif
}

- (void)handleAuthReplyWithSuccess:(BOOL)success
                             error:(NSError *)error
                           options:(FLADAuthOptions *)options
                           strings:(FLADAuthStrings *)strings
                        completion:(nonnull FLADAuthCompletion)completion {
  NSAssert([NSThread isMainThread], @"Response handling must be done on the main thread.");
  if (success) {
    [self handleSucceeded:YES withCompletion:completion];
  } else {
    switch (error.code) {
      case LAErrorBiometryNotAvailable:
      case LAErrorBiometryNotEnrolled:
      case LAErrorBiometryLockout:
      case LAErrorUserFallback:
      case LAErrorPasscodeNotSet:
      case LAErrorAuthenticationFailed:
        [self handleError:error withOptions:options strings:strings completion:completion];
        return;
      case LAErrorSystemCancel:
        if (options.sticky) {
          _lastCallState = [[FLAStickyAuthState alloc] initWithOptions:options
                                                               strings:strings
                                                         resultHandler:completion];
        } else {
          [self handleSucceeded:NO withCompletion:completion];
        }
        return;
    }
    [self handleError:error withOptions:options strings:strings completion:completion];
  }
}

- (void)handleSucceeded:(BOOL)succeeded withCompletion:(nonnull FLADAuthCompletion)completion {
  completion([FLADAuthResultDetails
                 makeWithResult:(succeeded ? FLADAuthResultSuccess : FLADAuthResultFailure)
                   errorMessage:nil
                   errorDetails:nil],
             nil);
}

- (void)handleError:(NSError *)authError
        withOptions:(FLADAuthOptions *)options
            strings:(FLADAuthStrings *)strings
         completion:(nonnull FLADAuthCompletion)completion {
  FLADAuthResult result = FLADAuthResultErrorNotAvailable;
  switch (authError.code) {
    case LAErrorPasscodeNotSet:
    case LAErrorBiometryNotEnrolled:
      if (options.useErrorDialogs) {
        [self showAlertWithMessage:strings.goToSettingsDescription
                 dismissButtonTitle:strings.cancelButton
            openSettingsButtonTitle:strings.goToSettingsButton
                         completion:completion];
        return;
      }
      result = authError.code == LAErrorPasscodeNotSet ? FLADAuthResultErrorPasscodeNotSet
                                                       : FLADAuthResultErrorNotEnrolled;
      break;
    case LAErrorBiometryLockout:
      [self showAlertWithMessage:strings.lockOut
               dismissButtonTitle:strings.cancelButton
          openSettingsButtonTitle:nil
                       completion:completion];
      return;
  }
  completion([FLADAuthResultDetails makeWithResult:result
                                      errorMessage:authError.localizedDescription
                                      errorDetails:authError.domain],
             nil);
}

#pragma mark - AppDelegate

// This method is called when the app is resumed from the background only on iOS
#if TARGET_OS_IOS
- (void)applicationDidBecomeActive:(UIApplication *)application {
  if (self.lastCallState != nil) {
    [self authenticateWithOptions:_lastCallState.options
                          strings:_lastCallState.strings
                       completion:_lastCallState.resultHandler];
  }
}
#endif

@end
