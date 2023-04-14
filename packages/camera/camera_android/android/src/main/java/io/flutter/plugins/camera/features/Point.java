// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.camera.features;

import androidx.annotation.NonNull;

/** Represents a point on an x/y axis. */
public class Point {
  public final Double x;
  public final Double y;

  public Point(@NonNull Double x, @NonNull Double y) {
    this.x = x;
    this.y = y;
  }
}
