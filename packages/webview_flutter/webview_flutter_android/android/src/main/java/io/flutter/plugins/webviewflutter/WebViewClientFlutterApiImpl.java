// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.webviewflutter;

import android.os.Build;
import android.webkit.HttpAuthHandler;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.webkit.WebResourceErrorCompat;
import java.util.Objects;

/**
 * Flutter Api implementation for {@link WebViewClient}.
 *
 * <p>Passes arguments of callbacks methods from a {@link WebViewClient} to Dart.
 */
public class WebViewClientFlutterApiImpl extends PigeonApiWebViewClient {
  /** Creates a Flutter api that sends messages to Dart. */
  public WebViewClientFlutterApiImpl(@NonNull ProxyApiRegistrar pigeonRegistrar) {
    super(pigeonRegistrar);
  }

  /** Passes arguments from {@link WebViewClient#onPageStarted} to Dart. */
  public void onPageStarted(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webView,
      @NonNull String urlArg,
      @NonNull Reply<Void> callback) {
    webViewFlutterApi.create(webView, reply -> {});

    final Long webViewIdentifier =
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webView));
    onPageStarted(getIdentifierForClient(webViewClient), webViewIdentifier, urlArg, callback);
  }

  /** Passes arguments from {@link WebViewClient#onPageFinished} to Dart. */
  public void onPageFinished(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webView,
      @NonNull String urlArg,
      @NonNull Reply<Void> callback) {
    webViewFlutterApi.create(webView, reply -> {});

    final Long webViewIdentifier =
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webView));
    onPageFinished(getIdentifierForClient(webViewClient), webViewIdentifier, urlArg, callback);
  }

  /** Passes arguments from {@link WebViewClient#onReceivedHttpError} to Dart. */
  @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
  public void onReceivedHttpError(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webView,
      @NonNull WebResourceRequest request,
      @NonNull WebResourceResponse response,
      @NonNull Reply<Void> callback) {
    webViewFlutterApi.create(webView, reply -> {});

    final Long webViewIdentifier = instanceManager.getIdentifierForStrongReference(webView);
    onReceivedHttpError(
        getIdentifierForClient(webViewClient),
        webViewIdentifier,
        createWebResourceRequestData(request),
        createWebResourceResponseData(response),
        callback);
  }

  /**
   * Passes arguments from {@link WebViewClient#onReceivedError(WebView, WebResourceRequest,
   * WebResourceError)} to Dart.
   */
  @RequiresApi(api = Build.VERSION_CODES.M)
  public void onReceivedRequestError(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webView,
      @NonNull WebResourceRequest request,
      @NonNull WebResourceError error,
      @NonNull Reply<Void> callback) {
    webViewFlutterApi.create(webView, reply -> {});

    final Long webViewIdentifier =
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webView));
    onReceivedRequestError(
        getIdentifierForClient(webViewClient),
        webViewIdentifier,
        createWebResourceRequestData(request),
        createWebResourceErrorData(error),
        callback);
  }

  /**
   * Passes arguments from {@link androidx.webkit.WebViewClientCompat#onReceivedError(WebView,
   * WebResourceRequest, WebResourceError)} to Dart.
   */
  @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
  public void onReceivedRequestError(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webView,
      @NonNull WebResourceRequest request,
      @NonNull WebResourceErrorCompat error,
      @NonNull Reply<Void> callback) {
    webViewFlutterApi.create(webView, reply -> {});

    final Long webViewIdentifier =
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webView));
    onReceivedRequestError(
        getIdentifierForClient(webViewClient),
        webViewIdentifier,
        createWebResourceRequestData(request),
        createWebResourceErrorData(error),
        callback);
  }

  /**
   * Passes arguments from {@link WebViewClient#onReceivedError(WebView, int, String, String)} to
   * Dart.
   */
  public void onReceivedError(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webView,
      @NonNull Long errorCodeArg,
      @NonNull String descriptionArg,
      @NonNull String failingUrlArg,
      @NonNull Reply<Void> callback) {
    webViewFlutterApi.create(webView, reply -> {});

    final Long webViewIdentifier =
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webView));
    onReceivedError(
        getIdentifierForClient(webViewClient),
        webViewIdentifier,
        errorCodeArg,
        descriptionArg,
        failingUrlArg,
        callback);
  }

  /**
   * Passes arguments from {@link WebViewClient#shouldOverrideUrlLoading(WebView,
   * WebResourceRequest)} to Dart.
   */
  @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
  public void requestLoading(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webView,
      @NonNull WebResourceRequest request,
      @NonNull Reply<Void> callback) {
    webViewFlutterApi.create(webView, reply -> {});

    final Long webViewIdentifier =
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webView));
    requestLoading(
        getIdentifierForClient(webViewClient),
        webViewIdentifier,
        createWebResourceRequestData(request),
        callback);
  }

  /**
   * Passes arguments from {@link WebViewClient#shouldOverrideUrlLoading(WebView, String)} to Dart.
   */
  public void urlLoading(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webView,
      @NonNull String urlArg,
      @NonNull Reply<Void> callback) {
    webViewFlutterApi.create(webView, reply -> {});

    final Long webViewIdentifier =
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webView));
    urlLoading(getIdentifierForClient(webViewClient), webViewIdentifier, urlArg, callback);
  }

  /** Passes arguments from {@link WebViewClient#doUpdateVisitedHistory} to Dart. */
  public void doUpdateVisitedHistory(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webView,
      @NonNull String url,
      boolean isReload,
      @NonNull Reply<Void> callback) {
    webViewFlutterApi.create(webView, reply -> {});

    final Long webViewIdentifier =
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webView));
    doUpdateVisitedHistory(
        getIdentifierForClient(webViewClient), webViewIdentifier, url, isReload, callback);
  }

  /** Passes arguments from {@link WebViewClient#onReceivedHttpAuthRequest} to Dart. */
  public void onReceivedHttpAuthRequest(
      @NonNull WebViewClient webViewClient,
      @NonNull WebView webview,
      @NonNull HttpAuthHandler httpAuthHandler,
      @NonNull String host,
      @NonNull String realm,
      @NonNull Reply<Void> callback) {
    new HttpAuthHandlerFlutterApiImpl(binaryMessenger, instanceManager)
        .create(httpAuthHandler, reply -> {});

    onReceivedHttpAuthRequest(
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webViewClient)),
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(webview)),
        Objects.requireNonNull(instanceManager.getIdentifierForStrongReference(httpAuthHandler)),
        host,
        realm,
        callback);
  }

  private long getIdentifierForClient(WebViewClient webViewClient) {
    final Long identifier = instanceManager.getIdentifierForStrongReference(webViewClient);
    if (identifier == null) {
      throw new IllegalStateException("Could not find identifier for WebViewClient.");
    }
    return identifier;
  }
}
