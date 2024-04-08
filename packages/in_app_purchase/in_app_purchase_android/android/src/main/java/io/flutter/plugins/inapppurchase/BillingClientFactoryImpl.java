// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.inapppurchase;

import static io.flutter.plugins.inapppurchase.Translator.fromUserChoiceDetails;

import android.content.Context;
import androidx.annotation.NonNull;
import com.android.billingclient.api.BillingClient;
import com.android.billingclient.api.UserChoiceBillingListener;
import io.flutter.Log;
import io.flutter.plugins.inapppurchase.Messages.PlatformBillingChoiceMode;

/** The implementation for {@link BillingClientFactory} for the plugin. */
final class BillingClientFactoryImpl implements BillingClientFactory {

  @Override
  public BillingClient createBillingClient(
      @NonNull Context context,
      @NonNull Messages.InAppPurchaseCallbackApi callbackApi,
      PlatformBillingChoiceMode billingChoiceMode) {
    BillingClient.Builder builder = BillingClient.newBuilder(context).enablePendingPurchases();
    switch (billingChoiceMode) {
      case ALTERNATIVE_BILLING_ONLY:
        // https://developer.android.com/google/play/billing/alternative/alternative-billing-without-user-choice-in-app
        builder.enableAlternativeBillingOnly();
        break;
      case USER_CHOICE_BILLING:
        final UserChoiceBillingListener userChoiceBillingListener =
            userChoiceDetails ->
                callbackApi.userSelectedalternativeBilling(
                    fromUserChoiceDetails(userChoiceDetails),
                    new Messages.VoidResult() {
                      @Override
                      public void success() {}

                      @Override
                      public void error(@NonNull Throwable error) {
                        io.flutter.Log.e(
                            "IN_APP_PURCHASE",
                            "userSelectedalternativeBilling handler error: " + error);
                      }
                    });
        builder.enableUserChoiceBilling(userChoiceBillingListener);
        break;
      case PLAY_BILLING_ONLY:
        // Do nothing.
        break;
      default:
        Log.e(
            "BillingClientFactoryImpl",
            "Unknown BillingChoiceMode " + billingChoiceMode + ", Defaulting to PLAY_BILLING_ONLY");
        break;
    }
    return builder.setListener(new PluginPurchaseListener(callbackApi)).build();
  }
}
