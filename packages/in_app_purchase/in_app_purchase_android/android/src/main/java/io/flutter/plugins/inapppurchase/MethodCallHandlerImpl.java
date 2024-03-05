// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.inapppurchase;

import static io.flutter.plugins.inapppurchase.Messages.FlutterError;
import static io.flutter.plugins.inapppurchase.Messages.InAppPurchaseApi;
import static io.flutter.plugins.inapppurchase.Translator.fromAlternativeBillingOnlyReportingDetails;
import static io.flutter.plugins.inapppurchase.Translator.fromBillingConfig;
import static io.flutter.plugins.inapppurchase.Translator.fromBillingResult;
import static io.flutter.plugins.inapppurchase.Translator.fromProductDetailsList;
import static io.flutter.plugins.inapppurchase.Translator.fromPurchaseHistoryRecordList;
import static io.flutter.plugins.inapppurchase.Translator.fromPurchasesList;
import static io.flutter.plugins.inapppurchase.Translator.pigeonBillingResultFromBillingResult;
import static io.flutter.plugins.inapppurchase.Translator.toProductList;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.VisibleForTesting;
import com.android.billingclient.api.AcknowledgePurchaseParams;
import com.android.billingclient.api.BillingClient;
import com.android.billingclient.api.BillingClientStateListener;
import com.android.billingclient.api.BillingFlowParams;
import com.android.billingclient.api.BillingResult;
import com.android.billingclient.api.ConsumeParams;
import com.android.billingclient.api.ConsumeResponseListener;
import com.android.billingclient.api.GetBillingConfigParams;
import com.android.billingclient.api.ProductDetails;
import com.android.billingclient.api.QueryProductDetailsParams;
import com.android.billingclient.api.QueryProductDetailsParams.Product;
import com.android.billingclient.api.QueryPurchaseHistoryParams;
import com.android.billingclient.api.QueryPurchasesParams;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** Handles method channel for the plugin. */
class MethodCallHandlerImpl
    implements MethodChannel.MethodCallHandler,
        Application.ActivityLifecycleCallbacks,
        InAppPurchaseApi {

  @VisibleForTesting
  static final class MethodNames {
    static final String ON_DISCONNECT = "BillingClientStateListener#onBillingServiceDisconnected()";
    static final String QUERY_PRODUCT_DETAILS =
        "BillingClient#queryProductDetailsAsync(QueryProductDetailsParams, ProductDetailsResponseListener)";
    static final String LAUNCH_BILLING_FLOW =
        "BillingClient#launchBillingFlow(Activity, BillingFlowParams)";
    static final String QUERY_PURCHASES_ASYNC =
        "BillingClient#queryPurchasesAsync(QueryPurchaseParams, PurchaseResponseListener)";
    static final String QUERY_PURCHASE_HISTORY_ASYNC =
        "BillingClient#queryPurchaseHistoryAsync(QueryPurchaseHistoryParams, PurchaseHistoryResponseListener)";
    static final String ACKNOWLEDGE_PURCHASE =
        "BillingClient#acknowledgePurchase(AcknowledgePurchaseParams, AcknowledgePurchaseResponseListener)";
    static final String GET_BILLING_CONFIG = "BillingClient#getBillingConfig()";
    static final String CREATE_ALTERNATIVE_BILLING_ONLY_REPORTING_DETAILS =
        "BillingClient#createAlternativeBillingOnlyReportingDetails()";

    private MethodNames() {}
  }

  // TODO(gmackall): Replace uses of deprecated ProrationMode enum values with new
  // ReplacementMode enum values.
  // https://github.com/flutter/flutter/issues/128957.
  @SuppressWarnings(value = "deprecation")
  private static final int PRORATION_MODE_UNKNOWN_SUBSCRIPTION_UPGRADE_DOWNGRADE_POLICY =
      com.android.billingclient.api.BillingFlowParams.ProrationMode
          .UNKNOWN_SUBSCRIPTION_UPGRADE_DOWNGRADE_POLICY;

  private static final String TAG = "InAppPurchasePlugin";
  private static final String LOAD_PRODUCT_DOC_URL =
      "https://github.com/flutter/packages/blob/main/packages/in_app_purchase/in_app_purchase/README.md#loading-products-for-sale";
  @VisibleForTesting static final String ACTIVITY_UNAVAILABLE = "ACTIVITY_UNAVAILABLE";

  @Nullable private BillingClient billingClient;
  private final BillingClientFactory billingClientFactory;

  @Nullable private Activity activity;
  private final Context applicationContext;
  final MethodChannel methodChannel;

  private final HashMap<String, ProductDetails> cachedProducts = new HashMap<>();

  /** Constructs the MethodCallHandlerImpl */
  MethodCallHandlerImpl(
      @Nullable Activity activity,
      @NonNull Context applicationContext,
      @NonNull MethodChannel methodChannel,
      @NonNull BillingClientFactory billingClientFactory) {
    this.billingClientFactory = billingClientFactory;
    this.applicationContext = applicationContext;
    this.activity = activity;
    this.methodChannel = methodChannel;
  }

  /**
   * Sets the activity. Should be called as soon as the the activity is available. When the activity
   * becomes unavailable, call this method again with {@code null}.
   */
  void setActivity(@Nullable Activity activity) {
    this.activity = activity;
  }

  @Override
  public void onActivityCreated(@NonNull Activity activity, Bundle savedInstanceState) {}

  @Override
  public void onActivityStarted(@NonNull Activity activity) {}

  @Override
  public void onActivityResumed(@NonNull Activity activity) {}

  @Override
  public void onActivityPaused(@NonNull Activity activity) {}

  @Override
  public void onActivitySaveInstanceState(@NonNull Activity activity, @NonNull Bundle outState) {}

  @Override
  public void onActivityDestroyed(@NonNull Activity activity) {
    if (this.activity == activity && this.applicationContext != null) {
      ((Application) this.applicationContext).unregisterActivityLifecycleCallbacks(this);
      endBillingClientConnection();
    }
  }

  @Override
  public void onActivityStopped(@NonNull Activity activity) {}

  void onDetachedFromActivity() {
    endBillingClientConnection();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    switch (call.method) {
      case MethodNames.QUERY_PRODUCT_DETAILS:
        List<Product> productList = toProductList(call.argument("productList"));
        queryProductDetailsAsync(productList, result);
        break;
      case MethodNames.LAUNCH_BILLING_FLOW:
        launchBillingFlow(
            (String) call.argument("product"),
            (String) call.argument("offerToken"),
            (String) call.argument("accountId"),
            (String) call.argument("obfuscatedProfileId"),
            (String) call.argument("oldProduct"),
            (String) call.argument("purchaseToken"),
            call.hasArgument("prorationMode")
                ? (int) call.argument("prorationMode")
                : PRORATION_MODE_UNKNOWN_SUBSCRIPTION_UPGRADE_DOWNGRADE_POLICY,
            result);
        break;
      case MethodNames.QUERY_PURCHASES_ASYNC:
        queryPurchasesAsync((String) call.argument("productType"), result);
        break;
      case MethodNames.QUERY_PURCHASE_HISTORY_ASYNC:
        queryPurchaseHistoryAsync((String) call.argument("productType"), result);
        break;
      case MethodNames.ACKNOWLEDGE_PURCHASE:
        acknowledgePurchase((String) call.argument("purchaseToken"), result);
        break;
      case MethodNames.GET_BILLING_CONFIG:
        getBillingConfig(result);
        break;
      case MethodNames.CREATE_ALTERNATIVE_BILLING_ONLY_REPORTING_DETAILS:
        createAlternativeBillingOnlyReportingDetails(result);
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void showAlternativeBillingOnlyInformationDialog(
      @NonNull Messages.Result<Messages.PlatformBillingResult> result) {
    validateBillingClient();
    assert billingClient != null;
    if (activity == null) {
      throw new FlutterError(ACTIVITY_UNAVAILABLE, "Not attempting to show dialog", null);
    }
    billingClient.showAlternativeBillingOnlyInformationDialog(
        activity,
        billingResult -> result.success(pigeonBillingResultFromBillingResult(billingResult)));
  }

  private void createAlternativeBillingOnlyReportingDetails(final MethodChannel.Result result) {
    if (billingClientError(result)) {
      return;
    }
    assert billingClient != null;
    billingClient.createAlternativeBillingOnlyReportingDetailsAsync(
        ((billingResult, alternativeBillingOnlyReportingDetails) ->
            result.success(
                fromAlternativeBillingOnlyReportingDetails(
                    billingResult, alternativeBillingOnlyReportingDetails))));
  }

  @Override
  public void isAlternativeBillingOnlyAvailable(
      @NonNull Messages.Result<Messages.PlatformBillingResult> result) {
    validateBillingClient();
    assert billingClient != null;
    billingClient.isAlternativeBillingOnlyAvailableAsync(
        billingResult -> result.success(pigeonBillingResultFromBillingResult(billingResult)));
  }

  private void getBillingConfig(final MethodChannel.Result result) {
    if (billingClientError(result)) {
      return;
    }
    assert billingClient != null;
    billingClient.getBillingConfigAsync(
        GetBillingConfigParams.newBuilder().build(),
        (billingResult, billingConfig) ->
            result.success(fromBillingConfig(billingResult, billingConfig)));
  }

  @Override
  public void endConnection() {
    endBillingClientConnection();
  }

  private void endBillingClientConnection() {
    if (billingClient != null) {
      billingClient.endConnection();
      billingClient = null;
    }
  }

  @Override
  @NonNull
  public Boolean isReady() {
    validateBillingClient();
    assert billingClient != null;
    return billingClient.isReady();
  }

  private void queryProductDetailsAsync(
      final List<Product> productList, final MethodChannel.Result result) {
    if (billingClientError(result)) {
      return;
    }
    assert billingClient != null;

    QueryProductDetailsParams params =
        QueryProductDetailsParams.newBuilder().setProductList(productList).build();
    billingClient.queryProductDetailsAsync(
        params,
        (billingResult, productDetailsList) -> {
          updateCachedProducts(productDetailsList);
          final Map<String, Object> productDetailsResponse = new HashMap<>();
          productDetailsResponse.put("billingResult", fromBillingResult(billingResult));
          productDetailsResponse.put(
              "productDetailsList", fromProductDetailsList(productDetailsList));
          result.success(productDetailsResponse);
        });
  }

  private void launchBillingFlow(
      String product,
      @Nullable String offerToken,
      @Nullable String accountId,
      @Nullable String obfuscatedProfileId,
      @Nullable String oldProduct,
      @Nullable String purchaseToken,
      int prorationMode,
      MethodChannel.Result result) {
    if (billingClientError(result)) {
      return;
    }
    assert billingClient != null;

    com.android.billingclient.api.ProductDetails productDetails = cachedProducts.get(product);
    if (productDetails == null) {
      result.error(
          "NOT_FOUND",
          "Details for product "
              + product
              + " are not available. It might because products were not fetched prior to the call. Please fetch the products first. An example of how to fetch the products could be found here: "
              + LOAD_PRODUCT_DOC_URL,
          null);
      return;
    }

    @Nullable
    List<ProductDetails.SubscriptionOfferDetails> subscriptionOfferDetails =
        productDetails.getSubscriptionOfferDetails();
    if (subscriptionOfferDetails != null) {
      boolean isValidOfferToken = false;
      for (ProductDetails.SubscriptionOfferDetails offerDetails : subscriptionOfferDetails) {
        if (offerToken != null && offerToken.equals(offerDetails.getOfferToken())) {
          isValidOfferToken = true;
          break;
        }
      }
      if (!isValidOfferToken) {
        result.error(
            "INVALID_OFFER_TOKEN",
            "Offer token "
                + offerToken
                + " for product "
                + product
                + " is not valid. Make sure to only pass offer tokens that belong to the product. To obtain offer tokens for a product, fetch the products. An example of how to fetch the products could be found here: "
                + LOAD_PRODUCT_DOC_URL,
            null);
        return;
      }
    }

    if (oldProduct == null
        && prorationMode != PRORATION_MODE_UNKNOWN_SUBSCRIPTION_UPGRADE_DOWNGRADE_POLICY) {
      result.error(
          "IN_APP_PURCHASE_REQUIRE_OLD_PRODUCT",
          "launchBillingFlow failed because oldProduct is null. You must provide a valid oldProduct in order to use a proration mode.",
          null);
      return;
    } else if (oldProduct != null && !cachedProducts.containsKey(oldProduct)) {
      result.error(
          "IN_APP_PURCHASE_INVALID_OLD_PRODUCT",
          "Details for product "
              + oldProduct
              + " are not available. It might because products were not fetched prior to the call. Please fetch the products first. An example of how to fetch the products could be found here: "
              + LOAD_PRODUCT_DOC_URL,
          null);
      return;
    }

    if (activity == null) {
      result.error(
          ACTIVITY_UNAVAILABLE,
          "Details for product "
              + product
              + " are not available. This method must be run with the app in foreground.",
          null);
      return;
    }

    BillingFlowParams.ProductDetailsParams.Builder productDetailsParamsBuilder =
        BillingFlowParams.ProductDetailsParams.newBuilder();
    productDetailsParamsBuilder.setProductDetails(productDetails);
    if (offerToken != null) {
      productDetailsParamsBuilder.setOfferToken(offerToken);
    }

    List<BillingFlowParams.ProductDetailsParams> productDetailsParamsList = new ArrayList<>();
    productDetailsParamsList.add(productDetailsParamsBuilder.build());

    BillingFlowParams.Builder paramsBuilder =
        BillingFlowParams.newBuilder().setProductDetailsParamsList(productDetailsParamsList);
    if (accountId != null && !accountId.isEmpty()) {
      paramsBuilder.setObfuscatedAccountId(accountId);
    }
    if (obfuscatedProfileId != null && !obfuscatedProfileId.isEmpty()) {
      paramsBuilder.setObfuscatedProfileId(obfuscatedProfileId);
    }
    BillingFlowParams.SubscriptionUpdateParams.Builder subscriptionUpdateParamsBuilder =
        BillingFlowParams.SubscriptionUpdateParams.newBuilder();
    if (oldProduct != null && !oldProduct.isEmpty() && purchaseToken != null) {
      subscriptionUpdateParamsBuilder.setOldPurchaseToken(purchaseToken);
      // Set the prorationMode using a helper to minimize impact of deprecation warning suppression.
      setReplaceProrationMode(subscriptionUpdateParamsBuilder, prorationMode);
      paramsBuilder.setSubscriptionUpdateParams(subscriptionUpdateParamsBuilder.build());
    }
    result.success(
        fromBillingResult(billingClient.launchBillingFlow(activity, paramsBuilder.build())));
  }

  // TODO(gmackall): Replace uses of deprecated setReplaceProrationMode.
  // https://github.com/flutter/flutter/issues/128957.
  @SuppressWarnings(value = "deprecation")
  private void setReplaceProrationMode(
      BillingFlowParams.SubscriptionUpdateParams.Builder builder, int prorationMode) {
    // The proration mode value has to match one of the following declared in
    // https://developer.android.com/reference/com/android/billingclient/api/BillingFlowParams.ProrationMode
    builder.setReplaceProrationMode(prorationMode);
  }

  @Override
  public void consumeAsync(
      @NonNull String purchaseToken,
      @NonNull Messages.Result<Messages.PlatformBillingResult> result) {
    validateBillingClient();
    assert billingClient != null;

    ConsumeResponseListener listener =
        (billingResult, outToken) ->
            result.success(pigeonBillingResultFromBillingResult(billingResult));
    ConsumeParams.Builder paramsBuilder =
        ConsumeParams.newBuilder().setPurchaseToken(purchaseToken);
    ConsumeParams params = paramsBuilder.build();

    billingClient.consumeAsync(params, listener);
  }

  private void queryPurchasesAsync(String productType, MethodChannel.Result result) {
    if (billingClientError(result)) {
      return;
    }
    assert billingClient != null;

    // Like in our connect call, consider the billing client responding a "success" here regardless
    // of status code.
    QueryPurchasesParams.Builder paramsBuilder = QueryPurchasesParams.newBuilder();
    paramsBuilder.setProductType(productType);
    billingClient.queryPurchasesAsync(
        paramsBuilder.build(),
        (billingResult, purchasesList) -> {
          final Map<String, Object> serialized = new HashMap<>();
          // The response code is no longer passed, as part of billing 4.0, so we pass OK here
          // as success is implied by calling this callback.
          serialized.put("responseCode", BillingClient.BillingResponseCode.OK);
          serialized.put("billingResult", fromBillingResult(billingResult));
          serialized.put("purchasesList", fromPurchasesList(purchasesList));
          result.success(serialized);
        });
  }

  private void queryPurchaseHistoryAsync(String productType, final MethodChannel.Result result) {
    if (billingClientError(result)) {
      return;
    }
    assert billingClient != null;

    billingClient.queryPurchaseHistoryAsync(
        QueryPurchaseHistoryParams.newBuilder().setProductType(productType).build(),
        (billingResult, purchasesList) -> {
          final Map<String, Object> serialized = new HashMap<>();
          serialized.put("billingResult", fromBillingResult(billingResult));
          serialized.put("purchaseHistoryRecordList", fromPurchaseHistoryRecordList(purchasesList));
          result.success(serialized);
        });
  }

  @Override
  public void startConnection(
      @NonNull Long handle,
      @NonNull Messages.PlatformBillingChoiceMode billingMode,
      @NonNull Messages.Result<Messages.PlatformBillingResult> result) {
    if (billingClient == null) {
      billingClient =
          billingClientFactory.createBillingClient(applicationContext, methodChannel, billingMode);
    }

    billingClient.startConnection(
        new BillingClientStateListener() {
          private boolean alreadyFinished = false;

          @Override
          public void onBillingSetupFinished(@NonNull BillingResult billingResult) {
            if (alreadyFinished) {
              Log.d(TAG, "Tried to call onBillingSetupFinished multiple times.");
              return;
            }
            alreadyFinished = true;
            // Consider the fact that we've finished a success, leave it to the Dart side to
            // validate the responseCode.
            result.success(pigeonBillingResultFromBillingResult(billingResult));
          }

          @Override
          public void onBillingServiceDisconnected() {
            final Map<String, Object> arguments = new HashMap<>();
            arguments.put("handle", handle);
            methodChannel.invokeMethod(MethodNames.ON_DISCONNECT, arguments);
          }
        });
  }

  private void acknowledgePurchase(String purchaseToken, final MethodChannel.Result result) {
    if (billingClientError(result)) {
      return;
    }
    assert billingClient != null;
    AcknowledgePurchaseParams params =
        AcknowledgePurchaseParams.newBuilder().setPurchaseToken(purchaseToken).build();
    billingClient.acknowledgePurchase(
        params, billingResult -> result.success(fromBillingResult(billingResult)));
  }

  protected void updateCachedProducts(@Nullable List<ProductDetails> productDetailsList) {
    if (productDetailsList == null) {
      return;
    }

    for (ProductDetails productDetails : productDetailsList) {
      cachedProducts.put(productDetails.getProductId(), productDetails);
    }
  }

  private boolean billingClientError(MethodChannel.Result result) {
    if (billingClient != null) {
      return false;
    }

    result.error("UNAVAILABLE", "BillingClient is unset. Try reconnecting.", null);
    return true;
  }

  private void validateBillingClient() {
    if (billingClient == null) {
      throw new FlutterError("UNAVAILABLE", "BillingClient is unset. Try reconnecting.", null);
    }
  }

  @Override
  public @NonNull Boolean isFeatureSupported(@NonNull String feature) {
    validateBillingClient();
    assert billingClient != null;
    BillingResult billingResult = billingClient.isFeatureSupported(feature);
    return billingResult.getResponseCode() == BillingClient.BillingResponseCode.OK;
  }
}
