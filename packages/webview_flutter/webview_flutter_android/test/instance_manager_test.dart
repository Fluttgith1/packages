// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:webview_flutter_android/src/instance_manager.dart';

import 'instance_manager_test.mocks.dart';
import 'test_android_webview.g.dart';

@GenerateMocks(<Type>[TestInstanceManagerHostApi])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('InstanceManager', () {
    test('addHostCreatedInstance', () {
      final Object object = Object();

      final InstanceManager instanceManager =
          InstanceManager(onWeakReferenceRemoved: (_) {});

      instanceManager.addHostCreatedInstance(
        object,
        0,
        onCopy: (_) => Object(),
      );

      expect(instanceManager.getIdentifier(object), 0);
      expect(
        instanceManager.getInstanceWithWeakReference(0),
        object,
      );
    });

    test('addHostCreatedInstance prevents already used objects and ids', () {
      final Object object = Object();

      final InstanceManager instanceManager =
          InstanceManager(onWeakReferenceRemoved: (_) {});

      instanceManager.addHostCreatedInstance(
        object,
        0,
        onCopy: (_) => Object(),
      );

      expect(
        () => instanceManager.addHostCreatedInstance(
          object,
          0,
          onCopy: (_) => Object(),
        ),
        throwsAssertionError,
      );

      expect(
        () => instanceManager.addHostCreatedInstance(
          Object(),
          0,
          onCopy: (_) => Object(),
        ),
        throwsAssertionError,
      );
    });

    test('addDartCreatedInstance', () {
      final Object object = Object();

      final InstanceManager instanceManager =
          InstanceManager(onWeakReferenceRemoved: (_) {});

      instanceManager.addDartCreatedInstance(
        object,
        onCopy: (_) => Object(),
      );

      final int? instanceId = instanceManager.getIdentifier(object);
      expect(instanceId, isNotNull);
      expect(
        instanceManager.getInstanceWithWeakReference(instanceId!),
        object,
      );
    });

    test('removeWeakReference', () {
      final Object object = Object();

      int? weakInstanceId;
      final InstanceManager instanceManager =
          InstanceManager(onWeakReferenceRemoved: (int instanceId) {
        weakInstanceId = instanceId;
      });

      instanceManager.addHostCreatedInstance(
        object,
        0,
        onCopy: (_) => Object(),
      );

      expect(instanceManager.removeWeakReference(object), 0);
      expect(
        instanceManager.getInstanceWithWeakReference(0),
        isA<Object>(),
      );
      expect(weakInstanceId, 0);
    });

    test('removeWeakReference removes only weak reference', () {
      final Object object = Object();

      final InstanceManager instanceManager =
          InstanceManager(onWeakReferenceRemoved: (_) {});

      instanceManager.addHostCreatedInstance(
        object,
        0,
        onCopy: (_) => Object(),
      );

      expect(instanceManager.removeWeakReference(object), 0);
      final Object copy = instanceManager.getInstanceWithWeakReference(
        0,
      )!;
      expect(identical(object, copy), isFalse);
    });

    test('removeStrongReference', () {
      final Object object = Object();

      final InstanceManager instanceManager =
          InstanceManager(onWeakReferenceRemoved: (_) {});

      instanceManager.addHostCreatedInstance(
        object,
        0,
        onCopy: (_) => Object(),
      );
      instanceManager.removeWeakReference(object);
      expect(instanceManager.remove(0), isA<Object>());
      expect(instanceManager.containsIdentifier(0), isFalse);
    });

    test('removeStrongReference removes only strong reference', () {
      final Object object = Object();

      final InstanceManager instanceManager =
          InstanceManager(onWeakReferenceRemoved: (_) {});

      instanceManager.addHostCreatedInstance(
        object,
        0,
        onCopy: (_) => Object(),
      );
      expect(instanceManager.remove(0), isA<Object>());
      expect(
        instanceManager.getInstanceWithWeakReference(0),
        object,
      );
    });

    test('getInstance can add a new weak reference', () {
      final Object object = Object();

      final InstanceManager instanceManager =
          InstanceManager(onWeakReferenceRemoved: (_) {});

      instanceManager.addHostCreatedInstance(
        object,
        0,
        onCopy: (_) => Object(),
      );
      instanceManager.removeWeakReference(object);

      final Object newWeakCopy = instanceManager.getInstanceWithWeakReference(
        0,
      )!;
      expect(identical(object, newWeakCopy), isFalse);
    });

    test('globalInstanceManager clears native `InstanceManager`', () {
      final MockTestInstanceManagerHostApi mockApi =
          MockTestInstanceManagerHostApi();
      TestInstanceManagerHostApi.setup(mockApi);

      BaseObject.globalInstanceManager;

      verify(mockApi.clear());

      TestInstanceManagerHostApi.setup(null);
    });
  });
}
