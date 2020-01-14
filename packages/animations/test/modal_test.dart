// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:animations/src/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  testWidgets(
    'showModal builds a new route',
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
                      configuration: _TestModalConfiguration(),
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

  // runs backwards

  // does not get interrupted when run in reverse

  // state is not lost when transitioning
}

class _FlutterLogoModal extends StatelessWidget {
  const _FlutterLogoModal();

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

class _TestModalConfiguration extends ModalConfiguration {
  /// Creates the Material fade transition configuration.
  _TestModalConfiguration({
    bool barrierDismissible = true,
    String barrierLabel,
  })  : assert(barrierDismissible != null),
        super(
          barrierDismissible: barrierDismissible,
          barrierLabel: barrierLabel,
        );

  @override
  Color get barrierColor => Colors.green;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 200);

  @override
  Widget transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}