// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.webviewflutter;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import android.net.Uri;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import androidx.annotation.NonNull;
import io.flutter.plugins.webviewflutter.WebViewClientProxyApi.WebViewClientCompatImpl;
import io.flutter.plugins.webviewflutter.WebViewClientProxyApi.WebViewClientCreator;
import java.util.HashMap;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

public class WebViewClientCompatImplTest {
  @Rule public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock public WebViewClientFlutterApiImpl mockFlutterApi;

  @Mock public WebView mockWebView;

  InstanceManager instanceManager;
  WebViewClientProxyApi hostApiImpl;
  WebViewClientCompatImpl webViewClient;

  @Before
  public void setUp() {
    instanceManager = InstanceManager.create(identifier -> {});

    final WebViewClientCreator webViewClientCreator =
        new WebViewClientCreator() {
          @Override
          @NonNull
          public WebViewClient createWebViewClient(
              @NonNull WebViewClientFlutterApiImpl flutterApi) {
            webViewClient = new WebViewClientCompatImpl(flutterApi);
            return webViewClient;
          }
        };

    hostApiImpl = new WebViewClientProxyApi(instanceManager, webViewClientCreator, mockFlutterApi);
    hostApiImpl.create(1L);
  }

  @After
  public void tearDown() {
    instanceManager.stopFinalizationListener();
  }

  @Test
  public void onPageStarted() {
    webViewClient.onPageStarted(mockWebView, "https://www.google.com", null);
    verify(mockFlutterApi)
        .onPageStarted(eq(webViewClient), eq(mockWebView), eq("https://www.google.com"), any());
  }

  @Test
  public void onReceivedError() {
    webViewClient.onReceivedError(mockWebView, 32, "description", "https://www.google.com");
    verify(mockFlutterApi)
        .onReceivedError(
            eq(webViewClient),
            eq(mockWebView),
            eq(32L),
            eq("description"),
            eq("https://www.google.com"),
            any());
  }

  @Test
  public void urlLoading() {
    webViewClient.shouldOverrideUrlLoading(mockWebView, "https://www.google.com");
    verify(mockFlutterApi)
        .urlLoading(eq(webViewClient), eq(mockWebView), eq("https://www.google.com"), any());
  }

  @Test
  public void urlLoadingForMainFrame() {
    webViewClient.setReturnValueForShouldOverrideUrlLoading(false);

    final WebResourceRequest mockRequest = mock(WebResourceRequest.class);
    when(mockRequest.isForMainFrame()).thenReturn(true);

    assertFalse(webViewClient.shouldOverrideUrlLoading(mockWebView, mockRequest));
    verify(mockFlutterApi)
        .requestLoading(eq(webViewClient), eq(mockWebView), eq(mockRequest), any());
  }

  @Test
  public void urlLoadingForMainFrameWithOverride() {
    webViewClient.setReturnValueForShouldOverrideUrlLoading(true);

    final WebResourceRequest mockRequest = mock(WebResourceRequest.class);
    when(mockRequest.isForMainFrame()).thenReturn(true);

    assertTrue(webViewClient.shouldOverrideUrlLoading(mockWebView, mockRequest));
    verify(mockFlutterApi)
        .requestLoading(eq(webViewClient), eq(mockWebView), eq(mockRequest), any());
  }

  @Test
  public void urlLoadingNotForMainFrame() {
    webViewClient.setReturnValueForShouldOverrideUrlLoading(false);

    final WebResourceRequest mockRequest = mock(WebResourceRequest.class);
    when(mockRequest.isForMainFrame()).thenReturn(false);

    assertFalse(webViewClient.shouldOverrideUrlLoading(mockWebView, mockRequest));
    verify(mockFlutterApi)
        .requestLoading(eq(webViewClient), eq(mockWebView), eq(mockRequest), any());
  }

  @Test
  public void urlLoadingNotForMainFrameWithOverride() {
    webViewClient.setReturnValueForShouldOverrideUrlLoading(true);

    final WebResourceRequest mockRequest = mock(WebResourceRequest.class);
    when(mockRequest.isForMainFrame()).thenReturn(false);

    assertFalse(webViewClient.shouldOverrideUrlLoading(mockWebView, mockRequest));
    verify(mockFlutterApi)
        .requestLoading(eq(webViewClient), eq(mockWebView), eq(mockRequest), any());
  }

  @Test
  public void convertWebResourceRequestWithNullHeaders() {
    final Uri mockUri = mock(Uri.class);
    when(mockUri.toString()).thenReturn("");

    final WebResourceRequest mockRequest = mock(WebResourceRequest.class);
    when(mockRequest.getMethod()).thenReturn("method");
    when(mockRequest.getUrl()).thenReturn(mockUri);
    when(mockRequest.isForMainFrame()).thenReturn(true);
    when(mockRequest.getRequestHeaders()).thenReturn(null);

    final GeneratedAndroidWebView.WebResourceRequestData data =
        WebViewClientFlutterApiImpl.createWebResourceRequestData(mockRequest);
    assertEquals(data.getRequestHeaders(), new HashMap<String, String>());
  }

  @Test
  public void setReturnValueForShouldOverrideUrlLoading() {
    WebViewClientProxyApi.WebViewClientCompatImpl mockWebViewClient = mock();
    final WebViewClientProxyApi webViewClientHostApi =
        new WebViewClientProxyApi(
            instanceManager,
            new WebViewClientCreator() {
              @NonNull
              @Override
              public WebViewClient createWebViewClient(
                  @NonNull WebViewClientFlutterApiImpl flutterApi) {
                return mockWebViewClient;
              }
            },
            mockFlutterApi);

    instanceManager.addDartCreatedInstance(mockWebViewClient, 2);
    webViewClientHostApi.setSynchronousReturnValueForShouldOverrideUrlLoading(2L, false);

    verify(mockWebViewClient).setReturnValueForShouldOverrideUrlLoading(false);
  }

  @Test
  public void doUpdateVisitedHistory() {
    webViewClient.doUpdateVisitedHistory(mockWebView, "https://www.google.com", true);
    verify(mockFlutterApi)
        .doUpdateVisitedHistory(
            eq(webViewClient), eq(mockWebView), eq("https://www.google.com"), eq(true), any());
  }

  @Test
  public void onReceivedHttpError() {
    final Uri mockUri = mock(Uri.class);
    when(mockUri.toString()).thenReturn("");

    final WebResourceRequest mockRequest = mock(WebResourceRequest.class);
    when(mockRequest.getMethod()).thenReturn("method");
    when(mockRequest.getUrl()).thenReturn(mockUri);
    when(mockRequest.isForMainFrame()).thenReturn(true);
    when(mockRequest.getRequestHeaders()).thenReturn(null);

    final WebResourceResponse mockResponse = mock(WebResourceResponse.class);
    when(mockResponse.getStatusCode()).thenReturn(404);

    webViewClient.onReceivedHttpError(mockWebView, mockRequest, mockResponse);
    verify(mockFlutterApi)
        .onReceivedHttpError(
            eq(webViewClient),
            eq(mockWebView),
            any(WebResourceRequest.class),
            any(WebResourceResponse.class),
            any());
  }
}
