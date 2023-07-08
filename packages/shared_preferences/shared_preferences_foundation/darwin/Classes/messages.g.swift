// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v9.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return (value as Any) as! T?
}
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol UserDefaultsApi {
  func remove(key: String) throws
  func setBool(key: String, value: Bool) throws
  func setDouble(key: String, value: Double) throws
  func setValue(key: String, value: Any) throws
  func getAll(prefix: String, allowList: [String]?) throws -> [String?: Any?]
  func clear(prefix: String, allowList: [String]?) throws -> Bool
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class UserDefaultsApiSetup {
  /// The codec used by UserDefaultsApi.
  /// Sets up an instance of `UserDefaultsApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: UserDefaultsApi?) {
    let removeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.remove", binaryMessenger: binaryMessenger)
    if let api = api {
      removeChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let keyArg = args[0] as! String
        do {
          try api.remove(key: keyArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      removeChannel.setMessageHandler(nil)
    }
    let setBoolChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.setBool", binaryMessenger: binaryMessenger)
    if let api = api {
      setBoolChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let keyArg = args[0] as! String
        let valueArg = args[1] as! Bool
        do {
          try api.setBool(key: keyArg, value: valueArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setBoolChannel.setMessageHandler(nil)
    }
    let setDoubleChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.setDouble", binaryMessenger: binaryMessenger)
    if let api = api {
      setDoubleChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let keyArg = args[0] as! String
        let valueArg = args[1] as! Double
        do {
          try api.setDouble(key: keyArg, value: valueArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setDoubleChannel.setMessageHandler(nil)
    }
    let setValueChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.setValue", binaryMessenger: binaryMessenger)
    if let api = api {
      setValueChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let keyArg = args[0] as! String
        let valueArg = args[1]
        do {
          try api.setValue(key: keyArg, value: valueArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setValueChannel.setMessageHandler(nil)
    }
    let getAllChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.getAll", binaryMessenger: binaryMessenger)
    if let api = api {
      getAllChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let prefixArg = args[0] as! String
        let allowListArg: [String]? = nilOrValue(args[1])
        do {
          let result = try api.getAll(prefix: prefixArg, allowList: allowListArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getAllChannel.setMessageHandler(nil)
    }
    let clearChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.clear", binaryMessenger: binaryMessenger)
    if let api = api {
      clearChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let prefixArg = args[0] as! String
        let allowListArg: [String]? = nilOrValue(args[1])
        do {
          let result = try api.clear(prefix: prefixArg, allowList: allowListArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      clearChannel.setMessageHandler(nil)
    }
  }
}
