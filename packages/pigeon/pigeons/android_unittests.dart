// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

enum AndroidLoadingState {
  loading,
  complete,
}

class AndroidSetRequest {
  int? value;
  AndroidLoadingState? state;
}

class AndroidNestedRequest {
  String? context;
  AndroidSetRequest? request;
}

class AndroidNotNullableRequest {
  late int value;
  late AndroidLoadingState state;
  late String context;
}

@HostApi()
abstract class AndroidApi {
  void setValue(AndroidSetRequest request);
}

@HostApi()
abstract class AndroidNestedApi {
  void setValueWithContext(AndroidNestedRequest request);
}

@HostApi()
abstract class AndroidNotNullableApi {
  void setValueWithNotNullable(AndroidNotNullableRequest request);
}
