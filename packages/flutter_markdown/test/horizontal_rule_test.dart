// Copyright 2020 Quiverware LLC. Open source contribution. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'utils.dart';

void main() => defineTests();

void defineTests() {
  group('Horizontal Rule', () {
    testWidgets(
      '3 consecutive hyphens',
      (WidgetTester tester) async {
        const String data = '---';
        await tester.pumpWidget(boilerplate(const MarkdownBody(data: data)));

        final Iterable<Widget> widgets = tester.allWidgets;
        expectWidgetTypes(widgets, <Type>[
          Directionality,
          MarkdownBody,
          Container,
          DecoratedBox,
          Padding,
          LimitedBox,
          ConstrainedBox
        ]);
      },
    );

    testWidgets(
      '5 consecutive hyphens',
      (WidgetTester tester) async {
        const String data = '-----';
        await tester.pumpWidget(boilerplate(const MarkdownBody(data: data)));

        final Iterable<Widget> widgets = tester.allWidgets;
        expectWidgetTypes(widgets, <Type>[
          Directionality,
          MarkdownBody,
          Container,
          DecoratedBox,
          Padding,
          LimitedBox,
          ConstrainedBox
        ]);
      },
    );

    testWidgets(
      '3 asterisks separated with spaces',
      (WidgetTester tester) async {
        const String data = '* * *';
        await tester.pumpWidget(boilerplate(const MarkdownBody(data: data)));

        final Iterable<Widget> widgets = tester.allWidgets;
        expectWidgetTypes(widgets, <Type>[
          Directionality,
          MarkdownBody,
          Container,
          DecoratedBox,
          Padding,
          LimitedBox,
          ConstrainedBox
        ]);
      },
    );

    testWidgets(
      '3 asterisks separated with spaces alongside text Markdown',
      (WidgetTester tester) async {
        const String data = '# h1\n ## h2\n* * *';
        await tester.pumpWidget(boilerplate(const MarkdownBody(data: data)));

        final Iterable<Widget> widgets = tester.allWidgets;
        expectWidgetTypes(widgets, <Type>[
          Directionality,
          MarkdownBody,
          Column,
          Column,
          Wrap,
          RichText,
          SizedBox,
          Column,
          Wrap,
          RichText,
          SizedBox,
          Container,
          DecoratedBox,
          Padding,
          LimitedBox,
          ConstrainedBox
        ]);
      },
    );
  });
}
