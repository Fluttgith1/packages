// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Foundation
import StoreKit

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#endif

public class InAppPurchasePlugin: NSObject, FlutterPlugin, InAppPurchaseAPI, InAppPurchase2API {
  private let receiptManager: FIAPReceiptManager
  private var productsCache: NSMutableDictionary = [:]
  private var paymentQueueDelegateCallbackChannel: FlutterMethodChannel?
  // note - the type should be FIAPPaymentQueueDelegate, but this is only available >= iOS 13,
  // FIAPPaymentQueueDelegate only gets set/used in registerPaymentQueueDelegateWithError or removePaymentQueueDelegateWithError, which both are ios13+ only
  private var paymentQueueDelegate: Any?
  // Swift sets do not accept protocols, only concrete implementations
  // TODO(louisehsu): Change it back to a set when removing obj-c dependancies from this file via type erasure
  private var requestHandlers = NSHashTable<FLTRequestHandlerProtocol>()
  private var handlerFactory: ((SKRequest) -> FLTRequestHandlerProtocol)
  private var transactionObserverCallbackChannel: FLTMethodChannelProtocol?
  public var registrar: FlutterPluginRegistrar?
  // This property is optional, as it requires self to exist to be initialized.
  public var paymentQueueHandler: FLTPaymentQueueHandlerProtocol?
  var updateListenerTask: Any? = nil
  var transactionListenerAPI : TransactionCallbacks? = nil;

  public static func register(with registrar: FlutterPluginRegistrar) {
    #if os(iOS)
      let messenger = registrar.messenger()
    #endif
    #if os(macOS)
      let messenger = registrar.messenger
    #endif
    let channel = FlutterMethodChannel(
      name: "plugins.flutter.io/in_app_purchase",
      binaryMessenger: messenger)
    let instance = InAppPurchasePlugin(registrar: registrar)
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
    SetUpInAppPurchaseAPI(messenger, instance)
    InAppPurchase2APISetup.setUp(binaryMessenger: messenger, api: instance)
  }

  // This init is used for tests
  public init(
    receiptManager: FIAPReceiptManager,
    handlerFactory: @escaping (SKRequest) -> FLTRequestHandlerProtocol = {
      DefaultRequestHandler(requestHandler: FIAPRequestHandler(request: $0))
    },
    transactionCallbackChannel: FLTMethodChannelProtocol? = nil
  ) {
    self.receiptManager = receiptManager
    self.handlerFactory = handlerFactory
    self.transactionObserverCallbackChannel = transactionCallbackChannel

    super.init()
  }

  // This init gets called during plugin registration
  public convenience init(registrar: FlutterPluginRegistrar) {
    self.init(receiptManager: FIAPReceiptManager())
    self.registrar = registrar

    self.paymentQueueHandler = FIAPaymentQueueHandler(
      queue: DefaultPaymentQueue(queue: SKPaymentQueue.default()),
      transactionsUpdated: { [weak self] transactions in
        self?.handleTransactionsUpdated(transactions)
      },
      transactionRemoved: { [weak self] transactions in
        self?.handleTransactionsRemoved(transactions)
      },
      restoreTransactionFailed: { [weak self] error in
        self?.handleTransactionRestoreFailed(error as NSError)
      },
      restoreCompletedTransactionsFinished: { [weak self] in
        self?.restoreCompletedTransactionsFinished()
      },
      shouldAddStorePayment: { [weak self] (payment, product) -> Bool in
        return self?.shouldAddStorePayment(payment: payment, product: product) ?? false
      },
      updatedDownloads: { [weak self] _ in
        self?.updatedDownloads()
      },
      transactionCache: DefaultTransactionCache(cache: FIATransactionCache()))
    #if os(iOS)
      let messenger = registrar.messenger()
    #endif
    #if os(macOS)
      let messenger = registrar.messenger
    #endif
    setupTransactionObserverChannelIfNeeded(withMessenger: messenger)
    self.transactionListenerAPI = TransactionCallbacks.init(binaryMessenger: messenger)
    if #available(iOS 15.0, *) {
      self.updateListenerTask = listenForTransactions()
    } else {
      // Fallback on earlier versions
    };
  }

  // MARK: - Pigeon Functions

  public func canMakePaymentsWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>)
    -> NSNumber?
  {
    return SKPaymentQueue.canMakePayments() as NSNumber
  }

  public func transactionsWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>)
    -> [SKPaymentTransactionMessage]?
  {
    return getPaymentQueueHandler()
      .getUnfinishedTransactions()
      .compactMap {
        FIAObjectTranslator.convertTransaction(toPigeon: $0)
      }
  }

  public func storefrontWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>)
    -> SKStorefrontMessage?
  {
    if #available(iOS 13.0, *), let storefront = getPaymentQueueHandler().storefront {
      return FIAObjectTranslator.convertStorefront(toPigeon: storefront)
    }
    return nil
  }

  public func startProductRequestProductIdentifiers(
    _ productIdentifiers: [String],
    completion: @escaping (SKProductsResponseMessage?, FlutterError?) -> Void
  ) {
    let request = getProductRequest(withIdentifiers: Set(productIdentifiers))
    let handler = handlerFactory(request)
    requestHandlers.add(handler)

    handler.startProductRequest { [weak self] response, startProductRequestError in
      guard let self = self else { return }
      if let startProductRequestError = startProductRequestError {
        let error = FlutterError(
          code: "storekit_getproductrequest_platform_error",
          message: startProductRequestError.localizedDescription,
          details: startProductRequestError.localizedDescription)
        completion(nil, error)
        return
      }

      guard let response = response else {
        let error = FlutterError(
          code: "storekit_platform_no_response",
          message:
            "Failed to get SKProductResponse in startRequest call. Error occurred on iOS platform",
          details: productIdentifiers)
        completion(nil, error)
        return
      }

      for product in response.products {
        self.productsCache[product.productIdentifier] = product
      }

      if #available(iOS 12.2, *) {
        if let responseMessage = FIAObjectTranslator.convertProductsResponse(toPigeon: response) {
          completion(responseMessage, nil)
        }
      }
      self.requestHandlers.remove(handler)
    }
  }

  public func addPaymentPaymentMap(
    _ paymentMap: [String: Any], error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) {
    guard let productID = paymentMap["productIdentifier"] as? String else {
      error.pointee = FlutterError(
        code: "storekit_missing_product_identifier",
        message: "The `productIdentifier` is missing from the payment map.",
        details: paymentMap)
      return
    }

    guard let product = self.getProduct(productID: productID) else {
      error.pointee = FlutterError(
        code: "storekit_invalid_payment_object",
        message:
          "You have requested a payment for an invalid product. Either the `productIdentifier` of the payment is not valid or the product has not been fetched before adding the payment to the payment queue.",
        details: paymentMap)
      return
    }

    let payment = SKMutablePayment(product: product)
    payment.applicationUsername = paymentMap["applicationUsername"] as? String
    payment.quantity = paymentMap["quantity"] as? Int ?? 1
    payment.simulatesAskToBuyInSandbox = paymentMap["simulatesAskToBuyInSandbox"] as? Bool ?? false

    if #available(iOS 12.2, *) {
      if let paymentDiscountMap = paymentMap["paymentDiscount"] as? [String: Any],
        !paymentDiscountMap.isEmpty
      {
        var invalidError: NSString?
        if let paymentDiscount = FIAObjectTranslator.getSKPaymentDiscount(
          fromMap: paymentDiscountMap, withError: &invalidError)
        {
          payment.paymentDiscount = paymentDiscount
        } else if let invalidError = invalidError {
          error.pointee = FlutterError(
            code: "storekit_invalid_payment_discount_object",
            message:
              "You have requested a payment and specified a payment discount with invalid properties. \(invalidError)",
            details: paymentMap)
          return
        }
      }
    }

    if !getPaymentQueueHandler().add(payment) {
      error.pointee = FlutterError(
        code: "storekit_duplicate_product_object",
        message:
          "There is a pending transaction for the same product identifier. Please either wait for it to be finished or finish it manually using `completePurchase` to avoid edge cases.",
        details: paymentMap)
    }
  }

  // TODO(louisehsu): Once tests and pigeon are migrated to Swift, ensure the param type is [String:String] instead of [String:String?]
  public func finishTransactionFinishMap(
    _ finishMap: [String: Any], error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) {

    // TODO(louisehsu): This is a workaround for objc pigeon's NSNull support. Once we move to swift pigeon, this can be removed.
    let castedFinishMap: [String: String] = finishMap.compactMapValues { value in
      if let _ = value as? NSNull {
        return nil
      } else if let stringValue = value as? String {
        return stringValue
      }
      fatalError("This dict should only contain either NSNull or String")
    }
    let productIdentifier = castedFinishMap["productIdentifier"]
    let transactionIdentifier = castedFinishMap["transactionIdentifier"]
    let pendingTransactions = getPaymentQueueHandler().getUnfinishedTransactions()

    for transaction in pendingTransactions {
      // If the user cancels the purchase dialog we won't have a transactionIdentifier.
      // So if it is null AND a transaction in the pendingTransactions list has
      // also a null transactionIdentifier we check for equal product identifiers.
      if transaction.transactionIdentifier == transactionIdentifier
        || (transactionIdentifier == nil
          && transaction.transactionIdentifier == nil
          && transaction.payment.productIdentifier == productIdentifier)
      {
        getPaymentQueueHandler().finish(transaction)
      }
    }
  }

  public func restoreTransactionsApplicationUserName(
    _ applicationUserName: String?, error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) {
    getPaymentQueueHandler().restoreTransactions(applicationUserName)
  }

  public func presentCodeRedemptionSheetWithError(
    _ error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) {
    #if os(iOS)
      getPaymentQueueHandler().presentCodeRedemptionSheet()
    #endif
  }

  public func retrieveReceiptDataWithError(
    _ error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) -> String? {
    var flutterError: FlutterError? = nil
    if let receiptData = receiptManager.retrieveReceiptWithError(&flutterError) {
      return receiptData
    } else {
      error.pointee = flutterError
      return nil
    }
  }

  public func refreshReceiptReceiptProperties(
    _ receiptProperties: [String: Any]?, completion: @escaping (FlutterError?) -> Void
  ) {
    let properties = receiptProperties?.compactMapValues { $0 } ?? [:]
    let request = getRefreshReceiptRequest(properties: properties.isEmpty ? nil : properties)
    let handler = handlerFactory(request)
    requestHandlers.add(handler)
    handler.startProductRequest { [weak self] response, error in
      if let error = error {
        let requestError = FlutterError(
          code: "storekit_refreshreceiptrequest_platform_error",
          message: error.localizedDescription,
          details: error.localizedDescription)
        completion(requestError)
        return
      }
      completion(nil)
      self?.requestHandlers.remove(handler)
    }
  }

  public func startObservingPaymentQueueWithError(
    _ error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) {
    getPaymentQueueHandler().startObservingPaymentQueue()
  }

  public func stopObservingPaymentQueueWithError(
    _ error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) {
    getPaymentQueueHandler().stopObservingPaymentQueue()
  }

  public func registerPaymentQueueDelegateWithError(
    _ error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) {
    #if os(iOS)
      if #available(iOS 13.0, *) {
        guard let messenger = registrar?.messenger() else {
          fatalError("registrar.messenger can not be nil.")
        }
        paymentQueueDelegateCallbackChannel = FlutterMethodChannel(
          name: "plugins.flutter.io/in_app_purchase_payment_queue_delegate",
          binaryMessenger: messenger)

        guard let unwrappedChannel = paymentQueueDelegateCallbackChannel else {
          fatalError("paymentQueueDelegateCallbackChannel can not be nil.")
        }
        paymentQueueDelegate = FIAPPaymentQueueDelegate(
          methodChannel: DefaultMethodChannel(channel: unwrappedChannel))

        getPaymentQueueHandler().delegate = paymentQueueDelegate as? SKPaymentQueueDelegate
      }
    #endif
  }

  public func removePaymentQueueDelegateWithError(
    _ error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) {
    #if os(iOS)
      if #available(iOS 13.0, *) {
        paymentQueueDelegateCallbackChannel = nil
        getPaymentQueueHandler().delegate = nil
        paymentQueueDelegate = nil
      }
    #endif
  }

  public func showPriceConsentIfNeededWithError(
    _ error: AutoreleasingUnsafeMutablePointer<FlutterError?>
  ) {
    #if os(iOS)
      if #available(iOS 13.4, *) {
        getPaymentQueueHandler().showPriceConsentIfNeeded()
      }
    #endif
  }

  public func handleTransactionsUpdated(_ transactions: [SKPaymentTransaction]) {
    let translatedTransactions = transactions.map {
      FIAObjectTranslator.getMapFrom($0)
    }
    transactionObserverCallbackChannel?.invokeMethod(
      "updatedTransactions", arguments: translatedTransactions)
  }

  public func handleTransactionsRemoved(_ transactions: [SKPaymentTransaction]) {
    let translatedTransactions = transactions.map {
      FIAObjectTranslator.getMapFrom($0)
    }
    transactionObserverCallbackChannel?.invokeMethod(
      "removedTransactions", arguments: translatedTransactions)
  }

  public func handleTransactionRestoreFailed(_ error: NSError) {
    transactionObserverCallbackChannel?.invokeMethod(
      "restoreCompletedTransactionsFailed", arguments: FIAObjectTranslator.getMapFrom(error))
  }

  public func restoreCompletedTransactionsFinished() {
    transactionObserverCallbackChannel?.invokeMethod(
      "paymentQueueRestoreCompletedTransactionsFinished", arguments: nil)
  }

  public func shouldAddStorePayment(payment: SKPayment, product: SKProduct) -> Bool {
    productsCache[product.productIdentifier] = product
    transactionObserverCallbackChannel?.invokeMethod(
      "shouldAddStorePayment",
      arguments: [
        "payment": FIAObjectTranslator.getMapFrom(payment),
        "product": FIAObjectTranslator.getMapFrom(product),
      ])
    return false
  }

  public func updatedDownloads() {
    NSLog("Received an updatedDownloads callback, but downloads are not supported.")
  }

  // MARK: - Methods exposed for testing
  func getProduct(productID: String) -> SKProduct? {
    return self.productsCache[productID] as? SKProduct
  }

  func getProductRequest(withIdentifiers productIdentifiers: Set<String>) -> SKProductsRequest {
    return SKProductsRequest(productIdentifiers: productIdentifiers)
  }

  func getRefreshReceiptRequest(properties: [String: Any]?) -> SKReceiptRefreshRequest {
    return SKReceiptRefreshRequest(receiptProperties: properties)
  }

  // MARK: -  Private convenience methods
  private func getNonNullValue(from dictionary: [String: Any], forKey key: String) -> Any? {
    let value = dictionary[key]
    return value is NSNull ? nil : value
  }

  private func getPaymentQueueHandler() -> FLTPaymentQueueHandlerProtocol {
    guard let paymentQueueHandler = self.paymentQueueHandler else {
      fatalError(
        "paymentQueueHandler can't be nil. Please ensure you're using init(registrar: FlutterPluginRegistrar)"
      )
    }
    return paymentQueueHandler
  }

  private func setupTransactionObserverChannelIfNeeded(
    withMessenger messenger: FlutterBinaryMessenger
  ) {
    // If the channel is already set (e.g., injected in tests), don't overwrite it.
    guard self.transactionObserverCallbackChannel == nil else { return }

    self.transactionObserverCallbackChannel = DefaultMethodChannel(
      channel: FlutterMethodChannel(
        name: "plugins.flutter.io/in_app_purchase",
        binaryMessenger: messenger
      )
    )
  }

  // https://developer.apple.com/documentation/storekit/appstore/3822277-canmakepayments
  func canMakePayments() throws -> Bool {
    if #available(iOS 15.0, macOS 12.0, *) {
      return AppStore.canMakePayments
    }
    throw PigeonError(
      code: "storekit2_invalid_os_version ",
      message:
        "You have tried to access a StoreKit 2 method on a device below iOS 15.0. or OS X. Please try again on an appropriate device",
      details: "details")
  }

  // Gets the appropriate product, then calls purchase on it.
  // https://developer.apple.com/documentation/storekit/product/3791971-purchase
  func purchase(id: String, options: SK2ProductPurchaseOptionsMessage?, completion: @escaping (Result<SK2ProductPurchaseResultMessage, any Error>) -> Void) {
    if #available(iOS 15.0, macOS 12.0, *) {
      Task {
        do {
          let product = try await rawProducts(identifiers: [id]).first
          guard let product = product else {
            throw PigeonError(
              code: "storekit2_failed_to_fetch_product", message: "failed to make purchase",
              details: "")
          }

          let result = try await product.purchase()

          switch result {
          case .success(let verification):
            switch verification {
            case .verified(let transaction):
              completion(.success(result.convertToPigeon()))
            case .unverified(_, let error):
              completion(.failure(error))
            }
          case .pending:
            completion(
              .failure(
                PigeonError(
                  code: "storekit2_purchase_pending", message: "this transaction is still pending",
                  details: "")))
          case .userCancelled:
            // The user cancelled the transaction
            completion(
              .failure(
                PigeonError(
                  code: "storekit2_purchase_cancelled",
                  message: "this transaction has been cancelled", details: "")))
          @unknown default:
            fatalError()
          }
        } catch {
          completion(.failure(error))
        }
      }
    }
  }

  // Pigeon method
  func products(
    identifiers: [String], completion: @escaping (Result<[SK2ProductMessage], any Error>) -> Void
  ) {
    if #available(iOS 15.0, macOS 12.0, *) {
      Task {
        do {
          let products = try await rawProducts(identifiers: identifiers)
          let productMessages = products.map { product in
            product.convertToPigeon()
          }
          completion(.success(productMessages))
        } catch {
          completion(.failure(error))
        }
      }
    }
  }

  func transactions(
    completion: @escaping (Result<[SK2TransactionMessage], any Error>) -> Void
  ) {
    if #available(iOS 15.0, macOS 12, *) {
      Task {
        do {
          let transactionsMsgs = await rawTransactions().map { $0.convertToPigeon() }
          completion(.success(transactionsMsgs))
        }
      }
    } else {
      fatalError("version")
    }
  }

  func finish(completion: @escaping (Result<Void, any Error>) -> Void) {
    return;
  }

  @available(iOS 15.0, *)
  func listenForTransactions() -> Task<Void, Error> {
      return Task.detached {
        print("hiya")
        var verfiedArray:[Transaction] = [];
        var unverifiedArray = [];
        for await verificationResult in Transaction.updates {
          print("hiya2")
             switch verificationResult {
             case .verified(let transaction):
               verfiedArray.append(transaction)
             case .unverified(let transaction, let error):
               unverifiedArray.append(transaction)
             }
         }
        self.transactionListenerAPI?.transactionUpdated(updatedTransactions: verfiedArray)
        }
      }
  }

  // Raw storekit calls

  @available(iOS 15.0, macOS 12.0, *)
  func rawProducts(identifiers: [String]) async throws -> [Product] {
    return try await Product.products(for: identifiers)
  }

  @available(iOS 15.0, macOS 12.0, *)
  func rawTransactions() async -> [Transaction] {
    var transactions: [Transaction] = []

    for await verificationResult in Transaction.unfinished {
      switch verificationResult {
      case .verified(let transaction):
        transactions.append(transaction)
      case .unverified(_, _):
        // Handle unverified transactions if necessary
        break
      }
    }

    return transactions
  }

