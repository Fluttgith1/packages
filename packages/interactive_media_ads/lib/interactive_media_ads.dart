// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'interactive_media_ads_platform_interface.dart';

class InteractiveMediaAds {
  Future<String?> getPlatformVersion() {
    return InteractiveMediaAdsPlatform.instance.getPlatformVersion();
  }
}
