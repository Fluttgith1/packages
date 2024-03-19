// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// Autogenerated from Pigeon, do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AnEnum) {
  AnEnumOne = 0,
  AnEnumTwo = 1,
  AnEnumThree = 2,
  AnEnumFortyTwo = 3,
  AnEnumFourHundredTwentyTwo = 4,
};

/// Wrapper for AnEnum to allow for nullability.
@interface AnEnumBox : NSObject
@property(nonatomic, assign) AnEnum value;
- (instancetype)initWithValue:(AnEnum)value;
@end

@class AllTypes;
@class AllNullableTypes;
@class AllClassesWrapper;
@class TestMessage;

/// A class containing all supported types.
@interface AllTypes : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithABool:(BOOL)aBool
                        anInt:(NSInteger)anInt
                      anInt64:(NSInteger)anInt64
                      aDouble:(double)aDouble
                   aByteArray:(FlutterStandardTypedData *)aByteArray
                  a4ByteArray:(FlutterStandardTypedData *)a4ByteArray
                  a8ByteArray:(FlutterStandardTypedData *)a8ByteArray
                  aFloatArray:(FlutterStandardTypedData *)aFloatArray
                        aList:(NSArray *)aList
                         aMap:(NSDictionary *)aMap
                       anEnum:(AnEnum)anEnum
                      aString:(NSString *)aString
                     anObject:(id)anObject;
@property(nonatomic, assign) BOOL aBool;
@property(nonatomic, assign) NSInteger anInt;
@property(nonatomic, assign) NSInteger anInt64;
@property(nonatomic, assign) double aDouble;
@property(nonatomic, strong) FlutterStandardTypedData *aByteArray;
@property(nonatomic, strong) FlutterStandardTypedData *a4ByteArray;
@property(nonatomic, strong) FlutterStandardTypedData *a8ByteArray;
@property(nonatomic, strong) FlutterStandardTypedData *aFloatArray;
@property(nonatomic, copy) NSArray *aList;
@property(nonatomic, copy) NSDictionary *aMap;
@property(nonatomic, assign) AnEnum anEnum;
@property(nonatomic, copy) NSString *aString;
@property(nonatomic, strong) id anObject;
@end

/// A class containing all supported nullable types.
@interface AllNullableTypes : NSObject
+ (instancetype)makeWithANullableBool:(nullable NSNumber *)aNullableBool
                         aNullableInt:(nullable NSNumber *)aNullableInt
                       aNullableInt64:(nullable NSNumber *)aNullableInt64
                      aNullableDouble:(nullable NSNumber *)aNullableDouble
                   aNullableByteArray:(nullable FlutterStandardTypedData *)aNullableByteArray
                  aNullable4ByteArray:(nullable FlutterStandardTypedData *)aNullable4ByteArray
                  aNullable8ByteArray:(nullable FlutterStandardTypedData *)aNullable8ByteArray
                  aNullableFloatArray:(nullable FlutterStandardTypedData *)aNullableFloatArray
                        aNullableList:(nullable NSArray *)aNullableList
                         aNullableMap:(nullable NSDictionary *)aNullableMap
                   nullableNestedList:(nullable NSArray<NSArray<NSNumber *> *> *)nullableNestedList
           nullableMapWithAnnotations:
               (nullable NSDictionary<NSString *, NSString *> *)nullableMapWithAnnotations
                nullableMapWithObject:(nullable NSDictionary<NSString *, id> *)nullableMapWithObject
                        aNullableEnum:(nullable AnEnumBox *)aNullableEnum
                      aNullableString:(nullable NSString *)aNullableString
                      aNullableObject:(nullable id)aNullableObject;
@property(nonatomic, strong, nullable) NSNumber *aNullableBool;
@property(nonatomic, strong, nullable) NSNumber *aNullableInt;
@property(nonatomic, strong, nullable) NSNumber *aNullableInt64;
@property(nonatomic, strong, nullable) NSNumber *aNullableDouble;
@property(nonatomic, strong, nullable) FlutterStandardTypedData *aNullableByteArray;
@property(nonatomic, strong, nullable) FlutterStandardTypedData *aNullable4ByteArray;
@property(nonatomic, strong, nullable) FlutterStandardTypedData *aNullable8ByteArray;
@property(nonatomic, strong, nullable) FlutterStandardTypedData *aNullableFloatArray;
@property(nonatomic, copy, nullable) NSArray *aNullableList;
@property(nonatomic, copy, nullable) NSDictionary *aNullableMap;
@property(nonatomic, copy, nullable) NSArray<NSArray<NSNumber *> *> *nullableNestedList;
@property(nonatomic, copy, nullable)
    NSDictionary<NSString *, NSString *> *nullableMapWithAnnotations;
@property(nonatomic, copy, nullable) NSDictionary<NSString *, id> *nullableMapWithObject;
@property(nonatomic, strong, nullable) AnEnumBox *aNullableEnum;
@property(nonatomic, copy, nullable) NSString *aNullableString;
@property(nonatomic, strong, nullable) id aNullableObject;
@end

/// A class for testing nested class handling.
///
/// This is needed to test nested nullable and non-nullable classes,
/// `AllNullableTypes` is non-nullable here as it is easier to instantiate
/// than `AllTypes` when testing doesn't require both (ie. testing null classes).
@interface AllClassesWrapper : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithAllNullableTypes:(AllNullableTypes *)allNullableTypes
                                allTypes:(nullable AllTypes *)allTypes;
@property(nonatomic, strong) AllNullableTypes *allNullableTypes;
@property(nonatomic, strong, nullable) AllTypes *allTypes;
@end

/// A data class containing a List, used in unit tests.
@interface TestMessage : NSObject
+ (instancetype)makeWithTestList:(nullable NSArray *)testList;
@property(nonatomic, copy, nullable) NSArray *testList;
@end

/// The codec used by HostIntegrationCoreApi.
NSObject<FlutterMessageCodec> *HostIntegrationCoreApiGetCodec(void);

/// The core interface that each host language plugin must implement in
/// platform_test integration tests.
@protocol HostIntegrationCoreApi
/// A no-op function taking no arguments and returning no value, to sanity
/// test basic calling.
- (void)noopWithError:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed object, to test serialization and deserialization.
///
/// @return `nil` only when `error != nil`.
- (nullable AllTypes *)echoAllTypes:(AllTypes *)everything
                              error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns an error, to test error handling.
- (nullable id)throwErrorWithError:(FlutterError *_Nullable *_Nonnull)error;
/// Returns an error from a void function, to test error handling.
- (void)throwErrorFromVoidWithError:(FlutterError *_Nullable *_Nonnull)error;
/// Returns a Flutter error, to test error handling.
- (nullable id)throwFlutterErrorWithError:(FlutterError *_Nullable *_Nonnull)error;
/// Returns passed in int.
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)echoInt:(NSInteger)anInt error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns passed in double.
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)echoDouble:(double)aDouble error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed in boolean.
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)echoBool:(BOOL)aBool error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed in string.
///
/// @return `nil` only when `error != nil`.
- (nullable NSString *)echoString:(NSString *)aString
                            error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed in Uint8List.
///
/// @return `nil` only when `error != nil`.
- (nullable FlutterStandardTypedData *)echoUint8List:(FlutterStandardTypedData *)aUint8List
                                               error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed in generic Object.
///
/// @return `nil` only when `error != nil`.
- (nullable id)echoObject:(id)anObject error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed list, to test serialization and deserialization.
///
/// @return `nil` only when `error != nil`.
- (nullable NSArray<id> *)echoList:(NSArray<id> *)aList
                             error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed map, to test serialization and deserialization.
///
/// @return `nil` only when `error != nil`.
- (nullable NSDictionary<NSString *, id> *)echoMap:(NSDictionary<NSString *, id> *)aMap
                                             error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed map to test nested class serialization and deserialization.
///
/// @return `nil` only when `error != nil`.
- (nullable AllClassesWrapper *)echoClassWrapper:(AllClassesWrapper *)wrapper
                                           error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed enum to test serialization and deserialization.
///
/// @return `nil` only when `error != nil`.
- (AnEnumBox *_Nullable)echoEnum:(AnEnum)anEnum error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the default string.
///
/// @return `nil` only when `error != nil`.
- (nullable NSString *)echoNamedDefaultString:(NSString *)aString
                                        error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns passed in double.
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)echoOptionalDefaultDouble:(double)aDouble
                                           error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns passed in int.
///
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)echoRequiredInt:(NSInteger)anInt
                                 error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed object, to test serialization and deserialization.
- (nullable AllNullableTypes *)echoAllNullableTypes:(nullable AllNullableTypes *)everything
                                              error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the inner `aString` value from the wrapped object, to test
/// sending of nested objects.
- (nullable NSString *)extractNestedNullableStringFrom:(AllClassesWrapper *)wrapper
                                                 error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the inner `aString` value from the wrapped object, to test
/// sending of nested objects.
///
/// @return `nil` only when `error != nil`.
- (nullable AllClassesWrapper *)
    createNestedObjectWithNullableString:(nullable NSString *)nullableString
                                   error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns passed in arguments of multiple types.
///
/// @return `nil` only when `error != nil`.
- (nullable AllNullableTypes *)sendMultipleNullableTypesABool:(nullable NSNumber *)aNullableBool
                                                        anInt:(nullable NSNumber *)aNullableInt
                                                      aString:(nullable NSString *)aNullableString
                                                        error:(FlutterError *_Nullable *_Nonnull)
                                                                  error;
/// Returns passed in int.
- (nullable NSNumber *)echoNullableInt:(nullable NSNumber *)aNullableInt
                                 error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns passed in double.
- (nullable NSNumber *)echoNullableDouble:(nullable NSNumber *)aNullableDouble
                                    error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed in boolean.
- (nullable NSNumber *)echoNullableBool:(nullable NSNumber *)aNullableBool
                                  error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed in string.
- (nullable NSString *)echoNullableString:(nullable NSString *)aNullableString
                                    error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed in Uint8List.
- (nullable FlutterStandardTypedData *)
    echoNullableUint8List:(nullable FlutterStandardTypedData *)aNullableUint8List
                    error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed in generic Object.
- (nullable id)echoNullableObject:(nullable id)aNullableObject
                            error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed list, to test serialization and deserialization.
- (nullable NSArray<id> *)echoNullableList:(nullable NSArray<id> *)aNullableList
                                     error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed map, to test serialization and deserialization.
- (nullable NSDictionary<NSString *, id> *)echoNullableMap:
                                               (nullable NSDictionary<NSString *, id> *)aNullableMap
                                                     error:(FlutterError *_Nullable *_Nonnull)error;
- (AnEnumBox *_Nullable)echoNullableEnum:(nullable AnEnumBox *)anEnumBoxed
                                   error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns passed in int.
- (nullable NSNumber *)echoOptionalNullableInt:(nullable NSNumber *)aNullableInt
                                         error:(FlutterError *_Nullable *_Nonnull)error;
/// Returns the passed in string.
- (nullable NSString *)echoNamedNullableString:(nullable NSString *)aNullableString
                                         error:(FlutterError *_Nullable *_Nonnull)error;
/// A no-op function taking no arguments and returning no value, to sanity
/// test basic asynchronous calling.
- (void)noopAsyncWithCompletion:(void (^)(FlutterError *_Nullable))completion;
/// Returns passed in int asynchronously.
- (void)echoAsyncInt:(NSInteger)anInt
          completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns passed in double asynchronously.
- (void)echoAsyncDouble:(double)aDouble
             completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed in boolean asynchronously.
- (void)echoAsyncBool:(BOOL)aBool
           completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed string asynchronously.
- (void)echoAsyncString:(NSString *)aString
             completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed in Uint8List asynchronously.
- (void)echoAsyncUint8List:(FlutterStandardTypedData *)aUint8List
                completion:(void (^)(FlutterStandardTypedData *_Nullable,
                                     FlutterError *_Nullable))completion;
/// Returns the passed in generic Object asynchronously.
- (void)echoAsyncObject:(id)anObject
             completion:(void (^)(id _Nullable, FlutterError *_Nullable))completion;
/// Returns the passed list, to test asynchronous serialization and deserialization.
- (void)echoAsyncList:(NSArray<id> *)aList
           completion:(void (^)(NSArray<id> *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed map, to test asynchronous serialization and deserialization.
- (void)echoAsyncMap:(NSDictionary<NSString *, id> *)aMap
          completion:(void (^)(NSDictionary<NSString *, id> *_Nullable,
                               FlutterError *_Nullable))completion;
/// Returns the passed enum, to test asynchronous serialization and deserialization.
- (void)echoAsyncEnum:(AnEnum)anEnum
           completion:(void (^)(AnEnumBox *_Nullable, FlutterError *_Nullable))completion;
/// Responds with an error from an async function returning a value.
- (void)throwAsyncErrorWithCompletion:(void (^)(id _Nullable, FlutterError *_Nullable))completion;
/// Responds with an error from an async void function.
- (void)throwAsyncErrorFromVoidWithCompletion:(void (^)(FlutterError *_Nullable))completion;
/// Responds with a Flutter error from an async function returning a value.
- (void)throwAsyncFlutterErrorWithCompletion:(void (^)(id _Nullable,
                                                       FlutterError *_Nullable))completion;
/// Returns the passed object, to test async serialization and deserialization.
- (void)echoAsyncAllTypes:(AllTypes *)everything
               completion:(void (^)(AllTypes *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed object, to test serialization and deserialization.
- (void)echoAsyncNullableAllNullableTypes:(nullable AllNullableTypes *)everything
                               completion:(void (^)(AllNullableTypes *_Nullable,
                                                    FlutterError *_Nullable))completion;
/// Returns passed in int asynchronously.
- (void)echoAsyncNullableInt:(nullable NSNumber *)anInt
                  completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns passed in double asynchronously.
- (void)echoAsyncNullableDouble:(nullable NSNumber *)aDouble
                     completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed in boolean asynchronously.
- (void)echoAsyncNullableBool:(nullable NSNumber *)aBool
                   completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed string asynchronously.
- (void)echoAsyncNullableString:(nullable NSString *)aString
                     completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed in Uint8List asynchronously.
- (void)echoAsyncNullableUint8List:(nullable FlutterStandardTypedData *)aUint8List
                        completion:(void (^)(FlutterStandardTypedData *_Nullable,
                                             FlutterError *_Nullable))completion;
/// Returns the passed in generic Object asynchronously.
- (void)echoAsyncNullableObject:(nullable id)anObject
                     completion:(void (^)(id _Nullable, FlutterError *_Nullable))completion;
/// Returns the passed list, to test asynchronous serialization and deserialization.
- (void)echoAsyncNullableList:(nullable NSArray<id> *)aList
                   completion:(void (^)(NSArray<id> *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed map, to test asynchronous serialization and deserialization.
- (void)echoAsyncNullableMap:(nullable NSDictionary<NSString *, id> *)aMap
                  completion:(void (^)(NSDictionary<NSString *, id> *_Nullable,
                                       FlutterError *_Nullable))completion;
/// Returns the passed enum, to test asynchronous serialization and deserialization.
- (void)echoAsyncNullableEnum:(nullable AnEnumBox *)anEnumBoxed
                   completion:(void (^)(AnEnumBox *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterNoopWithCompletion:(void (^)(FlutterError *_Nullable))completion;
- (void)callFlutterThrowErrorWithCompletion:(void (^)(id _Nullable,
                                                      FlutterError *_Nullable))completion;
- (void)callFlutterThrowErrorFromVoidWithCompletion:(void (^)(FlutterError *_Nullable))completion;
- (void)callFlutterEchoAllTypes:(AllTypes *)everything
                     completion:(void (^)(AllTypes *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoAllNullableTypes:(nullable AllNullableTypes *)everything
                             completion:(void (^)(AllNullableTypes *_Nullable,
                                                  FlutterError *_Nullable))completion;
- (void)callFlutterSendMultipleNullableTypesABool:(nullable NSNumber *)aNullableBool
                                            anInt:(nullable NSNumber *)aNullableInt
                                          aString:(nullable NSString *)aNullableString
                                       completion:(void (^)(AllNullableTypes *_Nullable,
                                                            FlutterError *_Nullable))completion;
- (void)callFlutterEchoBool:(BOOL)aBool
                 completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoInt:(NSInteger)anInt
                completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoDouble:(double)aDouble
                   completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoString:(NSString *)aString
                   completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoUint8List:(FlutterStandardTypedData *)aList
                      completion:(void (^)(FlutterStandardTypedData *_Nullable,
                                           FlutterError *_Nullable))completion;
- (void)callFlutterEchoList:(NSArray<id> *)aList
                 completion:(void (^)(NSArray<id> *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoMap:(NSDictionary<NSString *, id> *)aMap
                completion:(void (^)(NSDictionary<NSString *, id> *_Nullable,
                                     FlutterError *_Nullable))completion;
- (void)callFlutterEchoEnum:(AnEnum)anEnum
                 completion:(void (^)(AnEnumBox *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoNullableBool:(nullable NSNumber *)aBool
                         completion:
                             (void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoNullableInt:(nullable NSNumber *)anInt
                        completion:
                            (void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoNullableDouble:(nullable NSNumber *)aDouble
                           completion:
                               (void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoNullableString:(nullable NSString *)aString
                           completion:
                               (void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoNullableUint8List:(nullable FlutterStandardTypedData *)aList
                              completion:(void (^)(FlutterStandardTypedData *_Nullable,
                                                   FlutterError *_Nullable))completion;
- (void)callFlutterEchoNullableList:(nullable NSArray<id> *)aList
                         completion:
                             (void (^)(NSArray<id> *_Nullable, FlutterError *_Nullable))completion;
- (void)callFlutterEchoNullableMap:(nullable NSDictionary<NSString *, id> *)aMap
                        completion:(void (^)(NSDictionary<NSString *, id> *_Nullable,
                                             FlutterError *_Nullable))completion;
- (void)callFlutterEchoNullableEnum:(nullable AnEnumBox *)anEnumBoxed
                         completion:
                             (void (^)(AnEnumBox *_Nullable, FlutterError *_Nullable))completion;
@end

extern void SetUpHostIntegrationCoreApi(id<FlutterBinaryMessenger> binaryMessenger,
                                        NSObject<HostIntegrationCoreApi> *_Nullable api);

/// The codec used by FlutterIntegrationCoreApi.
NSObject<FlutterMessageCodec> *FlutterIntegrationCoreApiGetCodec(void);

/// The core interface that the Dart platform_test code implements for host
/// integration tests to call into.
@interface FlutterIntegrationCoreApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
/// A no-op function taking no arguments and returning no value, to sanity
/// test basic calling.
- (void)noopWithCompletion:(void (^)(FlutterError *_Nullable))completion;
/// Responds with an error from an async function returning a value.
- (void)throwErrorWithCompletion:(void (^)(id _Nullable, FlutterError *_Nullable))completion;
/// Responds with an error from an async void function.
- (void)throwErrorFromVoidWithCompletion:(void (^)(FlutterError *_Nullable))completion;
/// Returns the passed object, to test serialization and deserialization.
- (void)echoAllTypes:(AllTypes *)everything
          completion:(void (^)(AllTypes *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed object, to test serialization and deserialization.
- (void)echoAllNullableTypes:(nullable AllNullableTypes *)everything
                  completion:
                      (void (^)(AllNullableTypes *_Nullable, FlutterError *_Nullable))completion;
/// Returns passed in arguments of multiple types.
///
/// Tests multiple-arity FlutterApi handling.
- (void)sendMultipleNullableTypesABool:(nullable NSNumber *)aNullableBool
                                 anInt:(nullable NSNumber *)aNullableInt
                               aString:(nullable NSString *)aNullableString
                            completion:(void (^)(AllNullableTypes *_Nullable,
                                                 FlutterError *_Nullable))completion;
/// Returns the passed boolean, to test serialization and deserialization.
- (void)echoBool:(BOOL)aBool
      completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed int, to test serialization and deserialization.
- (void)echoInt:(NSInteger)anInt
     completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed double, to test serialization and deserialization.
- (void)echoDouble:(double)aDouble
        completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed string, to test serialization and deserialization.
- (void)echoString:(NSString *)aString
        completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed byte list, to test serialization and deserialization.
- (void)echoUint8List:(FlutterStandardTypedData *)aList
           completion:
               (void (^)(FlutterStandardTypedData *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed list, to test serialization and deserialization.
- (void)echoList:(NSArray<id> *)aList
      completion:(void (^)(NSArray<id> *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed map, to test serialization and deserialization.
- (void)echoMap:(NSDictionary<NSString *, id> *)aMap
     completion:
         (void (^)(NSDictionary<NSString *, id> *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed enum to test serialization and deserialization.
- (void)echoEnum:(AnEnum)anEnum
      completion:(void (^)(AnEnumBox *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed boolean, to test serialization and deserialization.
- (void)echoNullableBool:(nullable NSNumber *)aBool
              completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed int, to test serialization and deserialization.
- (void)echoNullableInt:(nullable NSNumber *)anInt
             completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed double, to test serialization and deserialization.
- (void)echoNullableDouble:(nullable NSNumber *)aDouble
                completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed string, to test serialization and deserialization.
- (void)echoNullableString:(nullable NSString *)aString
                completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed byte list, to test serialization and deserialization.
- (void)echoNullableUint8List:(nullable FlutterStandardTypedData *)aList
                   completion:(void (^)(FlutterStandardTypedData *_Nullable,
                                        FlutterError *_Nullable))completion;
/// Returns the passed list, to test serialization and deserialization.
- (void)echoNullableList:(nullable NSArray<id> *)aList
              completion:(void (^)(NSArray<id> *_Nullable, FlutterError *_Nullable))completion;
/// Returns the passed map, to test serialization and deserialization.
- (void)echoNullableMap:(nullable NSDictionary<NSString *, id> *)aMap
             completion:(void (^)(NSDictionary<NSString *, id> *_Nullable,
                                  FlutterError *_Nullable))completion;
/// Returns the passed enum to test serialization and deserialization.
- (void)echoNullableEnum:(nullable AnEnumBox *)anEnumBoxed
              completion:(void (^)(AnEnumBox *_Nullable, FlutterError *_Nullable))completion;
/// A no-op function taking no arguments and returning no value, to sanity
/// test basic asynchronous calling.
- (void)noopAsyncWithCompletion:(void (^)(FlutterError *_Nullable))completion;
/// Returns the passed in generic Object asynchronously.
- (void)echoAsyncString:(NSString *)aString
             completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
@end

/// The codec used by HostTrivialApi.
NSObject<FlutterMessageCodec> *HostTrivialApiGetCodec(void);

/// An API that can be implemented for minimal, compile-only tests.
@protocol HostTrivialApi
- (void)noopWithError:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpHostTrivialApi(id<FlutterBinaryMessenger> binaryMessenger,
                                NSObject<HostTrivialApi> *_Nullable api);

/// The codec used by HostSmallApi.
NSObject<FlutterMessageCodec> *HostSmallApiGetCodec(void);

/// A simple API implemented in some unit tests.
@protocol HostSmallApi
- (void)echoString:(NSString *)aString
        completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
- (void)voidVoidWithCompletion:(void (^)(FlutterError *_Nullable))completion;
@end

extern void SetUpHostSmallApi(id<FlutterBinaryMessenger> binaryMessenger,
                              NSObject<HostSmallApi> *_Nullable api);

/// The codec used by FlutterSmallApi.
NSObject<FlutterMessageCodec> *FlutterSmallApiGetCodec(void);

/// A simple API called in some unit tests.
@interface FlutterSmallApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)echoWrappedList:(TestMessage *)msg
             completion:(void (^)(TestMessage *_Nullable, FlutterError *_Nullable))completion;
- (void)echoString:(NSString *)aString
        completion:(void (^)(NSString *_Nullable, FlutterError *_Nullable))completion;
@end

NS_ASSUME_NONNULL_END
