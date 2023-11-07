// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class FSIInitParams;
@class FSIUserData;
@class FSITokenData;

/// Pigeon version of SignInInitParams.
///
/// See SignInInitParams for details.
@interface FSIInitParams : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithScopes:(NSArray<NSString *> *)scopes
                  hostedDomain:(nullable NSString *)hostedDomain
                      clientId:(nullable NSString *)clientId
                serverClientId:(nullable NSString *)serverClientId;
@property(nonatomic, strong) NSArray<NSString *> *scopes;
@property(nonatomic, copy, nullable) NSString *hostedDomain;
@property(nonatomic, copy, nullable) NSString *clientId;
@property(nonatomic, copy, nullable) NSString *serverClientId;
@end

/// Pigeon version of GoogleSignInUserData.
///
/// See GoogleSignInUserData for details.
@interface FSIUserData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithDisplayName:(nullable NSString *)displayName
                              email:(NSString *)email
                             userId:(NSString *)userId
                           photoUrl:(nullable NSString *)photoUrl
                     serverAuthCode:(nullable NSString *)serverAuthCode
                            idToken:(nullable NSString *)idToken;
@property(nonatomic, copy, nullable) NSString *displayName;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy, nullable) NSString *photoUrl;
@property(nonatomic, copy, nullable) NSString *serverAuthCode;
@property(nonatomic, copy, nullable) NSString *idToken;
@end

/// Pigeon version of GoogleSignInTokenData.
///
/// See GoogleSignInTokenData for details.
@interface FSITokenData : NSObject
+ (instancetype)makeWithIdToken:(nullable NSString *)idToken
                    accessToken:(nullable NSString *)accessToken;
@property(nonatomic, copy, nullable) NSString *idToken;
@property(nonatomic, copy, nullable) NSString *accessToken;
@end

/// The codec used by FSIGoogleSignInApi.
NSObject<FlutterMessageCodec> *FSIGoogleSignInApiGetCodec(void);

@protocol FSIGoogleSignInApi
/// Initializes a sign in request with the given parameters.
- (void)initializeSignInWithParameters:(FSIInitParams *)params
                                 error:(FlutterError *_Nullable *_Nonnull)error;
/// Starts a silent sign in.
- (void)signInSilentlyWithCompletion:(void (^)(FSIUserData *_Nullable,
                                               FlutterError *_Nullable))completion;
/// Starts a sign in with user interaction.
- (void)signInWithCompletion:(void (^)(FSIUserData *_Nullable, FlutterError *_Nullable))completion;
/// Requests the access token for the current sign in.
- (void)getAccessTokenWithCompletion:(void (^)(FSITokenData *_Nullable,
                                               FlutterError *_Nullable))completion;
/// Signs out the current user.
- (void)signOutWithError:(FlutterError *_Nullable *_Nonnull)error;
/// Revokes scope grants to the application.
- (void)disconnectWithCompletion:(void (^)(FlutterError *_Nullable))completion;
/// Returns whether the user is currently signed in.
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)isSignedInWithError:(FlutterError *_Nullable *_Nonnull)error;
/// Requests access to the given scopes.
- (void)requestScopes:(NSArray<NSString *> *)scopes
           completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
@end

extern void FSIGoogleSignInApiSetup(id<FlutterBinaryMessenger> binaryMessenger,
                                    NSObject<FSIGoogleSignInApi> *_Nullable api);

NS_ASSUME_NONNULL_END
