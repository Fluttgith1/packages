// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

// Detects if we're running the tests on the main channel.
//
// This is useful for _tests_ that depend on _Flutter_ features that have not
// yet rolled to stable. Avoid using this to skip tests of _RFW_ features that
// aren't compatible with stable. Those should wait until the stable release
// channel is updated so that RFW can be compatible with it.
bool get isMainChannel {
  assert(!kIsWeb, 'isMainChannel is not available on web');
  return !Platform.environment.containsKey('CHANNEL') ||
      Platform.environment['CHANNEL'] == 'main' ||
      Platform.environment['CHANNEL'] == 'master';
}

// See Contributing section of README.md file.
final bool runGoldens = !kIsWeb && Platform.isLinux && isMainChannel;

// slide to value for material slider in tests
extension SlideTo on WidgetTester {
  Future<void> slideToValue(Finder slider, double value,
      {double paddingOffset = 24.0}) async {
    final Offset zeroPoint =
        getTopLeft(slider) + Offset(paddingOffset, getSize(slider).height / 2);
    final double totalWidth = getSize(slider).width - (2 * paddingOffset);
    final double calculateOffset = value * (totalWidth / 100);
    await dragFrom(zeroPoint, Offset(calculateOffset, 0));
  }
}
