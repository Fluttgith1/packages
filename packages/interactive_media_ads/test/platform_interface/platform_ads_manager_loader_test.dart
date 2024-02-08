// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_media_ads/interactive_media_ads.dart';
import 'package:interactive_media_ads/src/platform_interface/platform_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'platform_ads_manager_loader_test.mocks.dart';

@GenerateMocks(<Type>[
  InteractiveMediaAdsPlatform,
  PlatformAdsLoader,
  PlatformAdDisplayContainer,
])
void main() {
  setUp(() {
    InteractiveMediaAdsPlatform.instance =
        MockInteractiveMediaAdsPlatformWithMixin();
  });

  PlatformAdsLoaderCreationParams createEmptyParams() {
    return PlatformAdsLoaderCreationParams(
      container: MockPlatformAdDisplayContainer(),
      onAdsLoaded: (_) {},
      onAdsLoadError: (_) {},
    );
  }

  test('Cannot be implemented with `implements`', () {
    when((InteractiveMediaAdsPlatform.instance!
                as MockInteractiveMediaAdsPlatform)
            .createPlatformAdsLoader(any))
        .thenReturn(ImplementsPlatformAdsLoader());

    expect(
      () => PlatformAdsLoader(createEmptyParams()),
      throwsAssertionError,
    );
  });

  test('Can be extended', () {
    when((InteractiveMediaAdsPlatform.instance!
                as MockInteractiveMediaAdsPlatform)
            .createPlatformAdsLoader(any))
        .thenReturn(ExtendsPlatformAdsLoader(createEmptyParams()));

    expect(PlatformAdsLoader(createEmptyParams()), isNotNull);
  });

  test(
      'Default implementation of contentComplete should throw unimplemented error',
      () {
    final PlatformAdsLoader loader =
        ExtendsPlatformAdsLoader(createEmptyParams());

    expect(
      () => loader.contentComplete(),
      throwsUnimplementedError,
    );
  });

  test('Default implementation of requestAds should throw unimplemented error',
      () {
    final PlatformAdsLoader loader =
        ExtendsPlatformAdsLoader(createEmptyParams());

    expect(
      () => loader.requestAds(AdsRequest(adTagUrl: '')),
      throwsUnimplementedError,
    );
  });
}

class MockInteractiveMediaAdsPlatformWithMixin
    extends MockInteractiveMediaAdsPlatform with MockPlatformInterfaceMixin {}

class ImplementsPlatformAdsLoader implements PlatformAdsLoader {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class ExtendsPlatformAdsLoader extends PlatformAdsLoader {
  ExtendsPlatformAdsLoader(super.params) : super.implementation();
}
