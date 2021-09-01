// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// # Remote Flutter Widgets
///
/// Renders a widget tree described in a file, which you can change at runtime.
///
/// There are many ways to use a package such as this one. In general, the
/// approach looks something like this:
///
/// ![The Remote Flutter Widgets comes from the server over the network and into the Runtime. The Runtime also receives the Data model, which is populated both from Client data and from Server data obtained over the network. The Runtime creates Flutter Widgets, which send state updates back to the Runtime, and send user input to the Client logic, which either directly changes the Client data, or sends messages over the network to the Server logic, which then updates the Server data.](https://raw.githubusercontent.com/flutter/packages/master/packages/rfw/images/overview1.png)
///
/// The network aspects of this design are out of scope for this package. Remote
/// widget libraries and data should be cached locally, to avoid network issues
/// causing interface failures.
///
/// In the extreme, this package can be combined with a local scripting runtime
/// (e.g. [https://pub.dev/packages/hetu_script](hetu_script)) to run
/// remotely-fetched logic locally:
///
/// ![The Remote Flutter Widgets once again come from the server and follow the same path via the network to the Runtime. The Runtime combines this with the Data model to generate the Flutter Widgets, which send state updates directly back to the runtime and user input to the Hard-coded client logic. That logic updates the Client data which updates the Data model, but also sends messages to the Scripting engine which is also on the Client. The Scripting engine is configured from Scripts obtained over the network, and generates Script data that also populates the Data model.](https://raw.githubusercontent.com/flutter/packages/master/packages/rfw/images/overview2.png)
///
///
/// ## Using the [RemoteWidget] widget
///
/// To use a
///
/// ## Server-side dart
///
/// This package can be used in non-Flutter environments by importing
/// `package:rfw/formats.dart` rather than `package:rfw/rfw.dart`. In the
/// `formats` mode, the [Runtime] and [DynamicContent] objects, as well as the
/// [RemoteWidget] widget, are not available, but the [parseLibraryFile],
/// [decodeLibraryBlob], and related methods and classes are available.
library rfw;

export 'dart/binary.dart';
export 'dart/model.dart';
export 'dart/text.dart';
export 'flutter/argument_decoders.dart';
export 'flutter/content.dart';
export 'flutter/core_widgets.dart';
export 'flutter/material_widgets.dart';
export 'flutter/remote_widget.dart';
export 'flutter/runtime.dart';
