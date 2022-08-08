// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:adaptive_scaffold_example/adaptive_scaffold_demo.dart'
    as example;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Finder smallBody = find.byKey(const Key('smallBody'));
  final Finder body = find.byKey(const Key('body'));
  final Finder largeBody = find.byKey(const Key('largeBody'));
  final Finder smallSBody = find.byKey(const Key('smallSBody'));
  final Finder sBody = find.byKey(const Key('sBody'));
  final Finder largeSBody = find.byKey(const Key('largeSBody'));
  final Finder bnav = find.byKey(const Key('bottomNavigation'));
  final Finder pnav = find.byKey(const Key('primaryNavigation'));
  final Finder pnav1 = find.byKey(const Key('primaryNavigation1'));
  testWidgets('dislays correct item of config based on screen width',
      (WidgetTester tester) async {
    updateScreen(double width) async {
      await tester.binding.setSurfaceSize(Size(width, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
              data: MediaQueryData(size: Size(width, 800)),
              child: example.MyHomePage()),
        ),
      );
      await tester.pumpAndSettle();
    }

    await updateScreen(300);
    expect(smallBody, findsOneWidget);
    expect(bnav, findsOneWidget);
    expect(body, findsNothing);
    expect(largeBody, findsNothing);
    expect(pnav, findsNothing);
    expect(pnav1, findsNothing);

    await updateScreen(800);
    expect(body, findsOneWidget);
    expect(body, findsOneWidget);
    expect(bnav, findsNothing);
    expect(largeBody, findsNothing);
    expect(pnav, findsOneWidget);
    expect(pnav1, findsNothing);

    await updateScreen(1100);
    expect(body, findsOneWidget);
    expect(pnav, findsNothing);
    expect(pnav1, findsOneWidget);
  });
}
