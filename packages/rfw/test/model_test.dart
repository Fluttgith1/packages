// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is hand-formatted.

import 'package:flutter_test/flutter_test.dart';
import 'package:rfw/formats.dart';

void main() {
  testWidgets('$LibraryName', (WidgetTester tester) async {
    T deconst<T>(T value) => value;
    final LibraryName a = LibraryName(<String>['core', deconst<String>('widgets')]);
    final LibraryName b = LibraryName(<String>['core', deconst<String>('widgets')]);
    final LibraryName c = LibraryName(<String>['core', deconst<String>('material')]);
    const LibraryName d = LibraryName(<String>['core']);
    expect('$a', 'core.widgets');
    expect('$c', 'core.material');
    expect(a, equals(b));
    expect(a.hashCode, equals(b.hashCode));
    expect(a, isNot(equals(c)));
    expect(a.hashCode, isNot(equals(c.hashCode)));
    expect(a.compareTo(b), 0);
    expect(b.compareTo(a), 0);
    expect(a.compareTo(c), 1);
    expect(c.compareTo(a), -1);
    expect(b.compareTo(c), 1);
    expect(c.compareTo(b), -1);
    expect(a.compareTo(d), 1);
    expect(b.compareTo(d), 1);
    expect(c.compareTo(d), 1);
    expect(d.compareTo(a), -1);
    expect(d.compareTo(b), -1);
    expect(d.compareTo(c), -1);
  });

  testWidgets('$FullyQualifiedWidgetName', (WidgetTester tester) async {
    const FullyQualifiedWidgetName aa = FullyQualifiedWidgetName(LibraryName(<String>['a']), 'a');
    const FullyQualifiedWidgetName ab = FullyQualifiedWidgetName(LibraryName(<String>['a']), 'b');
    const FullyQualifiedWidgetName bb = FullyQualifiedWidgetName(LibraryName(<String>['b']), 'b');
    expect('$aa', 'a:a');
    expect(aa, isNot(equals(bb)));
    expect(aa.hashCode, isNot(equals(bb.hashCode)));
    expect(aa.compareTo(aa), 0);
    expect(aa.compareTo(ab), -1);
    expect(aa.compareTo(bb), -1);
    expect(ab.compareTo(aa), 1);
    expect(ab.compareTo(ab), 0);
    expect(ab.compareTo(bb), -1);
    expect(bb.compareTo(aa), 1);
    expect(bb.compareTo(ab), 1);
    expect(bb.compareTo(bb), 0);
  });

  testWidgets('toStrings', (WidgetTester tester) async {
    expect('$missing', '<missing>');
    expect('${const Loop(0, 1)}', '...for loop in 0: 1');
    expect('${const Switch(0, <Object?, Object>{1: 2})}', 'switch 0 {1: 2}');
    expect('${const ConstructorCall("a", <String, Object>{})}', 'a({})');
    expect('${const ArgsReference(<Object>["a"])}', 'args.a');
    expect('${const BoundArgsReference(false, <Object>["a"])}', 'args(false).a');
    expect('${const DataReference(<Object>["a"])}', 'data.a');
    expect('${const LoopReference(0, <Object>["a"])}', 'loop0.a');
    expect('${const BoundLoopReference(0, <Object>["a"])}', 'loop(0).a');
    expect('${const StateReference(<Object>["a"])}', 'state.a');
    expect('${const BoundStateReference(0, <Object>["a"])}', 'state^0.a');
    expect('${const EventHandler("a", <String, Object?>{})}', 'event a {}');
    expect('${const SetStateHandler(StateReference(<Object>["a"]), false)}', 'set state.a = false');
    expect('${const Import(LibraryName(<String>["a"]))}', 'import a;');
    expect('${const WidgetDeclaration("a", null, ConstructorCall("b", <String, Object>{}))}', 'widget a = b({});');
    expect('${const WidgetDeclaration("a", <String, Object?>{ "x": false }, ConstructorCall("b", <String, Object>{}))}', 'widget a = b({});');
    expect('${const RemoteWidgetLibrary(<Import>[Import(LibraryName(<String>["a"]))], <WidgetDeclaration>[WidgetDeclaration("a", null, ConstructorCall("b", <String, Object>{}))])}', 'import a;\nwidget a = b({});');
  });

  testWidgets('$BoundArgsReference', (WidgetTester tester) async {
    final Object target = Object();
    final BoundArgsReference result = const ArgsReference(<Object>[0]).bind(target);
    expect(result.arguments, target);
    expect(result.parts, const <Object>[0]);
  });

  testWidgets('$DataReference', (WidgetTester tester) async {
    final DataReference result = const DataReference(<Object>[0]).constructReference(<Object>[1]);
    expect(result.parts, const <Object>[0, 1]);
  });

  testWidgets('$LoopReference', (WidgetTester tester) async {
    final LoopReference result = const LoopReference(9, <Object>[0]).constructReference(<Object>[1]);
    expect(result.parts, const <Object>[0, 1]);
  });

  testWidgets('$BoundLoopReference', (WidgetTester tester) async {
    final Object target = Object();
    final BoundLoopReference result = const LoopReference(9, <Object>[0]).bind(target).constructReference(<Object>[1]);
    expect(result.value, target);
    expect(result.parts, const <Object>[0, 1]);
  });

  testWidgets('$BoundStateReference', (WidgetTester tester) async {
    final BoundStateReference result = const StateReference(<Object>[0]).bind(9).constructReference(<Object>[1]);
    expect(result.depth, 9);
    expect(result.parts, const <Object>[0, 1]);
  });
}
