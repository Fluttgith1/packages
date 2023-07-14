package io.flutter.plugins.urllauncher;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

public class FlutterWebViewClient extends WebViewClient {
  @Override
  public void onLoadResource(WebView view, String url) {
    if (!resourceShouldOpenDocument(view, url)) {
      super.onLoadResource(view, url);
    }
  }

  /*
   * This method is deprecated in API 24. Still overridden to support
   * earlier Android versions.
   */
  @SuppressWarnings("deprecation")
  @Override
  public boolean shouldOverrideUrlLoading(WebView view, String url) {
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP) {
      if (urlShouldRunActivity(view, url)) {
        return true;
      } else {
        view.loadUrl(url);
      }
      return false;
    }
    return super.shouldOverrideUrlLoading(view, url);
  }

  @RequiresApi(Build.VERSION_CODES.N)
  @Override
  public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      String url = request.getUrl().toString();
      if (urlShouldRunActivity(view, url)) {
        return true;
      } else {
        view.loadUrl(url);
      }
    }
    return false;
  }

  public static boolean resourceShouldOpenDocument(@NonNull WebView view, @NonNull String url) {
    // Check if URL is PDF
    if (url.endsWith(".pdf")) {
      Intent intent = new Intent(Intent.ACTION_VIEW);
      intent.setDataAndType(Uri.parse(url), "application/pdf");
      view.getContext().startActivity(intent);
      return true;
    }
    return false;
  }

  public static boolean urlShouldRunActivity(@NonNull WebView view, @NonNull String url) {
    // Check if URL is not an HTTP(S) request
    // Handles mailto:, sms:, etc.
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
      view.getContext().startActivity(intent);
      return true;
    }

    // Otherwise, let WebView load URL
    return false;
  }
}
