// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:animations/src/fade_transition.dart';
import 'package:animations/src/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  testWidgets(
    'FadeTransitionConfiguration builds a new route',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Center(
                child: RaisedButton(
                  onPressed: () {
                    showModal(
                      context: context,
                      configuration: FadeTransitionConfiguration(),
                      builder: (BuildContext context) {
                        return const _FlutterLogoModal();
                      },
                    );
                  },
                  child: Icon(Icons.add),
                ),
              );
            }),
          ),
        ),
      );
      await tester.tap(find.byType(RaisedButton));
      await tester.pumpAndSettle();
      expect(find.byType(_FlutterLogoModal), findsOneWidget);
    },
  );

  // runs forward
  testWidgets(
    'FadeTransitionConfiguration runs forward',
    (WidgetTester tester) async {
      final GlobalKey key = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Center(
                child: RaisedButton(
                  onPressed: () {
                    showModal(
                      context: context,
                      configuration: FadeTransitionConfiguration(),
                      builder: (BuildContext context) {
                        return _FlutterLogoModal(key: key);
                      },
                    );
                  },
                  child: Icon(Icons.add),
                ),
              );
            }),
          ),
        ),
      );
      await tester.tap(find.byType(RaisedButton));
      await tester.pump();
      // Opacity duration: First 30% of 150ms, linear transition
      double topFadeTransitionOpacity = _getOpacity(key, tester);
      double topScale = _getScale(key, tester);
      expect(topFadeTransitionOpacity, 0.0);
      expect(topScale, 0.80);

      // 3/10 * 150ms = 45ms (total opacity animation duration)
      // 1/2 * 45ms = ~23ms elapsed for halfway point of opacity
      // animation
      await tester.pump(const Duration(milliseconds: 23));
      topFadeTransitionOpacity = _getOpacity(key, tester);
      expect(topFadeTransitionOpacity, closeTo(0.5, 0.05));
      topScale = _getScale(key, tester);
      expect(topScale, greaterThan(0.80));
      expect(topScale, lessThan(1.0));

      // End of opacity animation
      await tester.pump(const Duration(milliseconds: 22));
      topFadeTransitionOpacity = _getOpacity(key, tester);
      expect(topFadeTransitionOpacity, 1.0);
      topScale = _getScale(key, tester);
      expect(topScale, greaterThan(0.80));
      expect(topScale, lessThan(1.0));

      // 100ms into the animation
      await tester.pump(const Duration(milliseconds: 55));
      topScale = _getScale(key, tester);
      expect(topScale, greaterThan(0.80));
      expect(topScale, lessThan(1.0));

      // Get to the end of the animation
      await tester.pump(const Duration(milliseconds: 50));
      topScale = _getScale(key, tester);
      expect(topScale, 1.0);

      await tester.pump();
      expect(find.byType(_FlutterLogoModal), findsOneWidget);
    },
  );

  // runs backwards
  testWidgets(
    'FadeTransitionConfiguration runs forward',
    (WidgetTester tester) async {
      final GlobalKey key = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Center(
                child: RaisedButton(
                  onPressed: () {
                    showModal(
                      context: context,
                      configuration: FadeTransitionConfiguration(),
                      builder: (BuildContext context) {
                        return _FlutterLogoModal(key: key);
                      },
                    );
                  },
                  child: Icon(Icons.add),
                ),
              );
            }),
          ),
        ),
      );
      // Show the incoming modal and let it animate in fully.
      await tester.tap(find.byType(RaisedButton));
      await tester.pumpAndSettle();

      // Tap on modal barrier to start reverse animation.
      await tester.tapAt(Offset.zero);
      await tester.pump();

      // Opacity duration: Linear transition throughout 75ms
      // No scale animations on exit transition.
      double topFadeTransitionOpacity = _getOpacity(key, tester);
      double topScale = _getScale(key, tester);
      expect(topFadeTransitionOpacity, 1.0);
      expect(topScale, 1.0);

      await tester.pump(const Duration(milliseconds: 25));
      topFadeTransitionOpacity = _getOpacity(key, tester);
      topScale = _getScale(key, tester);
      expect(topFadeTransitionOpacity, closeTo(0.66, 0.05));
      expect(topScale, 1.0);

      await tester.pump(const Duration(milliseconds: 25));
      topFadeTransitionOpacity = _getOpacity(key, tester);
      topScale = _getScale(key, tester);
      expect(topFadeTransitionOpacity, closeTo(0.33, 0.05));
      expect(topScale, 1.0);

      // End of opacity animation
      await tester.pump(const Duration(milliseconds: 25));
      topFadeTransitionOpacity = _getOpacity(key, tester);
      expect(topFadeTransitionOpacity, 0.0);
      topScale = _getScale(key, tester);
      expect(topScale, 1.0);

      await tester.pump(const Duration(milliseconds: 1));
      expect(find.byType(_FlutterLogoModal), findsNothing);
    },
  );


  // does not get interrupted when run in reverse

  // state is not lost when transitioning
}

double _getOpacity(GlobalKey key, WidgetTester tester) {
  final Finder finder = find.ancestor(
    of: find.byKey(key),
    matching: find.byType(FadeTransition),
  );
  return tester.widgetList(finder).fold<double>(1.0, (double a, Widget widget) {
    final FadeTransition transition = widget;
    return a * transition.opacity.value;
  });
}

double _getScale(GlobalKey key, WidgetTester tester) {
  final Finder finder = find.ancestor(
    of: find.byKey(key),
    matching: find.byType(ScaleTransition),
  );
  return tester.widgetList(finder).fold<double>(1.0, (double a, Widget widget) {
    final ScaleTransition transition = widget;
    return a * transition.scale.value;
  });
}

class _FlutterLogoModal extends StatelessWidget {
  const _FlutterLogoModal({
    Key key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Material(
          child: Center(
            child: FlutterLogo(size: 250),
          ),
        ),
      ),
    );
  }
}
