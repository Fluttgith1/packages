// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v9.2.4), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

/// Mirror of NSKeyValueObservingOptions.
///
/// See https://developer.apple.com/documentation/foundation/nskeyvalueobservingoptions?language=objc.
typedef NS_ENUM(NSUInteger, FWFNSKeyValueObservingOptionsEnum) {
  FWFNSKeyValueObservingOptionsEnumNewValue = 0,
  FWFNSKeyValueObservingOptionsEnumOldValue = 1,
  FWFNSKeyValueObservingOptionsEnumInitialValue = 2,
  FWFNSKeyValueObservingOptionsEnumPriorNotification = 3,
};

/// Mirror of NSKeyValueChange.
///
/// See https://developer.apple.com/documentation/foundation/nskeyvaluechange?language=objc.
typedef NS_ENUM(NSUInteger, FWFNSKeyValueChangeEnum) {
  FWFNSKeyValueChangeEnumSetting = 0,
  FWFNSKeyValueChangeEnumInsertion = 1,
  FWFNSKeyValueChangeEnumRemoval = 2,
  FWFNSKeyValueChangeEnumReplacement = 3,
};

/// Mirror of NSKeyValueChangeKey.
///
/// See https://developer.apple.com/documentation/foundation/nskeyvaluechangekey?language=objc.
typedef NS_ENUM(NSUInteger, FWFNSKeyValueChangeKeyEnum) {
  FWFNSKeyValueChangeKeyEnumIndexes = 0,
  FWFNSKeyValueChangeKeyEnumKind = 1,
  FWFNSKeyValueChangeKeyEnumNewValue = 2,
  FWFNSKeyValueChangeKeyEnumNotificationIsPrior = 3,
  FWFNSKeyValueChangeKeyEnumOldValue = 4,
};

/// Mirror of WKUserScriptInjectionTime.
///
/// See https://developer.apple.com/documentation/webkit/wkuserscriptinjectiontime?language=objc.
typedef NS_ENUM(NSUInteger, FWFWKUserScriptInjectionTimeEnum) {
  FWFWKUserScriptInjectionTimeEnumAtDocumentStart = 0,
  FWFWKUserScriptInjectionTimeEnumAtDocumentEnd = 1,
};

/// Mirror of WKAudiovisualMediaTypes.
///
/// See [WKAudiovisualMediaTypes](https://developer.apple.com/documentation/webkit/wkaudiovisualmediatypes?language=objc).
typedef NS_ENUM(NSUInteger, FWFWKAudiovisualMediaTypeEnum) {
  FWFWKAudiovisualMediaTypeEnumNone = 0,
  FWFWKAudiovisualMediaTypeEnumAudio = 1,
  FWFWKAudiovisualMediaTypeEnumVideo = 2,
  FWFWKAudiovisualMediaTypeEnumAll = 3,
};

/// Mirror of WKWebsiteDataTypes.
///
/// See https://developer.apple.com/documentation/webkit/wkwebsitedatarecord/data_store_record_types?language=objc.
typedef NS_ENUM(NSUInteger, FWFWKWebsiteDataTypeEnum) {
  FWFWKWebsiteDataTypeEnumCookies = 0,
  FWFWKWebsiteDataTypeEnumMemoryCache = 1,
  FWFWKWebsiteDataTypeEnumDiskCache = 2,
  FWFWKWebsiteDataTypeEnumOfflineWebApplicationCache = 3,
  FWFWKWebsiteDataTypeEnumLocalStorage = 4,
  FWFWKWebsiteDataTypeEnumSessionStorage = 5,
  FWFWKWebsiteDataTypeEnumWebSQLDatabases = 6,
  FWFWKWebsiteDataTypeEnumIndexedDBDatabases = 7,
};

/// Mirror of WKNavigationActionPolicy.
///
/// See https://developer.apple.com/documentation/webkit/wknavigationactionpolicy?language=objc.
typedef NS_ENUM(NSUInteger, FWFWKNavigationActionPolicyEnum) {
  FWFWKNavigationActionPolicyEnumAllow = 0,
  FWFWKNavigationActionPolicyEnumCancel = 1,
};

/// Mirror of NSHTTPCookiePropertyKey.
///
/// See https://developer.apple.com/documentation/foundation/nshttpcookiepropertykey.
typedef NS_ENUM(NSUInteger, FWFNSHttpCookiePropertyKeyEnum) {
  FWFNSHttpCookiePropertyKeyEnumComment = 0,
  FWFNSHttpCookiePropertyKeyEnumCommentUrl = 1,
  FWFNSHttpCookiePropertyKeyEnumDiscard = 2,
  FWFNSHttpCookiePropertyKeyEnumDomain = 3,
  FWFNSHttpCookiePropertyKeyEnumExpires = 4,
  FWFNSHttpCookiePropertyKeyEnumMaximumAge = 5,
  FWFNSHttpCookiePropertyKeyEnumName = 6,
  FWFNSHttpCookiePropertyKeyEnumOriginUrl = 7,
  FWFNSHttpCookiePropertyKeyEnumPath = 8,
  FWFNSHttpCookiePropertyKeyEnumPort = 9,
  FWFNSHttpCookiePropertyKeyEnumSameSitePolicy = 10,
  FWFNSHttpCookiePropertyKeyEnumSecure = 11,
  FWFNSHttpCookiePropertyKeyEnumValue = 12,
  FWFNSHttpCookiePropertyKeyEnumVersion = 13,
};

/// An object that contains information about an action that causes navigation
/// to occur.
///
/// Wraps [WKNavigationType](https://developer.apple.com/documentation/webkit/wknavigationaction?language=objc).
typedef NS_ENUM(NSUInteger, FWFWKNavigationType) {
  /// A link activation.
  ///
  /// See https://developer.apple.com/documentation/webkit/wknavigationtype/wknavigationtypelinkactivated?language=objc.
  FWFWKNavigationTypeLinkActivated = 0,
  /// A request to submit a form.
  ///
  /// See https://developer.apple.com/documentation/webkit/wknavigationtype/wknavigationtypeformsubmitted?language=objc.
  FWFWKNavigationTypeSubmitted = 1,
  /// A request for the frame’s next or previous item.
  ///
  /// See https://developer.apple.com/documentation/webkit/wknavigationtype/wknavigationtypebackforward?language=objc.
  FWFWKNavigationTypeBackForward = 2,
  /// A request to reload the webpage.
  ///
  /// See https://developer.apple.com/documentation/webkit/wknavigationtype/wknavigationtypereload?language=objc.
  FWFWKNavigationTypeReload = 3,
  /// A request to resubmit a form.
  ///
  /// See https://developer.apple.com/documentation/webkit/wknavigationtype/wknavigationtypeformresubmitted?language=objc.
  FWFWKNavigationTypeFormResubmitted = 4,
  /// A navigation request that originates for some other reason.
  ///
  /// See https://developer.apple.com/documentation/webkit/wknavigationtype/wknavigationtypeother?language=objc.
  FWFWKNavigationTypeOther = 5,
};

/// Possible permission decisions for device resource access.
///
/// See https://developer.apple.com/documentation/webkit/wkpermissiondecision?language=objc.
typedef NS_ENUM(NSUInteger, FWFWKPermissionDecision) {
  /// Deny permission for the requested resource.
  ///
  /// See https://developer.apple.com/documentation/webkit/wkpermissiondecision/wkpermissiondecisiondeny?language=objc.
  FWFWKPermissionDecisionDeny = 0,
  /// Deny permission for the requested resource.
  ///
  /// See https://developer.apple.com/documentation/webkit/wkpermissiondecision/wkpermissiondecisiongrant?language=objc.
  FWFWKPermissionDecisionGrant = 1,
  /// Prompt the user for permission for the requested resource.
  ///
  /// See https://developer.apple.com/documentation/webkit/wkpermissiondecision/wkpermissiondecisionprompt?language=objc.
  FWFWKPermissionDecisionPrompt = 2,
};

/// List of the types of media devices that can capture audio, video, or both.
///
/// See https://developer.apple.com/documentation/webkit/wkmediacapturetype?language=objc.
typedef NS_ENUM(NSUInteger, FWFWKMediaCaptureType) {
  /// A media device that can capture video.
  ///
  /// See https://developer.apple.com/documentation/webkit/wkmediacapturetype/wkmediacapturetypecamera?language=objc.
  FWFWKMediaCaptureTypeCamera = 0,
  /// A media device or devices that can capture audio and video.
  ///
  /// See https://developer.apple.com/documentation/webkit/wkmediacapturetype/wkmediacapturetypecameraandmicrophone?language=objc.
  FWFWKMediaCaptureTypeCameraAndMicrophone = 1,
  /// A media device that can capture audio.
  ///
  /// See https://developer.apple.com/documentation/webkit/wkmediacapturetype/wkmediacapturetypemicrophone?language=objc.
  FWFWKMediaCaptureTypeMicrophone = 2,
  /// An unknown media device.
  ///
  /// This does not represent an actual value provided by the platform and only
  /// indicates a value was provided that we don't currently support.
  FWFWKMediaCaptureTypeUnknown = 3,
};

@class FWFNSKeyValueObservingOptionsEnumData;
@class FWFNSKeyValueChangeKeyEnumData;
@class FWFWKUserScriptInjectionTimeEnumData;
@class FWFWKAudiovisualMediaTypeEnumData;
@class FWFWKWebsiteDataTypeEnumData;
@class FWFWKNavigationActionPolicyEnumData;
@class FWFNSHttpCookiePropertyKeyEnumData;
@class FWFWKPermissionDecisionData;
@class FWFWKMediaCaptureTypeData;
@class FWFNSUrlRequestData;
@class FWFWKUserScriptData;
@class FWFWKNavigationActionData;
@class FWFWKFrameInfoData;
@class FWFNSErrorData;
@class FWFWKScriptMessageData;
@class FWFWKSecurityOriginData;
@class FWFNSHttpCookieData;
@class FWFObjectOrIdentifier;

@interface FWFNSKeyValueObservingOptionsEnumData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(FWFNSKeyValueObservingOptionsEnum)value;
@property(nonatomic, assign) FWFNSKeyValueObservingOptionsEnum value;
@end

@interface FWFNSKeyValueChangeKeyEnumData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(FWFNSKeyValueChangeKeyEnum)value;
@property(nonatomic, assign) FWFNSKeyValueChangeKeyEnum value;
@end

@interface FWFWKUserScriptInjectionTimeEnumData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(FWFWKUserScriptInjectionTimeEnum)value;
@property(nonatomic, assign) FWFWKUserScriptInjectionTimeEnum value;
@end

@interface FWFWKAudiovisualMediaTypeEnumData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(FWFWKAudiovisualMediaTypeEnum)value;
@property(nonatomic, assign) FWFWKAudiovisualMediaTypeEnum value;
@end

@interface FWFWKWebsiteDataTypeEnumData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(FWFWKWebsiteDataTypeEnum)value;
@property(nonatomic, assign) FWFWKWebsiteDataTypeEnum value;
@end

@interface FWFWKNavigationActionPolicyEnumData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(FWFWKNavigationActionPolicyEnum)value;
@property(nonatomic, assign) FWFWKNavigationActionPolicyEnum value;
@end

@interface FWFNSHttpCookiePropertyKeyEnumData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(FWFNSHttpCookiePropertyKeyEnum)value;
@property(nonatomic, assign) FWFNSHttpCookiePropertyKeyEnum value;
@end

@interface FWFWKPermissionDecisionData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(FWFWKPermissionDecision)value;
@property(nonatomic, assign) FWFWKPermissionDecision value;
@end

@interface FWFWKMediaCaptureTypeData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(FWFWKMediaCaptureType)value;
@property(nonatomic, assign) FWFWKMediaCaptureType value;
@end

/// Mirror of NSURLRequest.
///
/// See https://developer.apple.com/documentation/foundation/nsurlrequest?language=objc.
@interface FWFNSUrlRequestData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithUrl:(NSString *)url
    httpMethod:(nullable NSString *)httpMethod
    httpBody:(nullable FlutterStandardTypedData *)httpBody
    allHttpHeaderFields:(NSDictionary<NSString *, NSString *> *)allHttpHeaderFields;
@property(nonatomic, copy) NSString * url;
@property(nonatomic, copy, nullable) NSString * httpMethod;
@property(nonatomic, strong, nullable) FlutterStandardTypedData * httpBody;
@property(nonatomic, strong) NSDictionary<NSString *, NSString *> * allHttpHeaderFields;
@end

/// Mirror of WKUserScript.
///
/// See https://developer.apple.com/documentation/webkit/wkuserscript?language=objc.
@interface FWFWKUserScriptData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithSource:(NSString *)source
    injectionTime:(nullable FWFWKUserScriptInjectionTimeEnumData *)injectionTime
    isMainFrameOnly:(NSNumber *)isMainFrameOnly;
@property(nonatomic, copy) NSString * source;
@property(nonatomic, strong, nullable) FWFWKUserScriptInjectionTimeEnumData * injectionTime;
@property(nonatomic, strong) NSNumber * isMainFrameOnly;
@end

/// Mirror of WKNavigationAction.
///
/// See https://developer.apple.com/documentation/webkit/wknavigationaction.
@interface FWFWKNavigationActionData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithRequest:(FWFNSUrlRequestData *)request
    targetFrame:(FWFWKFrameInfoData *)targetFrame
    navigationType:(FWFWKNavigationType)navigationType;
@property(nonatomic, strong) FWFNSUrlRequestData * request;
@property(nonatomic, strong) FWFWKFrameInfoData * targetFrame;
@property(nonatomic, assign) FWFWKNavigationType navigationType;
@end

/// Mirror of WKFrameInfo.
///
/// See https://developer.apple.com/documentation/webkit/wkframeinfo?language=objc.
@interface FWFWKFrameInfoData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithIsMainFrame:(NSNumber *)isMainFrame;
@property(nonatomic, strong) NSNumber * isMainFrame;
@end

/// Mirror of NSError.
///
/// See https://developer.apple.com/documentation/foundation/nserror?language=objc.
@interface FWFNSErrorData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithCode:(NSNumber *)code
    domain:(NSString *)domain
    localizedDescription:(NSString *)localizedDescription
    description:(NSString *)description;
@property(nonatomic, strong) NSNumber * code;
@property(nonatomic, copy) NSString * domain;
@property(nonatomic, copy) NSString * localizedDescription;
@property(nonatomic, copy) NSString * description;
@end

/// Mirror of WKScriptMessage.
///
/// See https://developer.apple.com/documentation/webkit/wkscriptmessage?language=objc.
@interface FWFWKScriptMessageData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithName:(NSString *)name
    body:(id )body;
@property(nonatomic, copy) NSString * name;
@property(nonatomic, strong) id  body;
@end

/// Mirror of WKSecurityOrigin.
///
/// See https://developer.apple.com/documentation/webkit/wksecurityorigin?language=objc.
@interface FWFWKSecurityOriginData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithHost:(NSString *)host
    port:(NSNumber *)port
    protocol:(NSString *)protocol;
@property(nonatomic, copy) NSString * host;
@property(nonatomic, strong) NSNumber * port;
@property(nonatomic, copy) NSString * protocol;
@end

/// Mirror of NSHttpCookieData.
///
/// See https://developer.apple.com/documentation/foundation/nshttpcookie?language=objc.
@interface FWFNSHttpCookieData : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithPropertyKeys:(NSArray<FWFNSHttpCookiePropertyKeyEnumData *> *)propertyKeys
    propertyValues:(NSArray<id> *)propertyValues;
@property(nonatomic, strong) NSArray<FWFNSHttpCookiePropertyKeyEnumData *> * propertyKeys;
@property(nonatomic, strong) NSArray<id> * propertyValues;
@end

/// An object that can represent either a value supported by
/// `StandardMessageCodec`, a data class in this pigeon file, or an identifier
/// of an object stored in an `InstanceManager`.
@interface FWFObjectOrIdentifier : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(id )value
    isIdentifier:(NSNumber *)isIdentifier;
@property(nonatomic, strong) id  value;
/// Whether value is an int that is used to retrieve an instance stored in an
/// `InstanceManager`.
@property(nonatomic, strong) NSNumber * isIdentifier;
@end

/// The codec used by FWFWKWebsiteDataStoreHostApi.
NSObject<FlutterMessageCodec> *FWFWKWebsiteDataStoreHostApiGetCodec(void);

/// Mirror of WKWebsiteDataStore.
///
/// See https://developer.apple.com/documentation/webkit/wkwebsitedatastore?language=objc.
@protocol FWFWKWebsiteDataStoreHostApi
- (void)createFromWebViewConfigurationWithIdentifier:(NSNumber *)identifier configurationIdentifier:(NSNumber *)configurationIdentifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)createDefaultDataStoreWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)removeDataFromDataStoreWithIdentifier:(NSNumber *)identifier ofTypes:(NSArray<FWFWKWebsiteDataTypeEnumData *> *)dataTypes modifiedSince:(NSNumber *)modificationTimeInSecondsSinceEpoch completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
@end

extern void FWFWKWebsiteDataStoreHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFWKWebsiteDataStoreHostApi> *_Nullable api);

/// The codec used by FWFUIViewHostApi.
NSObject<FlutterMessageCodec> *FWFUIViewHostApiGetCodec(void);

/// Mirror of UIView.
///
/// See https://developer.apple.com/documentation/uikit/uiview?language=objc.
@protocol FWFUIViewHostApi
- (void)setBackgroundColorForViewWithIdentifier:(NSNumber *)identifier toValue:(nullable NSNumber *)value error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setOpaqueForViewWithIdentifier:(NSNumber *)identifier isOpaque:(NSNumber *)opaque error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFUIViewHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFUIViewHostApi> *_Nullable api);

/// The codec used by FWFUIScrollViewHostApi.
NSObject<FlutterMessageCodec> *FWFUIScrollViewHostApiGetCodec(void);

/// Mirror of UIScrollView.
///
/// See https://developer.apple.com/documentation/uikit/uiscrollview?language=objc.
@protocol FWFUIScrollViewHostApi
- (void)createFromWebViewWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSArray<NSNumber *> *)contentOffsetForScrollViewWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)scrollByForScrollViewWithIdentifier:(NSNumber *)identifier x:(NSNumber *)x y:(NSNumber *)y error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setContentOffsetForScrollViewWithIdentifier:(NSNumber *)identifier toX:(NSNumber *)x y:(NSNumber *)y error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFUIScrollViewHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFUIScrollViewHostApi> *_Nullable api);

/// The codec used by FWFWKWebViewConfigurationHostApi.
NSObject<FlutterMessageCodec> *FWFWKWebViewConfigurationHostApiGetCodec(void);

/// Mirror of WKWebViewConfiguration.
///
/// See https://developer.apple.com/documentation/webkit/wkwebviewconfiguration?language=objc.
@protocol FWFWKWebViewConfigurationHostApi
- (void)createWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)createFromWebViewWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setAllowsInlineMediaPlaybackForConfigurationWithIdentifier:(NSNumber *)identifier isAllowed:(NSNumber *)allow error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setMediaTypesRequiresUserActionForConfigurationWithIdentifier:(NSNumber *)identifier forTypes:(NSArray<FWFWKAudiovisualMediaTypeEnumData *> *)types error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFWKWebViewConfigurationHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFWKWebViewConfigurationHostApi> *_Nullable api);

/// The codec used by FWFWKWebViewConfigurationFlutterApi.
NSObject<FlutterMessageCodec> *FWFWKWebViewConfigurationFlutterApiGetCodec(void);

/// Handles callbacks from a WKWebViewConfiguration instance.
///
/// See https://developer.apple.com/documentation/webkit/wkwebviewconfiguration?language=objc.
@interface FWFWKWebViewConfigurationFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)createWithIdentifier:(NSNumber *)identifier completion:(void (^)(FlutterError *_Nullable))completion;
@end

/// The codec used by FWFWKUserContentControllerHostApi.
NSObject<FlutterMessageCodec> *FWFWKUserContentControllerHostApiGetCodec(void);

/// Mirror of WKUserContentController.
///
/// See https://developer.apple.com/documentation/webkit/wkusercontentcontroller?language=objc.
@protocol FWFWKUserContentControllerHostApi
- (void)createFromWebViewConfigurationWithIdentifier:(NSNumber *)identifier configurationIdentifier:(NSNumber *)configurationIdentifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)addScriptMessageHandlerForControllerWithIdentifier:(NSNumber *)identifier handlerIdentifier:(NSNumber *)handlerIdentifier ofName:(NSString *)name error:(FlutterError *_Nullable *_Nonnull)error;
- (void)removeScriptMessageHandlerForControllerWithIdentifier:(NSNumber *)identifier name:(NSString *)name error:(FlutterError *_Nullable *_Nonnull)error;
- (void)removeAllScriptMessageHandlersForControllerWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)addUserScriptForControllerWithIdentifier:(NSNumber *)identifier userScript:(FWFWKUserScriptData *)userScript error:(FlutterError *_Nullable *_Nonnull)error;
- (void)removeAllUserScriptsForControllerWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFWKUserContentControllerHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFWKUserContentControllerHostApi> *_Nullable api);

/// The codec used by FWFWKPreferencesHostApi.
NSObject<FlutterMessageCodec> *FWFWKPreferencesHostApiGetCodec(void);

/// Mirror of WKUserPreferences.
///
/// See https://developer.apple.com/documentation/webkit/wkpreferences?language=objc.
@protocol FWFWKPreferencesHostApi
- (void)createFromWebViewConfigurationWithIdentifier:(NSNumber *)identifier configurationIdentifier:(NSNumber *)configurationIdentifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setJavaScriptEnabledForPreferencesWithIdentifier:(NSNumber *)identifier isEnabled:(NSNumber *)enabled error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFWKPreferencesHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFWKPreferencesHostApi> *_Nullable api);

/// The codec used by FWFWKScriptMessageHandlerHostApi.
NSObject<FlutterMessageCodec> *FWFWKScriptMessageHandlerHostApiGetCodec(void);

/// Mirror of WKScriptMessageHandler.
///
/// See https://developer.apple.com/documentation/webkit/wkscriptmessagehandler?language=objc.
@protocol FWFWKScriptMessageHandlerHostApi
- (void)createWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFWKScriptMessageHandlerHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFWKScriptMessageHandlerHostApi> *_Nullable api);

/// The codec used by FWFWKScriptMessageHandlerFlutterApi.
NSObject<FlutterMessageCodec> *FWFWKScriptMessageHandlerFlutterApiGetCodec(void);

/// Handles callbacks from a WKScriptMessageHandler instance.
///
/// See https://developer.apple.com/documentation/webkit/wkscriptmessagehandler?language=objc.
@interface FWFWKScriptMessageHandlerFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)didReceiveScriptMessageForHandlerWithIdentifier:(NSNumber *)identifier userContentControllerIdentifier:(NSNumber *)userContentControllerIdentifier message:(FWFWKScriptMessageData *)message completion:(void (^)(FlutterError *_Nullable))completion;
@end

/// The codec used by FWFWKNavigationDelegateHostApi.
NSObject<FlutterMessageCodec> *FWFWKNavigationDelegateHostApiGetCodec(void);

/// Mirror of WKNavigationDelegate.
///
/// See https://developer.apple.com/documentation/webkit/wknavigationdelegate?language=objc.
@protocol FWFWKNavigationDelegateHostApi
- (void)createWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFWKNavigationDelegateHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFWKNavigationDelegateHostApi> *_Nullable api);

/// The codec used by FWFWKNavigationDelegateFlutterApi.
NSObject<FlutterMessageCodec> *FWFWKNavigationDelegateFlutterApiGetCodec(void);

/// Handles callbacks from a WKNavigationDelegate instance.
///
/// See https://developer.apple.com/documentation/webkit/wknavigationdelegate?language=objc.
@interface FWFWKNavigationDelegateFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)didFinishNavigationForDelegateWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier URL:(nullable NSString *)url completion:(void (^)(FlutterError *_Nullable))completion;
- (void)didStartProvisionalNavigationForDelegateWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier URL:(nullable NSString *)url completion:(void (^)(FlutterError *_Nullable))completion;
- (void)decidePolicyForNavigationActionForDelegateWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier navigationAction:(FWFWKNavigationActionData *)navigationAction completion:(void (^)(FWFWKNavigationActionPolicyEnumData *_Nullable, FlutterError *_Nullable))completion;
- (void)didFailNavigationForDelegateWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier error:(FWFNSErrorData *)error completion:(void (^)(FlutterError *_Nullable))completion;
- (void)didFailProvisionalNavigationForDelegateWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier error:(FWFNSErrorData *)error completion:(void (^)(FlutterError *_Nullable))completion;
- (void)webViewWebContentProcessDidTerminateForDelegateWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier completion:(void (^)(FlutterError *_Nullable))completion;
@end

/// The codec used by FWFNSObjectHostApi.
NSObject<FlutterMessageCodec> *FWFNSObjectHostApiGetCodec(void);

/// Mirror of NSObject.
///
/// See https://developer.apple.com/documentation/objectivec/nsobject.
@protocol FWFNSObjectHostApi
- (void)disposeObjectWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)addObserverForObjectWithIdentifier:(NSNumber *)identifier observerIdentifier:(NSNumber *)observerIdentifier keyPath:(NSString *)keyPath options:(NSArray<FWFNSKeyValueObservingOptionsEnumData *> *)options error:(FlutterError *_Nullable *_Nonnull)error;
- (void)removeObserverForObjectWithIdentifier:(NSNumber *)identifier observerIdentifier:(NSNumber *)observerIdentifier keyPath:(NSString *)keyPath error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFNSObjectHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFNSObjectHostApi> *_Nullable api);

/// The codec used by FWFNSObjectFlutterApi.
NSObject<FlutterMessageCodec> *FWFNSObjectFlutterApiGetCodec(void);

/// Handles callbacks from an NSObject instance.
///
/// See https://developer.apple.com/documentation/objectivec/nsobject.
@interface FWFNSObjectFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)observeValueForObjectWithIdentifier:(NSNumber *)identifier keyPath:(NSString *)keyPath objectIdentifier:(NSNumber *)objectIdentifier changeKeys:(NSArray<FWFNSKeyValueChangeKeyEnumData *> *)changeKeys changeValues:(NSArray<FWFObjectOrIdentifier *> *)changeValues completion:(void (^)(FlutterError *_Nullable))completion;
- (void)disposeObjectWithIdentifier:(NSNumber *)identifier completion:(void (^)(FlutterError *_Nullable))completion;
@end

/// The codec used by FWFWKWebViewHostApi.
NSObject<FlutterMessageCodec> *FWFWKWebViewHostApiGetCodec(void);

/// Mirror of WKWebView.
///
/// See https://developer.apple.com/documentation/webkit/wkwebview?language=objc.
@protocol FWFWKWebViewHostApi
- (void)createWithIdentifier:(NSNumber *)identifier configurationIdentifier:(NSNumber *)configurationIdentifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setUIDelegateForWebViewWithIdentifier:(NSNumber *)identifier delegateIdentifier:(nullable NSNumber *)uiDelegateIdentifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setNavigationDelegateForWebViewWithIdentifier:(NSNumber *)identifier delegateIdentifier:(nullable NSNumber *)navigationDelegateIdentifier error:(FlutterError *_Nullable *_Nonnull)error;
- (nullable NSString *)URLForWebViewWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)estimatedProgressForWebViewWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)loadRequestForWebViewWithIdentifier:(NSNumber *)identifier request:(FWFNSUrlRequestData *)request error:(FlutterError *_Nullable *_Nonnull)error;
- (void)loadHTMLForWebViewWithIdentifier:(NSNumber *)identifier HTMLString:(NSString *)string baseURL:(nullable NSString *)baseUrl error:(FlutterError *_Nullable *_Nonnull)error;
- (void)loadFileForWebViewWithIdentifier:(NSNumber *)identifier fileURL:(NSString *)url readAccessURL:(NSString *)readAccessUrl error:(FlutterError *_Nullable *_Nonnull)error;
- (void)loadAssetForWebViewWithIdentifier:(NSNumber *)identifier assetKey:(NSString *)key error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)canGoBackForWebViewWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)canGoForwardForWebViewWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)goBackForWebViewWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)goForwardForWebViewWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)reloadWebViewWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (nullable NSString *)titleForWebViewWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setAllowsBackForwardForWebViewWithIdentifier:(NSNumber *)identifier isAllowed:(NSNumber *)allow error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setUserAgentForWebViewWithIdentifier:(NSNumber *)identifier userAgent:(nullable NSString *)userAgent error:(FlutterError *_Nullable *_Nonnull)error;
- (void)evaluateJavaScriptForWebViewWithIdentifier:(NSNumber *)identifier javaScriptString:(NSString *)javaScriptString completion:(void (^)(id _Nullable, FlutterError *_Nullable))completion;
@end

extern void FWFWKWebViewHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFWKWebViewHostApi> *_Nullable api);

/// The codec used by FWFWKUIDelegateHostApi.
NSObject<FlutterMessageCodec> *FWFWKUIDelegateHostApiGetCodec(void);

/// Mirror of WKUIDelegate.
///
/// See https://developer.apple.com/documentation/webkit/wkuidelegate?language=objc.
@protocol FWFWKUIDelegateHostApi
- (void)createWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFWKUIDelegateHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFWKUIDelegateHostApi> *_Nullable api);

/// The codec used by FWFWKUIDelegateFlutterApi.
NSObject<FlutterMessageCodec> *FWFWKUIDelegateFlutterApiGetCodec(void);

/// Handles callbacks from a WKUIDelegate instance.
///
/// See https://developer.apple.com/documentation/webkit/wkuidelegate?language=objc.
@interface FWFWKUIDelegateFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)onCreateWebViewForDelegateWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier configurationIdentifier:(NSNumber *)configurationIdentifier navigationAction:(FWFWKNavigationActionData *)navigationAction completion:(void (^)(FlutterError *_Nullable))completion;
/// Callback to Dart function `WKUIDelegate.requestMediaCapturePermission`.
- (void)requestMediaCapturePermissionForDelegateWithIdentifier:(NSNumber *)identifier webViewIdentifier:(NSNumber *)webViewIdentifier origin:(FWFWKSecurityOriginData *)origin frame:(FWFWKFrameInfoData *)frame type:(FWFWKMediaCaptureTypeData *)type completion:(void (^)(FWFWKPermissionDecisionData *_Nullable, FlutterError *_Nullable))completion;
@end

/// The codec used by FWFWKHttpCookieStoreHostApi.
NSObject<FlutterMessageCodec> *FWFWKHttpCookieStoreHostApiGetCodec(void);

/// Mirror of WKHttpCookieStore.
///
/// See https://developer.apple.com/documentation/webkit/wkhttpcookiestore?language=objc.
@protocol FWFWKHttpCookieStoreHostApi
- (void)createFromWebsiteDataStoreWithIdentifier:(NSNumber *)identifier dataStoreIdentifier:(NSNumber *)websiteDataStoreIdentifier error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setCookieForStoreWithIdentifier:(NSNumber *)identifier cookie:(FWFNSHttpCookieData *)cookie completion:(void (^)(FlutterError *_Nullable))completion;
@end

extern void FWFWKHttpCookieStoreHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFWKHttpCookieStoreHostApi> *_Nullable api);

/// The codec used by FWFNSUrlHostApi.
NSObject<FlutterMessageCodec> *FWFNSUrlHostApiGetCodec(void);

/// Host API for `NSUrl`.
///
/// This class may handle instantiating and adding native object instances that
/// are attached to a Dart instance or method calls on the associated native
/// class or an instance of the class.
///
/// See https://developer.apple.com/documentation/foundation/nsurl?language=objc.
@protocol FWFNSUrlHostApi
- (nullable NSString *)absoluteStringForNSURLWithIdentifier:(NSNumber *)identifier error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void FWFNSUrlHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FWFNSUrlHostApi> *_Nullable api);

/// The codec used by FWFNSUrlFlutterApi.
NSObject<FlutterMessageCodec> *FWFNSUrlFlutterApiGetCodec(void);

/// Flutter API for `NSUrl`.
///
/// This class may handle instantiating and adding Dart instances that are
/// attached to a native instance or receiving callback methods from an
/// overridden native class.
///
/// See https://developer.apple.com/documentation/foundation/nsurl?language=objc.
@interface FWFNSUrlFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)createWithIdentifier:(NSNumber *)identifier completion:(void (^)(FlutterError *_Nullable))completion;
@end

NS_ASSUME_NONNULL_END
