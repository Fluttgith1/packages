#!/bin/bash
# Copyright 2019 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -e

command -v cipd > /dev/null || {
  echo "Please install CIPD (available from depot_tools) and add to path first.";
  exit -1;
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

cipd ensure -ensure-file $DIR/ensure_file -root $DIR

pushd $DIR/..

# rm -rf build
mkdir -p build

tool/dart-sdk/bin/pub get

tool/dart-sdk/bin/dart2aot bin/main.dart build/main.aot
rm -f build/main.aot.dill
cp -f tool/dart-sdk/bin/dartaotruntime build/
cp -f tool/fuchsia_ctl build/
cp -f ../../LICENSE build/

popd
