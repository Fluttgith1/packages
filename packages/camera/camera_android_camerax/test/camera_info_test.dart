// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:camera_android_camerax/src/camera_info.dart';
import 'package:camera_android_camerax/src/camerax_library.g.dart';
import 'package:camera_android_camerax/src/instance_manager.dart';
import 'package:camera_android_camerax/src/live_camera_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'camera_info_test.mocks.dart';
import 'test_camerax_library.g.dart';

@GenerateMocks(<Type>[TestCameraInfoHostApi, TestInstanceManagerHostApi])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mocks the call to clear the native InstanceManager.
  TestInstanceManagerHostApi.setup(MockTestInstanceManagerHostApi());

  group('CameraInfo', () {
    tearDown(() => TestCameraInfoHostApi.setup(null));

    test('getSensorRotationDegreesTest', () async {
      final MockTestCameraInfoHostApi mockApi = MockTestCameraInfoHostApi();
      TestCameraInfoHostApi.setup(mockApi);

      final InstanceManager instanceManager = InstanceManager(
        onWeakReferenceRemoved: (_) {},
      );
      final CameraInfo cameraInfo = CameraInfo.detached(
        instanceManager: instanceManager,
      );
      instanceManager.addHostCreatedInstance(
        cameraInfo,
        0,
        onCopy: (_) => CameraInfo.detached(),
      );

      when(mockApi.getSensorRotationDegrees(
              instanceManager.getIdentifier(cameraInfo)))
          .thenReturn(90);
      expect(await cameraInfo.getSensorRotationDegrees(), equals(90));

      verify(mockApi.getSensorRotationDegrees(0));
    });

    test('getLiveCameraState makes call to retrieve live camera state',
        () async {
      final MockTestCameraInfoHostApi mockApi = MockTestCameraInfoHostApi();
      TestCameraInfoHostApi.setup(mockApi);

      final InstanceManager instanceManager = InstanceManager(
        onWeakReferenceRemoved: (_) {},
      );
      final CameraInfo cameraInfo = CameraInfo.detached(
        instanceManager: instanceManager,
      );
      const int cameraIdentifier = 55;
      final LiveCameraState liveCameraState = LiveCameraState.detached(
        instanceManager: instanceManager,
      );
      const int liveCameraStateIdentifier = 73;
      instanceManager.addHostCreatedInstance(
        cameraInfo,
        cameraIdentifier,
        onCopy: (_) => CameraInfo.detached(),
      );
      instanceManager.addHostCreatedInstance(
        liveCameraState,
        liveCameraStateIdentifier,
        onCopy: (_) => LiveCameraState.detached(),
      );

      when(mockApi.getLiveCameraState(cameraIdentifier))
          .thenReturn(liveCameraStateIdentifier);

      expect(await cameraInfo.getLiveCameraState(), equals(liveCameraState));
      verify(mockApi.getLiveCameraState(cameraIdentifier));
    });

    test('flutterApiCreateTest', () {
      final InstanceManager instanceManager = InstanceManager(
        onWeakReferenceRemoved: (_) {},
      );
      final CameraInfoFlutterApi flutterApi = CameraInfoFlutterApiImpl(
        instanceManager: instanceManager,
      );

      flutterApi.create(0);

      expect(
          instanceManager.getInstanceWithWeakReference(0), isA<CameraInfo>());
    });
  });
}
