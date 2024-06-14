// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Flutter
import UIKit

/// This plugin handles the native side of the integration tests in
/// example/integration_test/.
public class TestPlugin: NSObject, FlutterPlugin, HostIntegrationCoreApi {

  var flutterAPI: FlutterIntegrationCoreApi
  var flutterSmallApiOne: FlutterSmallApi
  var flutterSmallApiTwo: FlutterSmallApi
  var proxyApiRegistrar: PigeonProxyApiRegistrar?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let plugin = TestPlugin(binaryMessenger: registrar.messenger())
    HostIntegrationCoreApiSetup.setUp(binaryMessenger: registrar.messenger(), api: plugin)
    TestPluginWithSuffix.register(with: registrar, suffix: "suffixOne")
    TestPluginWithSuffix.register(with: registrar, suffix: "suffixTwo")
    registrar.publish(plugin)
  }

  init(binaryMessenger: FlutterBinaryMessenger) {
    flutterAPI = FlutterIntegrationCoreApi(binaryMessenger: binaryMessenger)
    flutterSmallApiOne = FlutterSmallApi(
      binaryMessenger: binaryMessenger, messageChannelSuffix: "suffixOne")
    flutterSmallApiTwo = FlutterSmallApi(
      binaryMessenger: binaryMessenger, messageChannelSuffix: "suffixTwo")
    proxyApiRegistrar = PigeonProxyApiRegistrar(
      binaryMessenger: binaryMessenger, apiDelegate: ProxyApiDelegate())
    proxyApiRegistrar!.setUp()
  }

  public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
    proxyApiRegistrar!.tearDown()
    proxyApiRegistrar = nil
  }

  // MARK: HostIntegrationCoreApi implementation

  func noop() {

  }

  func echo(_ everything: AllTypes) -> AllTypes {
    return everything
  }

  func echo(_ everything: AllNullableTypes?) -> AllNullableTypes? {
    return everything
  }
  func echo(_ everything: AllNullableTypesWithoutRecursion?) throws
    -> AllNullableTypesWithoutRecursion?
  {
    return everything
  }

  func throwError() throws -> Any? {
    throw PigeonError(code: "code", message: "message", details: "details")
  }

  func throwErrorFromVoid() throws {
    throw PigeonError(code: "code", message: "message", details: "details")
  }

  func throwFlutterError() throws -> Any? {
    throw PigeonError(code: "code", message: "message", details: "details")
  }

  func echo(_ anInt: Int64) -> Int64 {
    return anInt
  }

  func echo(_ aDouble: Double) -> Double {
    return aDouble
  }

  func echo(_ aBool: Bool) -> Bool {
    return aBool
  }

  func echo(_ aString: String) -> String {
    return aString
  }

  func echo(_ aUint8List: FlutterStandardTypedData) -> FlutterStandardTypedData {
    return aUint8List
  }

  func echo(_ anObject: Any) -> Any {
    return anObject
  }

  func echo(_ list: [Any?]) throws -> [Any?] {
    return list
  }

  func echo(_ aMap: [String?: Any?]) throws -> [String?: Any?] {
    return aMap
  }

  func echo(_ wrapper: AllClassesWrapper) throws -> AllClassesWrapper {
    return wrapper
  }

  func echo(_ anEnum: AnEnum) throws -> AnEnum {
    return anEnum
  }

  func extractNestedNullableString(from wrapper: AllClassesWrapper) -> String? {
    return wrapper.allNullableTypes.aNullableString
  }

  func createNestedObject(with nullableString: String?) -> AllClassesWrapper {
    return AllClassesWrapper(allNullableTypes: AllNullableTypes(aNullableString: nullableString))
  }

  func sendMultipleNullableTypes(
    aBool aNullableBool: Bool?, anInt aNullableInt: Int64?, aString aNullableString: String?
  ) -> AllNullableTypes {
    let someThings = AllNullableTypes(
      aNullableBool: aNullableBool, aNullableInt: aNullableInt, aNullableString: aNullableString)
    return someThings
  }

  func sendMultipleNullableTypesWithoutRecursion(
    aBool aNullableBool: Bool?, anInt aNullableInt: Int64?, aString aNullableString: String?
  ) throws -> AllNullableTypesWithoutRecursion {
    let someThings = AllNullableTypesWithoutRecursion(
      aNullableBool: aNullableBool, aNullableInt: aNullableInt, aNullableString: aNullableString)
    return someThings
  }

  func echo(_ aNullableInt: Int64?) -> Int64? {
    return aNullableInt
  }

  func echo(_ aNullableDouble: Double?) -> Double? {
    return aNullableDouble
  }

  func echo(_ aNullableBool: Bool?) -> Bool? {
    return aNullableBool
  }

  func echo(_ aNullableString: String?) -> String? {
    return aNullableString
  }

  func echo(_ aNullableUint8List: FlutterStandardTypedData?) -> FlutterStandardTypedData? {
    return aNullableUint8List
  }

  func echo(_ aNullableObject: Any?) -> Any? {
    return aNullableObject
  }

  func echoNamedDefault(_ aString: String) throws -> String {
    return aString
  }

  func echoOptionalDefault(_ aDouble: Double) throws -> Double {
    return aDouble
  }

  func echoRequired(_ anInt: Int64) throws -> Int64 {
    return anInt
  }

  func echoNullable(_ aNullableList: [Any?]?) throws -> [Any?]? {
    return aNullableList
  }

  func echoNullable(_ aNullableMap: [String?: Any?]?) throws -> [String?: Any?]? {
    return aNullableMap
  }

  func echoNullable(_ anEnum: AnEnum?) throws -> AnEnum? {
    return anEnum
  }

  func echoOptional(_ aNullableInt: Int64?) throws -> Int64? {
    return aNullableInt
  }

  func echoNamed(_ aNullableString: String?) throws -> String? {
    return aNullableString
  }

  func noopAsync(completion: @escaping (Result<Void, Error>) -> Void) {
    completion(.success(Void()))
  }

  func throwAsyncError(completion: @escaping (Result<Any?, Error>) -> Void) {
    completion(.failure(PigeonError(code: "code", message: "message", details: "details")))
  }

  func throwAsyncErrorFromVoid(completion: @escaping (Result<Void, Error>) -> Void) {
    completion(.failure(PigeonError(code: "code", message: "message", details: "details")))
  }

  func throwAsyncFlutterError(completion: @escaping (Result<Any?, Error>) -> Void) {
    completion(.failure(PigeonError(code: "code", message: "message", details: "details")))
  }

  func echoAsync(_ everything: AllTypes, completion: @escaping (Result<AllTypes, Error>) -> Void) {
    completion(.success(everything))
  }

  func echoAsync(
    _ everything: AllNullableTypes?,
    completion: @escaping (Result<AllNullableTypes?, Error>) -> Void
  ) {
    completion(.success(everything))
  }

  func echoAsync(
    _ everything: AllNullableTypesWithoutRecursion?,
    completion: @escaping (Result<AllNullableTypesWithoutRecursion?, Error>) -> Void
  ) {
    completion(.success(everything))
  }

  func echoAsync(_ anInt: Int64, completion: @escaping (Result<Int64, Error>) -> Void) {
    completion(.success(anInt))
  }

  func echoAsync(_ aDouble: Double, completion: @escaping (Result<Double, Error>) -> Void) {
    completion(.success(aDouble))
  }

  func echoAsync(_ aBool: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
    completion(.success(aBool))
  }

  func echoAsync(_ aString: String, completion: @escaping (Result<String, Error>) -> Void) {
    completion(.success(aString))
  }

  func echoAsync(
    _ aUint8List: FlutterStandardTypedData,
    completion: @escaping (Result<FlutterStandardTypedData, Error>) -> Void
  ) {
    completion(.success(aUint8List))
  }

  func echoAsync(_ anObject: Any, completion: @escaping (Result<Any, Error>) -> Void) {
    completion(.success(anObject))
  }

  func echoAsync(_ list: [Any?], completion: @escaping (Result<[Any?], Error>) -> Void) {
    completion(.success(list))
  }

  func echoAsync(
    _ aMap: [String?: Any?], completion: @escaping (Result<[String?: Any?], Error>) -> Void
  ) {
    completion(.success(aMap))
  }

  func echoAsync(_ anEnum: AnEnum, completion: @escaping (Result<AnEnum, Error>) -> Void) {
    completion(.success(anEnum))
  }

  func echoAsyncNullable(_ anInt: Int64?, completion: @escaping (Result<Int64?, Error>) -> Void) {
    completion(.success(anInt))
  }

  func echoAsyncNullable(_ aDouble: Double?, completion: @escaping (Result<Double?, Error>) -> Void)
  {
    completion(.success(aDouble))
  }

  func echoAsyncNullable(_ aBool: Bool?, completion: @escaping (Result<Bool?, Error>) -> Void) {
    completion(.success(aBool))
  }

  func echoAsyncNullable(_ aString: String?, completion: @escaping (Result<String?, Error>) -> Void)
  {
    completion(.success(aString))
  }

  func echoAsyncNullable(
    _ aUint8List: FlutterStandardTypedData?,
    completion: @escaping (Result<FlutterStandardTypedData?, Error>) -> Void
  ) {
    completion(.success(aUint8List))
  }

  func echoAsyncNullable(_ anObject: Any?, completion: @escaping (Result<Any?, Error>) -> Void) {
    completion(.success(anObject))
  }

  func echoAsyncNullable(_ list: [Any?]?, completion: @escaping (Result<[Any?]?, Error>) -> Void) {
    completion(.success(list))
  }

  func echoAsyncNullable(
    _ aMap: [String?: Any?]?, completion: @escaping (Result<[String?: Any?]?, Error>) -> Void
  ) {
    completion(.success(aMap))
  }

  func echoAsyncNullable(_ anEnum: AnEnum?, completion: @escaping (Result<AnEnum?, Error>) -> Void)
  {
    completion(.success(anEnum))
  }

  func callFlutterNoop(completion: @escaping (Result<Void, Error>) -> Void) {
    flutterAPI.noop { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterThrowError(completion: @escaping (Result<Any?, Error>) -> Void) {
    flutterAPI.throwError { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterThrowErrorFromVoid(completion: @escaping (Result<Void, Error>) -> Void) {
    flutterAPI.throwErrorFromVoid { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(
    _ everything: AllTypes, completion: @escaping (Result<AllTypes, Error>) -> Void
  ) {
    flutterAPI.echo(everything) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(
    _ everything: AllNullableTypes?,
    completion: @escaping (Result<AllNullableTypes?, Error>) -> Void
  ) {
    flutterAPI.echoNullable(everything) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(
    _ everything: AllNullableTypesWithoutRecursion?,
    completion: @escaping (Result<AllNullableTypesWithoutRecursion?, Error>) -> Void
  ) {
    flutterAPI.echoNullable(everything) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterSendMultipleNullableTypes(
    aBool aNullableBool: Bool?,
    anInt aNullableInt: Int64?,
    aString aNullableString: String?,
    completion: @escaping (Result<AllNullableTypes, Error>) -> Void
  ) {
    flutterAPI.sendMultipleNullableTypes(
      aBool: aNullableBool,
      anInt: aNullableInt,
      aString: aNullableString
    ) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterSendMultipleNullableTypesWithoutRecursion(
    aBool aNullableBool: Bool?, anInt aNullableInt: Int64?, aString aNullableString: String?,
    completion: @escaping (Result<AllNullableTypesWithoutRecursion, Error>) -> Void
  ) {
    flutterAPI.sendMultipleNullableTypesWithoutRecursion(
      aBool: aNullableBool,
      anInt: aNullableInt,
      aString: aNullableString
    ) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(_ aBool: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
    flutterAPI.echo(aBool) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(_ anInt: Int64, completion: @escaping (Result<Int64, Error>) -> Void) {
    flutterAPI.echo(anInt) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(_ aDouble: Double, completion: @escaping (Result<Double, Error>) -> Void) {
    flutterAPI.echo(aDouble) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(_ aString: String, completion: @escaping (Result<String, Error>) -> Void) {
    flutterAPI.echo(aString) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(
    _ list: FlutterStandardTypedData,
    completion: @escaping (Result<FlutterStandardTypedData, Error>) -> Void
  ) {
    flutterAPI.echo(list) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(_ list: [Any?], completion: @escaping (Result<[Any?], Error>) -> Void) {
    flutterAPI.echo(list) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(
    _ aMap: [String?: Any?], completion: @escaping (Result<[String?: Any?], Error>) -> Void
  ) {
    flutterAPI.echo(aMap) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEcho(_ anEnum: AnEnum, completion: @escaping (Result<AnEnum, Error>) -> Void) {
    flutterAPI.echo(anEnum) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEchoNullable(_ aBool: Bool?, completion: @escaping (Result<Bool?, Error>) -> Void)
  {
    flutterAPI.echoNullable(aBool) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEchoNullable(
    _ anInt: Int64?, completion: @escaping (Result<Int64?, Error>) -> Void
  ) {
    flutterAPI.echoNullable(anInt) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEchoNullable(
    _ aDouble: Double?, completion: @escaping (Result<Double?, Error>) -> Void
  ) {
    flutterAPI.echoNullable(aDouble) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEchoNullable(
    _ aString: String?, completion: @escaping (Result<String?, Error>) -> Void
  ) {
    flutterAPI.echoNullable(aString) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEchoNullable(
    _ list: FlutterStandardTypedData?,
    completion: @escaping (Result<FlutterStandardTypedData?, Error>) -> Void
  ) {
    flutterAPI.echoNullable(list) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEchoNullable(
    _ list: [Any?]?, completion: @escaping (Result<[Any?]?, Error>) -> Void
  ) {
    flutterAPI.echoNullable(list) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterEchoNullable(
    _ aMap: [String?: Any?]?, completion: @escaping (Result<[String?: Any?]?, Error>) -> Void
  ) {
    flutterAPI.echoNullable(aMap) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterNullableEcho(
    _ anEnum: AnEnum?, completion: @escaping (Result<AnEnum?, Error>) -> Void
  ) {
    flutterAPI.echoNullable(anEnum) { response in
      switch response {
      case .success(let res):
        completion(.success(res))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func callFlutterSmallApiEcho(
    _ aString: String, completion: @escaping (Result<String, Error>) -> Void
  ) {
    flutterSmallApiOne.echo(string: aString) { responseOne in
      self.flutterSmallApiTwo.echo(string: aString) { responseTwo in
        switch responseOne {
        case .success(let resOne):
          switch responseTwo {
          case .success(let resTwo):
            if resOne == resTwo {
              completion(.success(resOne))
            } else {
              completion(
                .failure(
                  PigeonError(
                    code: "",
                    message: "Multi-instance responses were not matching: \(resOne), \(resTwo)",
                    details: nil)))
            }
          case .failure(let error):
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}

public class TestPluginWithSuffix: HostSmallApi {
  public static func register(with registrar: FlutterPluginRegistrar, suffix: String) {
    let plugin = TestPluginWithSuffix()
    HostSmallApiSetup.setUp(
      binaryMessenger: registrar.messenger(), api: plugin, messageChannelSuffix: suffix)
  }

  func echo(aString: String, completion: @escaping (Result<String, Error>) -> Void) {
    completion(.success(aString))
  }

  func voidVoid(completion: @escaping (Result<Void, Error>) -> Void) {
    completion(.success(Void()))
  }

}

class ProxyApiDelegate: PigeonProxyApiDelegate {
  func pigeonApiProxyApiTestClass(_ registrar: PigeonProxyApiRegistrar)
    -> PigeonApiProxyApiTestClass
  {
    class ProxyApiTestClassDelegate: PigeonDelegateProxyApiTestClass {
      func pigeonDefaultConstructor(
        pigeonApi: PigeonApiProxyApiTestClass, aBool: Bool, anInt: Int64, aDouble: Double,
        aString: String, aUint8List: FlutterStandardTypedData, aList: [Any?], aMap: [String?: Any?],
        anEnum: ProxyApiTestEnum, aProxyApi: ProxyApiSuperClass, aNullableBool: Bool?,
        aNullableInt: Int64?, aNullableDouble: Double?, aNullableString: String?,
        aNullableUint8List: FlutterStandardTypedData?, aNullableList: [Any?]?,
        aNullableMap: [String?: Any?]?, aNullableEnum: ProxyApiTestEnum?,
        aNullableProxyApi: ProxyApiSuperClass?, boolParam: Bool, intParam: Int64,
        doubleParam: Double, stringParam: String, aUint8ListParam: FlutterStandardTypedData,
        listParam: [Any?], mapParam: [String?: Any?], enumParam: ProxyApiTestEnum,
        proxyApiParam: ProxyApiSuperClass, nullableBoolParam: Bool?, nullableIntParam: Int64?,
        nullableDoubleParam: Double?, nullableStringParam: String?,
        nullableUint8ListParam: FlutterStandardTypedData?, nullableListParam: [Any?]?,
        nullableMapParam: [String?: Any?]?, nullableEnumParam: ProxyApiTestEnum?,
        nullableProxyApiParam: ProxyApiSuperClass?
      ) throws -> ProxyApiTestClass {
        return ProxyApiTestClass()
      }

      func attachedField(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> ProxyApiSuperClass
      {
        return ProxyApiSuperClass()
      }

      func staticAttachedField(pigeonApi: PigeonApiProxyApiTestClass) throws -> ProxyApiSuperClass {
        return ProxyApiSuperClass()
      }

      func aBool(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass) throws
        -> Bool
      {
        return true
      }

      func anInt(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass) throws
        -> Int64
      {
        return 0
      }

      func aDouble(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass) throws
        -> Double
      {
        return 0.0
      }

      func aString(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass) throws
        -> String
      {
        return ""
      }

      func aUint8List(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> FlutterStandardTypedData
      {
        return FlutterStandardTypedData(bytes: Data())
      }

      func aList(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass) throws
        -> [Any?]
      {
        return []
      }

      func aMap(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass) throws
        -> [String?: Any?]
      {
        return [:]
      }

      func anEnum(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass) throws
        -> ProxyApiTestEnum
      {
        return ProxyApiTestEnum.one
      }

      func aProxyApi(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> ProxyApiSuperClass
      {
        return ProxyApiSuperClass()
      }

      func aNullableBool(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> Bool?
      {
        return nil
      }

      func aNullableInt(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> Int64?
      {
        return nil
      }

      func aNullableDouble(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> Double?
      {
        return nil
      }

      func aNullableString(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> String?
      {
        return nil
      }

      func aNullableUint8List(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass
      ) throws -> FlutterStandardTypedData? {
        return nil
      }

      func aNullableList(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> [Any?]?
      {
        return nil
      }

      func aNullableMap(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> [String?: Any?]?
      {
        return nil
      }

      func aNullableEnum(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> ProxyApiTestEnum?
      {
        return nil
      }

      func aNullableProxyApi(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass
      ) throws -> ProxyApiSuperClass? {
        return nil
      }

      func noop(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass) throws {
      }

      func throwError(pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass)
        throws -> Any?
      {
        throw ProxyApiTestsError(code: "code", message: "message", details: "details")
      }

      func throwErrorFromVoid(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass
      ) throws {
        throw ProxyApiTestsError(code: "code", message: "message", details: "details")
      }

      func throwFlutterError(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass
      ) throws -> Any? {
        throw ProxyApiTestsError(code: "code", message: "message", details: "details")
      }

      func echoInt(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, anInt: Int64
      ) throws -> Int64 {
        return anInt
      }

      func echoDouble(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aDouble: Double
      ) throws -> Double {
        return aDouble
      }

      func echoBool(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aBool: Bool
      ) throws -> Bool {
        return aBool
      }

      func echoString(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aString: String
      ) throws -> String {
        return aString
      }

      func echoUint8List(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aUint8List: FlutterStandardTypedData
      ) throws -> FlutterStandardTypedData {
        return aUint8List
      }

      func echoObject(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, anObject: Any
      ) throws -> Any {
        return anObject
      }

      func echoList(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aList: [Any?]
      ) throws -> [Any?] {
        return aList
      }

      func echoProxyApiList(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aList: [ProxyApiTestClass]
      ) throws -> [ProxyApiTestClass] {
        return aList
      }

      func echoMap(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aMap: [String?: Any?]
      ) throws -> [String?: Any?] {
        return aMap
      }

      func echoProxyApiMap(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aMap: [String: ProxyApiTestClass]
      ) throws -> [String: ProxyApiTestClass] {
        return aMap
      }

      func echoEnum(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        anEnum: ProxyApiTestEnum
      ) throws -> ProxyApiTestEnum {
        return anEnum
      }

      func echoProxyApi(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aProxyApi: ProxyApiSuperClass
      ) throws -> ProxyApiSuperClass {
        return aProxyApi
      }

      func echoNullableInt(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableInt: Int64?
      ) throws -> Int64? {
        return aNullableInt
      }

      func echoNullableDouble(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableDouble: Double?
      ) throws -> Double? {
        return aNullableDouble
      }

      func echoNullableBool(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableBool: Bool?
      ) throws -> Bool? {
        return aNullableBool
      }

      func echoNullableString(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableString: String?
      ) throws -> String? {
        return aNullableString
      }

      func echoNullableUint8List(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableUint8List: FlutterStandardTypedData?
      ) throws -> FlutterStandardTypedData? {
        return aNullableUint8List
      }

      func echoNullableObject(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableObject: Any?
      ) throws -> Any? {
        return aNullableObject
      }

      func echoNullableList(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableList: [Any?]?
      ) throws -> [Any?]? {
        return aNullableList
      }

      func echoNullableMap(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableMap: [String?: Any?]?
      ) throws -> [String?: Any?]? {
        return aNullableMap
      }

      func echoNullableEnum(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableEnum: ProxyApiTestEnum?
      ) throws -> ProxyApiTestEnum? {
        return aNullableEnum
      }

      func echoNullableProxyApi(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aNullableProxyApi: ProxyApiSuperClass?
      ) throws -> ProxyApiSuperClass? {
        return aNullableProxyApi
      }

      func noopAsync(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        completion: @escaping (Result<Void, Error>) -> Void
      ) {
        completion(.success(Void()))
      }

      func echoAsyncInt(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, anInt: Int64,
        completion: @escaping (Result<Int64, Error>) -> Void
      ) {
        completion(.success(anInt))
      }

      func echoAsyncDouble(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aDouble: Double,
        completion: @escaping (Result<Double, Error>) -> Void
      ) {
        completion(.success(aDouble))
      }

      func echoAsyncBool(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aBool: Bool,
        completion: @escaping (Result<Bool, Error>) -> Void
      ) {
        completion(.success(aBool))
      }

      func echoAsyncString(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aString: String,
        completion: @escaping (Result<String, Error>) -> Void
      ) {
        completion(.success(aString))
      }

      func echoAsyncUint8List(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aUint8List: FlutterStandardTypedData,
        completion: @escaping (Result<FlutterStandardTypedData, Error>) -> Void
      ) {
        completion(.success(aUint8List))
      }

      func echoAsyncObject(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, anObject: Any,
        completion: @escaping (Result<Any, Error>) -> Void
      ) {
        completion(.success(anObject))
      }

      func echoAsyncList(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aList: [Any?],
        completion: @escaping (Result<[Any?], Error>) -> Void
      ) {
        completion(.success(aList))
      }

      func echoAsyncMap(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aMap: [String?: Any?], completion: @escaping (Result<[String?: Any?], Error>) -> Void
      ) {
        completion(.success(aMap))
      }

      func echoAsyncEnum(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        anEnum: ProxyApiTestEnum, completion: @escaping (Result<ProxyApiTestEnum, Error>) -> Void
      ) {
        completion(.success(anEnum))
      }

      func throwAsyncError(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        completion: @escaping (Result<Any?, Error>) -> Void
      ) {
        completion(
          .failure(ProxyApiTestsError(code: "code", message: "message", details: "details")))
      }

      func throwAsyncErrorFromVoid(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        completion: @escaping (Result<Void, Error>) -> Void
      ) {
        completion(
          .failure(ProxyApiTestsError(code: "code", message: "message", details: "details")))
      }

      func throwAsyncFlutterError(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        completion: @escaping (Result<Any?, Error>) -> Void
      ) {
        completion(
          .failure(ProxyApiTestsError(code: "code", message: "message", details: "details")))
      }

      func echoAsyncNullableInt(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, anInt: Int64?,
        completion: @escaping (Result<Int64?, Error>) -> Void
      ) {
        completion(.success(anInt))
      }

      func echoAsyncNullableDouble(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aDouble: Double?,
        completion: @escaping (Result<Double?, Error>) -> Void
      ) {
        completion(.success(aDouble))
      }

      func echoAsyncNullableBool(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aBool: Bool?,
        completion: @escaping (Result<Bool?, Error>) -> Void
      ) {
        completion(.success(aBool))
      }

      func echoAsyncNullableString(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aString: String?,
        completion: @escaping (Result<String?, Error>) -> Void
      ) {
        completion(.success(aString))
      }

      func echoAsyncNullableUint8List(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aUint8List: FlutterStandardTypedData?,
        completion: @escaping (Result<FlutterStandardTypedData?, Error>) -> Void
      ) {
        completion(.success(aUint8List))
      }

      func echoAsyncNullableObject(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, anObject: Any?,
        completion: @escaping (Result<Any?, Error>) -> Void
      ) {
        completion(.success(anObject))
      }

      func echoAsyncNullableList(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aList: [Any?]?,
        completion: @escaping (Result<[Any?]?, Error>) -> Void
      ) {
        completion(.success(aList))
      }

      func echoAsyncNullableMap(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aMap: [String?: Any?]?, completion: @escaping (Result<[String?: Any?]?, Error>) -> Void
      ) {
        completion(.success(aMap))
      }

      func echoAsyncNullableEnum(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        anEnum: ProxyApiTestEnum?, completion: @escaping (Result<ProxyApiTestEnum?, Error>) -> Void
      ) {
        completion(.success(anEnum))
      }

      func staticNoop(pigeonApi: PigeonApiProxyApiTestClass) throws {

      }

      func echoStaticString(pigeonApi: PigeonApiProxyApiTestClass, aString: String) throws -> String
      {
        return aString
      }

      func staticAsyncNoop(
        pigeonApi: PigeonApiProxyApiTestClass, completion: @escaping (Result<Void, Error>) -> Void
      ) {
        completion(.success(Void()))
      }

      func callFlutterNoop(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        completion: @escaping (Result<Void, Error>) -> Void
      ) {
        pigeonApi.flutterNoop(pigeonInstance: pigeonInstance) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterThrowError(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        completion: @escaping (Result<Any?, Error>) -> Void
      ) {
        pigeonApi.flutterThrowError(pigeonInstance: pigeonInstance) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterThrowErrorFromVoid(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        completion: @escaping (Result<Void, Error>) -> Void
      ) {
        pigeonApi.flutterThrowErrorFromVoid(pigeonInstance: pigeonInstance) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoBool(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aBool: Bool,
        completion: @escaping (Result<Bool, Error>) -> Void
      ) {
        pigeonApi.flutterEchoBool(pigeonInstance: pigeonInstance, aBool: aBool) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoInt(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, anInt: Int64,
        completion: @escaping (Result<Int64, Error>) -> Void
      ) {
        pigeonApi.flutterEchoInt(pigeonInstance: pigeonInstance, anInt: anInt) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoDouble(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aDouble: Double,
        completion: @escaping (Result<Double, Error>) -> Void
      ) {
        pigeonApi.flutterEchoDouble(pigeonInstance: pigeonInstance, aDouble: aDouble) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoString(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aString: String,
        completion: @escaping (Result<String, Error>) -> Void
      ) {
        pigeonApi.flutterEchoString(pigeonInstance: pigeonInstance, aString: aString) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoUint8List(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aUint8List: FlutterStandardTypedData,
        completion: @escaping (Result<FlutterStandardTypedData, Error>) -> Void
      ) {
        pigeonApi.flutterEchoUint8List(pigeonInstance: pigeonInstance, aList: aUint8List) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoList(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aList: [Any?],
        completion: @escaping (Result<[Any?], Error>) -> Void
      ) {
        pigeonApi.flutterEchoList(pigeonInstance: pigeonInstance, aList: aList) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoProxyApiList(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aList: [ProxyApiTestClass?],
        completion: @escaping (Result<[ProxyApiTestClass?], Error>) -> Void
      ) {
        pigeonApi.flutterEchoProxyApiList(pigeonInstance: pigeonInstance, aList: aList) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoMap(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aMap: [String?: Any?], completion: @escaping (Result<[String?: Any?], Error>) -> Void
      ) {
        pigeonApi.flutterEchoMap(pigeonInstance: pigeonInstance, aMap: aMap) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoProxyApiMap(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aMap: [String?: ProxyApiTestClass?],
        completion: @escaping (Result<[String?: ProxyApiTestClass?], Error>) -> Void
      ) {
        pigeonApi.flutterEchoProxyApiMap(pigeonInstance: pigeonInstance, aMap: aMap) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoEnum(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        anEnum: ProxyApiTestEnum, completion: @escaping (Result<ProxyApiTestEnum, Error>) -> Void
      ) {
        pigeonApi.flutterEchoEnum(pigeonInstance: pigeonInstance, anEnum: anEnum) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoProxyApi(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aProxyApi: ProxyApiSuperClass,
        completion: @escaping (Result<ProxyApiSuperClass, Error>) -> Void
      ) {
        pigeonApi.flutterEchoProxyApi(pigeonInstance: pigeonInstance, aProxyApi: aProxyApi) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoNullableBool(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aBool: Bool?,
        completion: @escaping (Result<Bool?, Error>) -> Void
      ) {
        pigeonApi.flutterEchoNullableBool(pigeonInstance: pigeonInstance, aBool: aBool) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoNullableInt(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, anInt: Int64?,
        completion: @escaping (Result<Int64?, Error>) -> Void
      ) {
        pigeonApi.flutterEchoNullableInt(pigeonInstance: pigeonInstance, anInt: anInt) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoNullableDouble(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aDouble: Double?,
        completion: @escaping (Result<Double?, Error>) -> Void
      ) {
        pigeonApi.flutterEchoNullableDouble(pigeonInstance: pigeonInstance, aDouble: aDouble) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoNullableString(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aString: String?,
        completion: @escaping (Result<String?, Error>) -> Void
      ) {
        pigeonApi.flutterEchoNullableString(pigeonInstance: pigeonInstance, aString: aString) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoNullableUint8List(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aUint8List: FlutterStandardTypedData?,
        completion: @escaping (Result<FlutterStandardTypedData?, Error>) -> Void
      ) {
        pigeonApi.flutterEchoNullableUint8List(pigeonInstance: pigeonInstance, aList: aUint8List) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoNullableList(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aList: [Any?]?,
        completion: @escaping (Result<[Any?]?, Error>) -> Void
      ) {
        pigeonApi.flutterEchoNullableList(pigeonInstance: pigeonInstance, aList: aList) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoNullableMap(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aMap: [String?: Any?]?, completion: @escaping (Result<[String?: Any?]?, Error>) -> Void
      ) {
        pigeonApi.flutterEchoNullableMap(pigeonInstance: pigeonInstance, aMap: aMap) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoNullableEnum(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        anEnum: ProxyApiTestEnum?, completion: @escaping (Result<ProxyApiTestEnum?, Error>) -> Void
      ) {
        pigeonApi.flutterEchoNullableEnum(pigeonInstance: pigeonInstance, anEnum: anEnum) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoNullableProxyApi(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        aProxyApi: ProxyApiSuperClass?,
        completion: @escaping (Result<ProxyApiSuperClass?, Error>) -> Void
      ) {
        pigeonApi.flutterEchoNullableProxyApi(pigeonInstance: pigeonInstance, aProxyApi: aProxyApi)
        { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterNoopAsync(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass,
        completion: @escaping (Result<Void, Error>) -> Void
      ) {
        pigeonApi.flutterNoopAsync(pigeonInstance: pigeonInstance) { response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

      func callFlutterEchoAsyncString(
        pigeonApi: PigeonApiProxyApiTestClass, pigeonInstance: ProxyApiTestClass, aString: String,
        completion: @escaping (Result<String, Error>) -> Void
      ) {
        pigeonApi.flutterEchoAsyncString(pigeonInstance: pigeonInstance, aString: aString) {
          response in
          switch response {
          case .success(let res):
            completion(.success(res))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      }

    }
    return PigeonApiProxyApiTestClass(
      pigeonRegistrar: registrar, delegate: ProxyApiTestClassDelegate())
  }

  func pigeonApiProxyApiSuperClass(_ registrar: PigeonProxyApiRegistrar)
    -> PigeonApiProxyApiSuperClass
  {
    class ProxyApiSuperClassDelegate: PigeonDelegateProxyApiSuperClass {
      func pigeonDefaultConstructor(pigeonApi: PigeonApiProxyApiSuperClass) throws
        -> ProxyApiSuperClass
      {
        return ProxyApiSuperClass()
      }

      func aSuperMethod(pigeonApi: PigeonApiProxyApiSuperClass, pigeonInstance: ProxyApiSuperClass)
        throws
      {}
    }
    return PigeonApiProxyApiSuperClass(
      pigeonRegistrar: registrar, delegate: ProxyApiSuperClassDelegate())
  }

  func pigeonApiProxyApiInterface(_ registrar: PigeonProxyApiRegistrar)
    -> PigeonApiProxyApiInterface
  {
    class ProxyApiInterfaceDelegate: PigeonDelegateProxyApiInterface {}
    return PigeonApiProxyApiInterface(
      pigeonRegistrar: registrar, delegate: ProxyApiInterfaceDelegate())
  }
}
