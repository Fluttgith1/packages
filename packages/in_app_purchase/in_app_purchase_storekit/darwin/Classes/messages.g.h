// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v14.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PaymentTransactionStateWrapper) {
  /// Indicates the transaction is being processed in App Store.
  ///
  /// You should update your UI to indicate that you are waiting for the
  /// transaction to update to another state. Never complete a transaction that
  /// is still in a purchasing state.
  PaymentTransactionStateWrapperPurchasing = 0,
  /// The user's payment has been succesfully processed.
  ///
  /// You should provide the user the content that they purchased.
  PaymentTransactionStateWrapperPurchased = 1,
  /// The transaction failed.
  ///
  /// Check the [PaymentTransactionWrapper.error] property from
  /// [PaymentTransactionWrapper] for details.
  PaymentTransactionStateWrapperFailed = 2,
  /// This transaction is restoring content previously purchased by the user.
  ///
  /// The previous transaction information can be obtained in
  /// [PaymentTransactionWrapper.originalTransaction] from
  /// [PaymentTransactionWrapper].
  PaymentTransactionStateWrapperRestored = 3,
  /// The transaction is in the queue but pending external action. Wait for
  /// another callback to get the final state.
  ///
  /// You should update your UI to indicate that you are waiting for the
  /// transaction to update to another state.
  PaymentTransactionStateWrapperDeferred = 4,
  /// Indicates the transaction is in an unspecified state.
  PaymentTransactionStateWrapperUnspecified = 5,
};

/// Wrapper for PaymentTransactionStateWrapper to allow for nullability.
@interface PaymentTransactionStateWrapperBox : NSObject
@property(nonatomic, assign) PaymentTransactionStateWrapper value;
- (instancetype)initWithValue:(PaymentTransactionStateWrapper)value;
@end

@class PaymentTransactionWrapper;
@class PaymentWrapper;
@class ErrorWrapper;
@class PaymentDiscountWrapper;
@class StorefrontWrapper;

@interface PaymentTransactionWrapper : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithPayment:(PaymentWrapper *)payment
    transactionState:(PaymentTransactionStateWrapper)transactionState
    originalTransaction:(nullable PaymentTransactionWrapper *)originalTransaction
    transactionTimeStamp:(nullable NSNumber *)transactionTimeStamp
    transactionIdentifier:(nullable NSString *)transactionIdentifier
    error:(nullable ErrorWrapper *)error;
@property(nonatomic, strong) PaymentWrapper * payment;
@property(nonatomic, assign) PaymentTransactionStateWrapper transactionState;
@property(nonatomic, strong, nullable) PaymentTransactionWrapper * originalTransaction;
@property(nonatomic, strong, nullable) NSNumber * transactionTimeStamp;
@property(nonatomic, copy, nullable) NSString * transactionIdentifier;
@property(nonatomic, strong, nullable) ErrorWrapper * error;
@end

@interface PaymentWrapper : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithProductIdentifier:(NSString *)productIdentifier
    applicationUsername:(nullable NSString *)applicationUsername
    requestData:(nullable NSString *)requestData
    quantity:(NSInteger )quantity
    simulatesAskToBuyInSandbox:(BOOL )simulatesAskToBuyInSandbox
    paymentDiscount:(nullable PaymentDiscountWrapper *)paymentDiscount;
@property(nonatomic, copy) NSString * productIdentifier;
@property(nonatomic, copy, nullable) NSString * applicationUsername;
@property(nonatomic, copy, nullable) NSString * requestData;
@property(nonatomic, assign) NSInteger  quantity;
@property(nonatomic, assign) BOOL  simulatesAskToBuyInSandbox;
@property(nonatomic, strong, nullable) PaymentDiscountWrapper * paymentDiscount;
@end

@interface ErrorWrapper : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithCode:(NSInteger )code
    domain:(NSString *)domain
    userInfo:(NSDictionary<NSString *, id> *)userInfo;
@property(nonatomic, assign) NSInteger  code;
@property(nonatomic, copy) NSString * domain;
@property(nonatomic, copy) NSDictionary<NSString *, id> * userInfo;
@end

@interface PaymentDiscountWrapper : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithIdentifier:(NSString *)identifier
    keyIdentifier:(NSString *)keyIdentifier
    nonce:(NSString *)nonce
    signature:(NSString *)signature
    timestamp:(NSInteger )timestamp;
@property(nonatomic, copy) NSString * identifier;
@property(nonatomic, copy) NSString * keyIdentifier;
@property(nonatomic, copy) NSString * nonce;
@property(nonatomic, copy) NSString * signature;
@property(nonatomic, assign) NSInteger  timestamp;
@end

@interface StorefrontWrapper : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithCountryCode:(NSString *)countryCode
    identifier:(NSString *)identifier;
@property(nonatomic, copy) NSString * countryCode;
@property(nonatomic, copy) NSString * identifier;
@end

/// The codec used by InAppPurchaseAPI.
NSObject<FlutterMessageCodec> *InAppPurchaseAPIGetCodec(void);

@protocol InAppPurchaseAPI
/// Returns if the current device is able to make payments
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)canMakePayments:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSArray<PaymentTransactionWrapper *> *)transactions:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable NSArray<StorefrontWrapper *> *)storefront:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpInAppPurchaseAPI(id<FlutterBinaryMessenger> binaryMessenger, NSObject<InAppPurchaseAPI> *_Nullable api);

NS_ASSUME_NONNULL_END
