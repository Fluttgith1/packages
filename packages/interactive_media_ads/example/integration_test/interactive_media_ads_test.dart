// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:interactive_media_ads_example/main.dart' as app;

/// Entry point for integration tests that require espresso.
@pragma('vm:entry-point')
void integrationTestMain() {
  enableFlutterDriverExtension();
  app.main();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('AdDisplayContain', (WidgetTester tester) async {});
}
