import 'package:flutter/material.dart';
import 'package:flutter_image_example/main.dart' as example;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'example works',
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(const example.MyApp());

      await widgetTester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
    },
  );
}
