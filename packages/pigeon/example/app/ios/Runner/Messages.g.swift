// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v10.1.1), do not edit directly.
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
  return value as! T?
}

enum Code: Int {
  case one = 0
  case two = 1
}

/// Generated class from Pigeon that represents data sent in messages.
struct MessageData {
  var name: String? = nil
  var description: String? = nil
  var code: Code
  var data: [String?: String?]

  static func fromList(_ list: [Any?]) -> MessageData? {
    let name: String? = nilOrValue(list[0])
    let description: String? = nilOrValue(list[1])
    let code = Code(rawValue: list[2] as! Int)!
    let data = list[3] as! [String?: String?]

    return MessageData(
      name: name,
      description: description,
      code: code,
      data: data
    )
  }
  func toList() -> [Any?] {
    return [
      name,
      description,
      code.rawValue,
      data,
    ]
  }
}

private class ExampleHostApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return MessageData.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class ExampleHostApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? MessageData {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class ExampleHostApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return ExampleHostApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return ExampleHostApiCodecWriter(data: data)
  }
}

class ExampleHostApiCodec: FlutterStandardMessageCodec {
  static let shared = ExampleHostApiCodec(readerWriter: ExampleHostApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol ExampleHostApi {
  func getHostLanguage() throws -> String
  func add(number a: Int64, otherNumber b: Int64) throws -> Int64
  func sendMessage(message: MessageData, completion: @escaping (Result<Bool, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class ExampleHostApiSetup {
  /// The codec used by ExampleHostApi.
  static var codec: FlutterStandardMessageCodec { ExampleHostApiCodec.shared }
  /// Sets up an instance of `ExampleHostApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: ExampleHostApi?) {
    let getHostLanguageChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ExampleHostApi.getHostLanguage", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getHostLanguageChannel.setMessageHandler { _, reply in
        do {
          let result = try api.getHostLanguage()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getHostLanguageChannel.setMessageHandler(nil)
    }
    let addChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ExampleHostApi.add", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      addChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let aArg = args[0] is Int64 ? args[0] as! Int64 : Int64(args[0] as! Int32)
        let bArg = args[1] is Int64 ? args[1] as! Int64 : Int64(args[1] as! Int32)
        do {
          let result = try api.add(number: aArg, otherNumber: bArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      addChannel.setMessageHandler(nil)
    }
    let sendMessageChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.ExampleHostApi.sendMessage", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      sendMessageChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let messageArg = args[0] as! MessageData
        api.sendMessage(message: messageArg) { result in
          switch result {
            case .success(let res):
              reply(wrapResult(res))
            case .failure(let error):
              reply(wrapError(error))
          }
        }
      }
    } else {
      sendMessageChannel.setMessageHandler(nil)
    }
  }
}
/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class MessageFlutterApi {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
  func flutterMethod(aString aStringArg: String?, completion: @escaping (String) -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.MessageFlutterApi.flutterMethod", binaryMessenger: binaryMessenger)
    channel.sendMessage([aStringArg] as [Any?]) { response in
      let result = response as! String
      completion(result)
    }
  }
}
