// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v21.1.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

/// Error class for passing custom error details to Dart side.
final class PigeonError: Error {
  let code: String
  let message: String?
  let details: Any?

  init(code: String, message: String?, details: Any?) {
    self.code = code
    self.message = message
    self.details = details
  }

  var localizedDescription: String {
    return
      "PigeonError(code: \(code), message: \(message ?? "<nil>"), details: \(details ?? "<nil>")"
      }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum SK2ProductTypeMessage: Int {
  /// A consumable in-app purchase.
  case consumable = 0
  /// A non-consumable in-app purchase.
  case nonConsumable = 1
  /// A non-renewing subscription.
  case nonRenewable = 2
  /// An auto-renewable subscription.
  case autoRenewable = 3
}

enum SK2SubscriptionOfferTypeMessage: Int {
  case introductory = 0
  case promotional = 1
}

enum SK2SubscriptionOfferPaymentModeMessage: Int {
  case payAsYouGo = 0
  case payUpFront = 1
  case freeTrial = 2
}

enum SK2SubscriptionPeriodUnitMessage: Int {
  case day = 0
  case week = 1
  case month = 2
  case year = 3
}

/// Generated class from Pigeon that represents data sent in messages.
struct SK2SubscriptionOfferMessage {
  var id: String? = nil
  var price: Double
  var type: SK2SubscriptionOfferTypeMessage
  var period: SK2SubscriptionPeriodMessage
  var periodCount: Int64
  var paymentMode: SK2SubscriptionOfferPaymentModeMessage

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ __pigeon_list: [Any?]) -> SK2SubscriptionOfferMessage? {
    let id: String? = nilOrValue(__pigeon_list[0])
    let price = __pigeon_list[1] as! Double
    let type = __pigeon_list[2] as! SK2SubscriptionOfferTypeMessage
    let period = __pigeon_list[3] as! SK2SubscriptionPeriodMessage
    let periodCount = __pigeon_list[4] is Int64 ? __pigeon_list[4] as! Int64 : Int64(__pigeon_list[4] as! Int32)
    let paymentMode = __pigeon_list[5] as! SK2SubscriptionOfferPaymentModeMessage

    return SK2SubscriptionOfferMessage(
      id: id,
      price: price,
      type: type,
      period: period,
      periodCount: periodCount,
      paymentMode: paymentMode
    )
  }
  func toList() -> [Any?] {
    return [
      id,
      price,
      type,
      period,
      periodCount,
      paymentMode,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct SK2SubscriptionPeriodMessage {
  /// The number of units that the period represents.
  var value: Int64
  /// The unit of time that this period represents.
  var unit: SK2SubscriptionPeriodUnitMessage

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ __pigeon_list: [Any?]) -> SK2SubscriptionPeriodMessage? {
    let value = __pigeon_list[0] is Int64 ? __pigeon_list[0] as! Int64 : Int64(__pigeon_list[0] as! Int32)
    let unit = __pigeon_list[1] as! SK2SubscriptionPeriodUnitMessage

    return SK2SubscriptionPeriodMessage(
      value: value,
      unit: unit
    )
  }
  func toList() -> [Any?] {
    return [
      value,
      unit,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct SK2SubscriptionInfoMessage {
  /// An array of all the promotional offers configured for this subscription.
  /// This should be List<SK2SubscriptionOfferMessage> but pigeon doesnt support
  /// null-safe generics. https://github.com/flutter/flutter/issues/97848
  var promotionalOffers: [SK2SubscriptionOfferMessage?]
  /// The group identifier for this subscription.
  var subscriptionGroupID: String
  /// The duration that this subscription lasts before auto-renewing.
  var subscriptionPeriod: SK2SubscriptionPeriodMessage

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ __pigeon_list: [Any?]) -> SK2SubscriptionInfoMessage? {
    let promotionalOffers = __pigeon_list[0] as! [SK2SubscriptionOfferMessage?]
    let subscriptionGroupID = __pigeon_list[1] as! String
    let subscriptionPeriod = __pigeon_list[2] as! SK2SubscriptionPeriodMessage

    return SK2SubscriptionInfoMessage(
      promotionalOffers: promotionalOffers,
      subscriptionGroupID: subscriptionGroupID,
      subscriptionPeriod: subscriptionPeriod
    )
  }
  func toList() -> [Any?] {
    return [
      promotionalOffers,
      subscriptionGroupID,
      subscriptionPeriod,
    ]
  }
}

/// A Pigeon message class representing a Product
/// https://developer.apple.com/documentation/storekit/product
///
/// Generated class from Pigeon that represents data sent in messages.
struct SK2ProductMessage {
  /// The unique product identifier.
  var id: String
  /// The localized display name of the product, if it exists.
  var displayName: String
  /// The localized description of the product.
  var description: String
  /// The localized string representation of the product price, suitable for display.
  var price: Double
  /// The localized price of the product as a string.
  var displayPrice: String
  /// The types of in-app purchases.
  var type: SK2ProductTypeMessage
  /// The subscription information for an auto-renewable subscription.
  var subscription: SK2SubscriptionInfoMessage? = nil
  /// The currency and locale information for this product
  var priceLocale: SK2PriceLocaleMessage

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ __pigeon_list: [Any?]) -> SK2ProductMessage? {
    let id = __pigeon_list[0] as! String
    let displayName = __pigeon_list[1] as! String
    let description = __pigeon_list[2] as! String
    let price = __pigeon_list[3] as! Double
    let displayPrice = __pigeon_list[4] as! String
    let type = __pigeon_list[5] as! SK2ProductTypeMessage
    let subscription: SK2SubscriptionInfoMessage? = nilOrValue(__pigeon_list[6])
    let priceLocale = __pigeon_list[7] as! SK2PriceLocaleMessage

    return SK2ProductMessage(
      id: id,
      displayName: displayName,
      description: description,
      price: price,
      displayPrice: displayPrice,
      type: type,
      subscription: subscription,
      priceLocale: priceLocale
    )
  }
  func toList() -> [Any?] {
    return [
      id,
      displayName,
      description,
      price,
      displayPrice,
      type,
      subscription,
      priceLocale,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct SK2PriceLocaleMessage {
  var currencyCode: String
  var currencySymbol: String

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ __pigeon_list: [Any?]) -> SK2PriceLocaleMessage? {
    let currencyCode = __pigeon_list[0] as! String
    let currencySymbol = __pigeon_list[1] as! String

    return SK2PriceLocaleMessage(
      currencyCode: currencyCode,
      currencySymbol: currencySymbol
    )
  }
  func toList() -> [Any?] {
    return [
      currencyCode,
      currencySymbol,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct SK2TransactionMessage {
  var id: Int64
  var originalId: Int64
  var productId: String
  var purchaseDate: String
  var purchasedQuantity: Int64
  var appAccountToken: String? = nil

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ __pigeon_list: [Any?]) -> SK2TransactionMessage? {
    let id = __pigeon_list[0] is Int64 ? __pigeon_list[0] as! Int64 : Int64(__pigeon_list[0] as! Int32)
    let originalId = __pigeon_list[1] is Int64 ? __pigeon_list[1] as! Int64 : Int64(__pigeon_list[1] as! Int32)
    let productId = __pigeon_list[2] as! String
    let purchaseDate = __pigeon_list[3] as! String
    let purchasedQuantity = __pigeon_list[4] is Int64 ? __pigeon_list[4] as! Int64 : Int64(__pigeon_list[4] as! Int32)
    let appAccountToken: String? = nilOrValue(__pigeon_list[5])

    return SK2TransactionMessage(
      id: id,
      originalId: originalId,
      productId: productId,
      purchaseDate: purchaseDate,
      purchasedQuantity: purchasedQuantity,
      appAccountToken: appAccountToken
    )
  }
  func toList() -> [Any?] {
    return [
      id,
      originalId,
      productId,
      purchaseDate,
      purchasedQuantity,
      appAccountToken,
    ]
  }
}
private class messagesPigeonCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 129:
      return SK2SubscriptionOfferMessage.fromList(self.readValue() as! [Any?])
    case 130:
      return SK2SubscriptionPeriodMessage.fromList(self.readValue() as! [Any?])
    case 131:
      return SK2SubscriptionInfoMessage.fromList(self.readValue() as! [Any?])
    case 132:
      return SK2ProductMessage.fromList(self.readValue() as! [Any?])
    case 133:
      return SK2PriceLocaleMessage.fromList(self.readValue() as! [Any?])
    case 134:
      return SK2TransactionMessage.fromList(self.readValue() as! [Any?])
    case 135:
      var enumResult: SK2ProductTypeMessage? = nil
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as? Int)
      if let enumResultAsInt = enumResultAsInt {
        enumResult = SK2ProductTypeMessage(rawValue: enumResultAsInt)
      }
      return enumResult
    case 136:
      var enumResult: SK2SubscriptionOfferTypeMessage? = nil
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as? Int)
      if let enumResultAsInt = enumResultAsInt {
        enumResult = SK2SubscriptionOfferTypeMessage(rawValue: enumResultAsInt)
      }
      return enumResult
    case 137:
      var enumResult: SK2SubscriptionOfferPaymentModeMessage? = nil
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as? Int)
      if let enumResultAsInt = enumResultAsInt {
        enumResult = SK2SubscriptionOfferPaymentModeMessage(rawValue: enumResultAsInt)
      }
      return enumResult
    case 138:
      var enumResult: SK2SubscriptionPeriodUnitMessage? = nil
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as? Int)
      if let enumResultAsInt = enumResultAsInt {
        enumResult = SK2SubscriptionPeriodUnitMessage(rawValue: enumResultAsInt)
      }
      return enumResult
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class messagesPigeonCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? SK2SubscriptionOfferMessage {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? SK2SubscriptionPeriodMessage {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? SK2SubscriptionInfoMessage {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? SK2ProductMessage {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else if let value = value as? SK2PriceLocaleMessage {
      super.writeByte(133)
      super.writeValue(value.toList())
    } else if let value = value as? SK2TransactionMessage {
      super.writeByte(134)
      super.writeValue(value.toList())
    } else if let value = value as? SK2ProductTypeMessage {
      super.writeByte(135)
      super.writeValue(value.rawValue)
    } else if let value = value as? SK2SubscriptionOfferTypeMessage {
      super.writeByte(136)
      super.writeValue(value.rawValue)
    } else if let value = value as? SK2SubscriptionOfferPaymentModeMessage {
      super.writeByte(137)
      super.writeValue(value.rawValue)
    } else if let value = value as? SK2SubscriptionPeriodUnitMessage {
      super.writeByte(138)
      super.writeValue(value.rawValue)
    } else {
      super.writeValue(value)
    }
  }
}

private class messagesPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return messagesPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return messagesPigeonCodecWriter(data: data)
  }
}

class messagesPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = messagesPigeonCodec(readerWriter: messagesPigeonCodecReaderWriter())
}


/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol InAppPurchase2API {
  func canMakePayments() throws -> Bool
  func purchase(id: String, completion: @escaping (Result<Void, Error>) -> Void)
  func products(identifiers: [String], completion: @escaping (Result<[SK2ProductMessage], Error>) -> Void)
  func transactionsUnfinished(completion: @escaping (Result<[SK2TransactionMessage], Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class InAppPurchase2APISetup {
  static var codec: FlutterStandardMessageCodec { messagesPigeonCodec.shared }
  /// Sets up an instance of `InAppPurchase2API` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: InAppPurchase2API?, messageChannelSuffix: String = "") {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let canMakePaymentsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchase2API.canMakePayments\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      canMakePaymentsChannel.setMessageHandler { _, reply in
        do {
          let result = try api.canMakePayments()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      canMakePaymentsChannel.setMessageHandler(nil)
    }
    let purchaseChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchase2API.purchase\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      purchaseChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        api.purchase(id: idArg) { result in
          switch result {
          case .success:
            reply(wrapResult(nil))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      purchaseChannel.setMessageHandler(nil)
    }
    let productsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchase2API.products\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      productsChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let identifiersArg = args[0] as! [String]
        api.products(identifiers: identifiersArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      productsChannel.setMessageHandler(nil)
    }
    let transactionsUnfinishedChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchase2API.transactionsUnfinished\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      transactionsUnfinishedChannel.setMessageHandler { _, reply in
        api.transactionsUnfinished { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      transactionsUnfinishedChannel.setMessageHandler(nil)
    }
  }
}
