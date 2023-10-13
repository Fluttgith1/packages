// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:quick_actions_android/quick_actions_android.dart';
import 'package:quick_actions_android/src/messages.g.dart';
import 'package:quick_actions_platform_interface/quick_actions_platform_interface.dart';

const String LAUNCH_ACTION_STRING = 'aString';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final _FakeQuickActionsApi api = _FakeQuickActionsApi();
  final QuickActionsAndroid quickActions = QuickActionsAndroid(api: api);

  test('registerWith() registers correct instance', () {
    QuickActionsAndroid.registerWith();
    expect(QuickActionsPlatform.instance, isA<QuickActionsAndroid>());
  });

  group('#initialize', () {
    test('passes getLaunchAction on launch method', () {
      quickActions.initialize((String type) {});

      expect(api.launchAction, LAUNCH_ACTION_STRING);
    });

    test('initialize', () async {
      final Completer<bool> quickActionsHandler = Completer<bool>();
      await quickActions.initialize((_) => quickActionsHandler.complete(true));

      expect(quickActionsHandler.future, completion(isTrue));
    });
  });

  test('setShortCutItems', () async {
    await quickActions.initialize((String type) {});
    const ShortcutItem item =
        ShortcutItem(type: 'test', localizedTitle: 'title', icon: 'icon.svg');
    await quickActions.setShortcutItems(<ShortcutItem>[item]);

    expect(api.items.first.type, item.type);
    expect(api.items.first.localizedTitle, item.localizedTitle);
    expect(api.items.first.icon, item.icon);
  });

  test('clearShortCutItems', () {
    quickActions.initialize((String type) {});
    const ShortcutItem item =
        ShortcutItem(type: 'test', localizedTitle: 'title', icon: 'icon.svg');
    quickActions.setShortcutItems(<ShortcutItem>[item]);
    quickActions.clearShortcutItems();

    expect(api.items.isEmpty, true);
  });

  test('Shortcut item can be constructed', () {
    const String type = 'type';
    const String localizedTitle = 'title';
    const String icon = 'foo';

    const ShortcutItem item =
        ShortcutItem(type: type, localizedTitle: localizedTitle, icon: icon);

    expect(item.type, type);
    expect(item.localizedTitle, localizedTitle);
    expect(item.icon, icon);
  });
}

class _FakeQuickActionsApi implements AndroidQuickActionsApi {
  List<ShortcutItem> items = <ShortcutItem>[];
  String? launchAction;

  @override
  Future<void> clearShortcutItems() {
    items = <ShortcutItem>[];
    return Future<void>.value();
  }

  @override
  Future<String?> getLaunchAction() {
    launchAction = LAUNCH_ACTION_STRING;
    return Future<String?>.value(launchAction);
  }

  @override
  Future<void> setShortcutItems(List<ShortcutItemMessage?> itemsList) async {
    await clearShortcutItems();
    for (final ShortcutItemMessage? element in itemsList) {
      if (element != null) {
        items.add(
            QuickActionsAndroid.shortcutItemMessageToShortcutItem(element));
      }
    }
  }
}
