// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FLTGoogleSignInPlugin.h"
#import "FLTGoogleSignInPlugin_Test.h"

#import <GoogleSignIn/GoogleSignIn.h>

// The key within `GoogleService-Info.plist` used to hold the application's
// client id.  See https://developers.google.com/identity/sign-in/ios/start
// for more info.
static NSString *const kClientIdKey = @"CLIENT_ID";

static NSString *const kServerClientIdKey = @"SERVER_CLIENT_ID";

static NSDictionary<NSString *, id> *loadGoogleServiceInfo(void) {
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"GoogleService-Info"
                                                        ofType:@"plist"];
  if (plistPath) {
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
  }
  return nil;
}

// These error codes must match with ones declared on Android and Dart sides.
static NSString *const kErrorReasonSignInRequired = @"sign_in_required";
static NSString *const kErrorReasonSignInCanceled = @"sign_in_canceled";
static NSString *const kErrorReasonNetworkError = @"network_error";
static NSString *const kErrorReasonSignInFailed = @"sign_in_failed";

static FlutterError *getFlutterError(NSError *error) {
  NSString *errorCode;
  if (error.code == kGIDSignInErrorCodeHasNoAuthInKeychain) {
    errorCode = kErrorReasonSignInRequired;
  } else if (error.code == kGIDSignInErrorCodeCanceled) {
    errorCode = kErrorReasonSignInCanceled;
  } else if ([error.domain isEqualToString:NSURLErrorDomain]) {
    errorCode = kErrorReasonNetworkError;
  } else {
    errorCode = kErrorReasonSignInFailed;
  }
  return [FlutterError errorWithCode:errorCode
                             message:error.domain
                             details:error.localizedDescription];
}

@interface FLTGoogleSignInPlugin ()

// Configuration wrapping Google Cloud Console, Google Apps, OpenID,
// and other initialization metadata.
@property(strong) GIDConfiguration *configuration;

// Permissions requested during at sign in "init" method call
// unioned with scopes requested later with incremental authorization
// "requestScopes" method call.
// The "email" and "profile" base scopes are always implicitly requested.
@property(copy) NSSet<NSString *> *requestedScopes;

// Instance used to manage Google Sign In authentication including
// sign in, sign out, and requesting additional scopes.
@property(strong, readonly) GIDSignIn *signIn;

// The contents of GoogleService-Info.plist, if it exists.
@property(strong, nullable) NSDictionary<NSString *, id> *googleServiceProperties;

// The plugin registrar, for querying views.
@property(strong, nonnull) id<FlutterPluginRegistrar> registrar;

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;

@end

@implementation FLTGoogleSignInPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"plugins.flutter.io/google_sign_in_ios"
                                  binaryMessenger:[registrar messenger]];
  FLTGoogleSignInPlugin *instance = [[FLTGoogleSignInPlugin alloc] initWithRegistrar:registrar];
  [registrar addApplicationDelegate:instance];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  return [self initWithSignIn:GIDSignIn.sharedInstance registrar:registrar];
}

- (instancetype)initWithSignIn:(GIDSignIn *)signIn
                     registrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  return [self initWithSignIn:signIn
                    registrar:registrar
      googleServiceProperties:loadGoogleServiceInfo()];
}

- (instancetype)initWithSignIn:(GIDSignIn *)signIn
                     registrar:(NSObject<FlutterPluginRegistrar> *)registrar
       googleServiceProperties:(nullable NSDictionary<NSString *, id> *)googleServiceProperties {
  self = [super init];
  if (self) {
    _signIn = signIn;
    _registrar = registrar;
    _googleServiceProperties = googleServiceProperties;

    // On the iOS simulator, we get "Broken pipe" errors after sign-in for some
    // unknown reason. We can avoid crashing the app by ignoring them.
    signal(SIGPIPE, SIG_IGN);
    _requestedScopes = [[NSSet alloc] init];
  }
  return self;
}

#pragma mark - <FlutterPlugin> protocol

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([call.method isEqualToString:@"init"]) {
    GIDConfiguration *configuration =
        [self configurationWithClientIdArgument:call.arguments[@"clientId"]
                         serverClientIdArgument:call.arguments[@"serverClientId"]
                           hostedDomainArgument:call.arguments[@"hostedDomain"]];
    if (configuration != nil) {
      if ([call.arguments[@"scopes"] isKindOfClass:[NSArray class]]) {
        self.requestedScopes = [NSSet setWithArray:call.arguments[@"scopes"]];
      }
      self.configuration = configuration;
      result(nil);
    } else {
      result([FlutterError errorWithCode:@"missing-config"
                                 message:@"GoogleService-Info.plist file not found and clientId "
                                         @"was not provided programmatically."
                                 details:nil]);
    }
  } else if ([call.method isEqualToString:@"signInSilently"]) {
    [self.signIn restorePreviousSignInWithCallback:^(GIDGoogleUser *user, NSError *error) {
      [self didSignInForUser:user result:result withError:error];
    }];
  } else if ([call.method isEqualToString:@"isSignedIn"]) {
    result(@([self.signIn hasPreviousSignIn]));
  } else if ([call.method isEqualToString:@"signIn"]) {
    @try {
      GIDConfiguration *configuration = self.configuration
                                            ?: [self configurationWithClientIdArgument:nil
                                                                serverClientIdArgument:nil
                                                                  hostedDomainArgument:nil];
      [self signInWithConfiguration:configuration
                               hint:nil
                   additionalScopes:self.requestedScopes.allObjects
                           callback:^(GIDGoogleUser *user, NSError *error) {
                             [self didSignInForUser:user result:result withError:error];
                           }];
    } @catch (NSException *e) {
      result([FlutterError errorWithCode:@"google_sign_in" message:e.reason details:e.name]);
      [e raise];
    }
  } else if ([call.method isEqualToString:@"getTokens"]) {
    GIDGoogleUser *currentUser = self.signIn.currentUser;
    GIDAuthentication *auth = currentUser.authentication;
    [auth doWithFreshTokens:^void(GIDAuthentication *authentication, NSError *error) {
      result(error != nil ? getFlutterError(error) : @{
        @"idToken" : authentication.idToken,
        @"accessToken" : authentication.accessToken,
      });
    }];
  } else if ([call.method isEqualToString:@"signOut"]) {
    [self.signIn signOut];
    result(nil);
  } else if ([call.method isEqualToString:@"disconnect"]) {
    [self.signIn disconnectWithCallback:^(NSError *error) {
      [self respondWithAccount:@{} result:result error:nil];
    }];
  } else if ([call.method isEqualToString:@"requestScopes"]) {
    id scopeArgument = call.arguments[@"scopes"];
    if ([scopeArgument isKindOfClass:[NSArray class]]) {
      self.requestedScopes = [self.requestedScopes setByAddingObjectsFromArray:scopeArgument];
    }
    NSSet<NSString *> *requestedScopes = self.requestedScopes;

    @try {
      [self addScopes:requestedScopes.allObjects
             callback:^(GIDGoogleUser *addedScopeUser, NSError *addedScopeError) {
               if ([addedScopeError.domain isEqualToString:kGIDSignInErrorDomain] &&
                   addedScopeError.code == kGIDSignInErrorCodeNoCurrentUser) {
                 result([FlutterError errorWithCode:@"sign_in_required"
                                            message:@"No account to grant scopes."
                                            details:nil]);
               } else if ([addedScopeError.domain isEqualToString:kGIDSignInErrorDomain] &&
                          addedScopeError.code == kGIDSignInErrorCodeScopesAlreadyGranted) {
                 // Scopes already granted, report success.
                 result(@YES);
               } else if (addedScopeUser == nil) {
                 result(@NO);
               } else {
                 NSSet<NSString *> *grantedScopes =
                     [NSSet setWithArray:addedScopeUser.grantedScopes];
                 BOOL granted = [requestedScopes isSubsetOfSet:grantedScopes];
                 result(@(granted));
               }
             }];
    } @catch (NSException *e) {
      result([FlutterError errorWithCode:@"request_scopes" message:e.reason details:e.name]);
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

#if TARGET_OS_IOS
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
  return [self.signIn handleURL:url];
}
#else
- (BOOL)handleOpenURLs:(NSArray<NSURL *> *)urls {
  BOOL handled = NO;
  for (NSURL *url in urls) {
    handled = handled || [self.signIn handleURL:url];
  }
  return handled;
}
#endif

#pragma mark - private methods

// Wraps the iOS and macOS sign in display methods.
- (void)signInWithConfiguration:(GIDConfiguration *)configuration
                           hint:(nullable NSString *)hint
               additionalScopes:(nullable NSArray<NSString *> *)additionalScopes
                       callback:(nullable GIDSignInCallback)callback {
#if TARGET_OS_OSX
  [self.signIn signInWithConfiguration:configuration
                      presentingWindow:self.registrar.view.window
                                  hint:hint
                      additionalScopes:additionalScopes
                              callback:callback];
#else
  [self.signIn signInWithConfiguration:configuration
              presentingViewController:[self topViewController]
                                  hint:hint
                      additionalScopes:additionalScopes
                              callback:callback];
#endif
}

// Wraps the iOS and macOS scope addition methods.
- (void)addScopes:(NSArray<NSString *> *)scopes callback:(nullable GIDSignInCallback)callback {
#if TARGET_OS_OSX
  [self.signIn addScopes:scopes presentingWindow:self.registrar.view.window callback:callback];
#else
  [self.signIn addScopes:scopes
      presentingViewController:[self topViewController]
                      callback:callback];
#endif
}

/// @return @c nil if GoogleService-Info.plist not found and clientId is not provided.
- (GIDConfiguration *)configurationWithClientIdArgument:(id)clientIDArg
                                 serverClientIdArgument:(id)serverClientIDArg
                                   hostedDomainArgument:(id)hostedDomainArg {
  NSString *clientID;
  BOOL hasDynamicClientId = [clientIDArg isKindOfClass:[NSString class]];
  if (hasDynamicClientId) {
    clientID = clientIDArg;
  } else if (self.googleServiceProperties) {
    clientID = self.googleServiceProperties[kClientIdKey];
  } else {
    // We couldn't resolve a clientId, without which we cannot create a GIDConfiguration.
    return nil;
  }

  BOOL hasDynamicServerClientId = [serverClientIDArg isKindOfClass:[NSString class]];
  NSString *serverClientID = hasDynamicServerClientId
                                 ? serverClientIDArg
                                 : self.googleServiceProperties[kServerClientIdKey];

  NSString *hostedDomain = nil;
  if (hostedDomainArg != [NSNull null]) {
    hostedDomain = hostedDomainArg;
  }
  return [[GIDConfiguration alloc] initWithClientID:clientID
                                     serverClientID:serverClientID
                                       hostedDomain:hostedDomain
                                        openIDRealm:nil];
}

- (void)didSignInForUser:(GIDGoogleUser *)user
                  result:(FlutterResult)result
               withError:(NSError *)error {
  if (error != nil) {
    // Forward all errors and let Dart side decide how to handle.
    [self respondWithAccount:nil result:result error:error];
  } else {
    NSURL *photoUrl;
    if (user.profile.hasImage) {
      // Placeholder that will be replaced by on the Dart side based on screen size.
      photoUrl = [user.profile imageURLWithDimension:1337];
    }
    [self respondWithAccount:@{
      @"displayName" : user.profile.name ?: [NSNull null],
      @"email" : user.profile.email ?: [NSNull null],
      @"id" : user.userID ?: [NSNull null],
      @"photoUrl" : [photoUrl absoluteString] ?: [NSNull null],
      @"serverAuthCode" : user.serverAuthCode ?: [NSNull null]
    }
                      result:result
                       error:nil];
  }
}

- (void)respondWithAccount:(NSDictionary<NSString *, id> *)account
                    result:(FlutterResult)result
                     error:(NSError *)error {
  result(error != nil ? getFlutterError(error) : account);
}

#if TARGET_OS_IOS

- (UIViewController *)topViewController {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  // TODO(stuartmorgan) Provide a non-deprecated codepath. See
  // https://github.com/flutter/flutter/issues/104117
  return [self topViewControllerFromViewController:[UIApplication sharedApplication]
                                                       .keyWindow.rootViewController];
#pragma clang diagnostic pop
}

/**
 * This method recursively iterate through the view hierarchy
 * to return the top most view controller.
 *
 * It supports the following scenarios:
 *
 * - The view controller is presenting another view.
 * - The view controller is a UINavigationController.
 * - The view controller is a UITabBarController.
 *
 * @return The top most view controller.
 */
- (UIViewController *)topViewControllerFromViewController:(UIViewController *)viewController {
  if ([viewController isKindOfClass:[UINavigationController class]]) {
    UINavigationController *navigationController = (UINavigationController *)viewController;
    return [self
        topViewControllerFromViewController:[navigationController.viewControllers lastObject]];
  }
  if ([viewController isKindOfClass:[UITabBarController class]]) {
    UITabBarController *tabController = (UITabBarController *)viewController;
    return [self topViewControllerFromViewController:tabController.selectedViewController];
  }
  if (viewController.presentedViewController) {
    return [self topViewControllerFromViewController:viewController.presentedViewController];
  }
  return viewController;
}

#endif

@end
