// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:in_app_purchase_storekit/src/store_kit_2_wrappers/platform_types/sk2_purchase_details.dart';

import '../in_app_purchase_storekit.dart';
import '../store_kit_2_wrappers.dart';
import '../store_kit_wrappers.dart';
import 'messages2.g.dart';
import 'store_kit_2_wrappers/sk2_storefront_wrapper.dart';

/// [IAPError.code] code for failed purchases.
const String kPurchaseErrorCode = 'purchase_error';

/// Indicates store front is Apple AppStore.
const String kIAPSource = 'app_store';

const bool useStoreKit2 = true;

/// An [InAppPurchasePlatform] that wraps StoreKit.
///
/// This translates various `StoreKit` calls and responses into the
/// generic plugin API.
class InAppPurchaseStoreKitPlatform extends InAppPurchasePlatform {
  /// Creates an [InAppPurchaseStoreKitPlatform] object.
  ///
  /// This constructor should only be used for testing, for any other purpose
  /// get the connection from the [instance] getter.
  @visibleForTesting
  InAppPurchaseStoreKitPlatform();

  static late SKPaymentQueueWrapper _skPaymentQueueWrapper;
  static late _TransactionObserver _observer;

  static late SK2TransactionObserver _sk2transactionObserver;

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => useStoreKit2
      ? _sk2transactionObserver.purchaseUpdatedController.stream
      : _observer.purchaseUpdatedController.stream;

  /// Callback handler for transaction status changes.
  @visibleForTesting
  static SKTransactionObserverWrapper get observer => _observer;

  /// Registers this class as the default instance of [InAppPurchasePlatform].
  static void registerPlatform() {
    // Register the [InAppPurchaseStoreKitPlatformAddition] containing
    // StoreKit-specific functionality.
    InAppPurchasePlatformAddition.instance =
        InAppPurchaseStoreKitPlatformAddition();

    // Register the platform-specific implementation of the idiomatic
    // InAppPurchase API.
    InAppPurchasePlatform.instance = InAppPurchaseStoreKitPlatform();

    _skPaymentQueueWrapper = SKPaymentQueueWrapper();

    if (useStoreKit2) {
      final StreamController<List<PurchaseDetails>> updateController2 =
          StreamController<List<PurchaseDetails>>.broadcast(
        onListen: () => SK2Transaction.startListeningToTransactions(),
        onCancel: () => SK2Transaction.stopListeningToTransactions(),
      );
      _sk2transactionObserver =
          SK2TransactionObserver(purchaseUpdatedController: updateController2);

      InAppPurchase2CallbackAPI.setUp(_sk2transactionObserver);
    } else {
      // Create a purchaseUpdatedController and notify the native side when to
      // start of stop sending updates.
      final StreamController<List<PurchaseDetails>> updateController =
          StreamController<List<PurchaseDetails>>.broadcast(
        onListen: () => _skPaymentQueueWrapper.startObservingTransactionQueue(),
        onCancel: () => _skPaymentQueueWrapper.stopObservingTransactionQueue(),
      );
      _observer = _TransactionObserver(updateController);
      _skPaymentQueueWrapper.setTransactionObserver(observer);
    }
  }

  @override
  Future<bool> isAvailable() {
    if (useStoreKit2) {
      return AppStore().canMakePayments();
    }
    return SKPaymentQueueWrapper.canMakePayments();
  }

  @override
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam}) async {
    if (useStoreKit2) {
      print("dart purchase");
      await SK2Product.purchase(purchaseParam.productDetails.id);
      return true;
    }
    await _skPaymentQueueWrapper.addPayment(SKPaymentWrapper(
        productIdentifier: purchaseParam.productDetails.id,
        quantity:
            purchaseParam is AppStorePurchaseParam ? purchaseParam.quantity : 1,
        applicationUsername: purchaseParam.applicationUserName,
        simulatesAskToBuyInSandbox: purchaseParam is AppStorePurchaseParam &&
            purchaseParam.simulatesAskToBuyInSandbox,
        paymentDiscount: purchaseParam is AppStorePurchaseParam
            ? purchaseParam.discount
            : null));

    return true; // There's no error feedback from iOS here to return.
  }

  @override
  Future<bool> buyConsumable(
      {required PurchaseParam purchaseParam, bool autoConsume = true}) {
    assert(autoConsume, 'On iOS, we should always auto consume');
    return buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) {
    assert(
      purchase is AppStorePurchaseDetails || purchase is SK2PurchaseDetails,
      'On iOS, the `purchase` should always be of type `AppStorePurchaseDetails`.',
    );
    if (useStoreKit2) {
      print('dart finishing${purchase.productID}');
      return SK2Transaction.finish(int.parse(purchase.purchaseID!));
    }

    return _skPaymentQueueWrapper.finishTransaction(
      (purchase as AppStorePurchaseDetails).skPaymentTransaction,
    );
  }

  @override
  Future<void> restorePurchases({String? applicationUserName}) async {
    if (useStoreKit2) {
      SK2Transaction.restorePurchases();
      return;
    }
    return _observer
        .restoreTransactions(
            queue: _skPaymentQueueWrapper,
            applicationUserName: applicationUserName)
        .whenComplete(() => _observer.cleanUpRestoredTransactions());
  }

  /// Query the product detail list.
  ///
  /// This method only returns [ProductDetailsResponse].
  /// To get detailed Store Kit product list, use [SkProductResponseWrapper.startProductRequest]
  /// to get the [SKProductResponseWrapper].
  @override
  Future<ProductDetailsResponse> queryProductDetails(
      Set<String> identifiers) async {
    if (useStoreKit2) {
      List<SK2Product> products = <SK2Product>[];
      Set<String> invalidProductIdentifiers;
      PlatformException? exception;
      try {
        products = await SK2Product.products(identifiers.toList());
        // Storekit 2 no longer automatically returns a list of invalid identifiers,
        // so get the difference between given identifiers and returned products
        invalidProductIdentifiers = identifiers.difference(
            products.map((SK2Product product) => product.id).toSet());
      } on PlatformException catch (e) {
        exception = e;
        invalidProductIdentifiers = identifiers;
      }
      List<AppStoreProduct2Details> productDetails;
      productDetails = products
          .map((SK2Product productWrapper) =>
              AppStoreProduct2Details.fromSK2Product(productWrapper))
          .toList();
      final ProductDetailsResponse response = ProductDetailsResponse(
          productDetails: productDetails,
          notFoundIDs: invalidProductIdentifiers.toList());
      return response;
    }
    final SKRequestMaker requestMaker = SKRequestMaker();
    SkProductResponseWrapper response;
    PlatformException? exception;
    try {
      response = await requestMaker.startProductRequest(identifiers.toList());
    } on PlatformException catch (e) {
      exception = e;
      response = SkProductResponseWrapper(
          products: const <SKProductWrapper>[],
          invalidProductIdentifiers: identifiers.toList());
    }
    List<AppStoreProductDetails> productDetails = <AppStoreProductDetails>[];
    productDetails = response.products
        .map((SKProductWrapper productWrapper) =>
            AppStoreProductDetails.fromSKProduct(productWrapper))
        .toList();
    List<String> invalidIdentifiers = response.invalidProductIdentifiers;
    if (productDetails.isEmpty) {
      invalidIdentifiers = identifiers.toList();
    }
    final ProductDetailsResponse productDetailsResponse =
        ProductDetailsResponse(
      productDetails: productDetails,
      notFoundIDs: invalidIdentifiers,
      error: exception == null
          ? null
          : IAPError(
              source: kIAPSource,
              code: exception.code,
              message: exception.message ?? '',
              details: exception.details),
    );
    return productDetailsResponse;
  }

  /// Returns the country code from SKStoreFrontWrapper.
  ///
  /// Uses the ISO 3166-1 Alpha-3 country code representation.
  /// See: https://developer.apple.com/documentation/storekit/skstorefront?language=objc
  @override
  Future<String> countryCode() async {
    if (useStoreKit2) {
      return SK2Storefront().countryCode();
    }
    return (await _skPaymentQueueWrapper.storefront())?.countryCode ?? '';
  }

  /// Use countryCode instead.
  @Deprecated('Use countryCode')
  Future<String?> getCountryCode() => countryCode();
}

enum _TransactionRestoreState {
  notRunning,
  waitingForTransactions,
  receivedTransaction,
}

class _TransactionObserver implements SKTransactionObserverWrapper {
  _TransactionObserver(this.purchaseUpdatedController);

  final StreamController<List<PurchaseDetails>> purchaseUpdatedController;

  Completer<void>? _restoreCompleter;
  late String _receiptData;
  _TransactionRestoreState _transactionRestoreState =
      _TransactionRestoreState.notRunning;

  Future<void> restoreTransactions({
    required SKPaymentQueueWrapper queue,
    String? applicationUserName,
  }) {
    _transactionRestoreState = _TransactionRestoreState.waitingForTransactions;
    _restoreCompleter = Completer<void>();
    queue.restoreTransactions(applicationUserName: applicationUserName);
    return _restoreCompleter!.future;
  }

  void cleanUpRestoredTransactions() {
    _restoreCompleter = null;
  }

  @override
  void updatedTransactions(
      {required List<SKPaymentTransactionWrapper> transactions}) {
    _handleTransationUpdates(transactions);
  }

  @override
  void removedTransactions(
      {required List<SKPaymentTransactionWrapper> transactions}) {}

  /// Triggered when there is an error while restoring transactions.
  @override
  void restoreCompletedTransactionsFailed({required SKError error}) {
    _restoreCompleter!.completeError(error);
    _transactionRestoreState = _TransactionRestoreState.notRunning;
  }

  @override
  void paymentQueueRestoreCompletedTransactionsFinished() {
    _restoreCompleter!.complete();

    // If no restored transactions were received during the restore session
    // emit an empty list of purchase details to inform listeners that the
    // restore session finished without any results.
    if (_transactionRestoreState ==
        _TransactionRestoreState.waitingForTransactions) {
      purchaseUpdatedController.add(<PurchaseDetails>[]);
    }

    _transactionRestoreState = _TransactionRestoreState.notRunning;
  }

  @override
  bool shouldAddStorePayment(
      {required SKPaymentWrapper payment, required SKProductWrapper product}) {
    // In this unified API, we always return true to keep it consistent with the behavior on Google Play.
    return true;
  }

  Future<String> getReceiptData() async {
    try {
      _receiptData = await SKReceiptManager.retrieveReceiptData();
    } catch (e) {
      _receiptData = '';
    }
    return _receiptData;
  }

  /// Listen to transaction updates from storekit, and convert to
  /// purchasedetails
  /// Problem is calling purchase alters purchaseDetails, but it doesnt have access?
  /// Or should I just get transactions directly from the listener?
  Future<void> _handleTransationUpdates(
      List<SKPaymentTransactionWrapper> transactions) async {
    if (_transactionRestoreState ==
            _TransactionRestoreState.waitingForTransactions &&
        transactions.any((SKPaymentTransactionWrapper transaction) =>
            transaction.transactionState ==
            SKPaymentTransactionStateWrapper.restored)) {
      _transactionRestoreState = _TransactionRestoreState.receivedTransaction;
    }

    final String receiptData = await getReceiptData();
    final List<PurchaseDetails> purchases = transactions
        .map((SKPaymentTransactionWrapper transaction) =>
            AppStorePurchaseDetails.fromSKTransaction(transaction, receiptData))
        .toList();

    purchaseUpdatedController.add(purchases);
  }
}
