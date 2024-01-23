// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:mime/mime.dart' as mime;

import 'src/image_resizer.dart';

const String _kImagePickerInputsDomId = '__image_picker_web-file-input';
const String _kAcceptImageMimeType = 'image/*';
const String _kAcceptVideoMimeType = 'video/3gpp,video/x-m4v,video/mp4,video/*';

/// The web implementation of [ImagePickerPlatform].
///
/// This class implements the `package:image_picker` functionality for the web.
class ImagePickerPlugin extends ImagePickerPlatform {
  /// A constructor that allows tests to override the function that creates file inputs.
  ImagePickerPlugin({
    @visibleForTesting ImagePickerPluginTestOverrides? overrides,
    @visibleForTesting ImageResizer? imageResizer,
  }) : _overrides = overrides {
    _imageResizer = imageResizer ?? ImageResizer();
    _target = _ensureInitialized(_kImagePickerInputsDomId);
  }

  final ImagePickerPluginTestOverrides? _overrides;

  bool get _hasOverrides => _overrides != null;

  late html.Element _target;

  late ImageResizer _imageResizer;

  /// Registers this class as the default instance of [ImagePickerPlatform].
  static void registerWith(Registrar registrar) {
    ImagePickerPlatform.instance = ImagePickerPlugin();
  }

  /// Returns an [XFile] with the image that was picked, or `null` if no images were picked.
  @override
  Future<XFile?> getImageFromSource({
    required ImageSource source,
    ImagePickerOptions options = const ImagePickerOptions(),
  }) async {
    final String? capture =
        computeCaptureAttribute(source, options.preferredCameraDevice);
    final List<XFile> files = await getFiles(
      accept: _kAcceptImageMimeType,
      capture: capture,
    );
    return files.isEmpty
        ? null
        : _imageResizer.resizeImageIfNeeded(
            files.first,
            options.maxWidth,
            options.maxHeight,
            options.imageQuality,
          );
  }

  /// Returns a [List<XFile>] with the images that were picked, if any.
  @override
  Future<List<XFile>> getMultiImageWithOptions({
    MultiImagePickerOptions options = const MultiImagePickerOptions(),
  }) async {
    final List<XFile> images = await getFiles(
      accept: _kAcceptImageMimeType,
      multiple: true,
    );
    final Iterable<Future<XFile>> resized = images.map(
      (XFile image) => _imageResizer.resizeImageIfNeeded(
        image,
        options.imageOptions.maxWidth,
        options.imageOptions.maxHeight,
        options.imageOptions.imageQuality,
      ),
    );

    return Future.wait<XFile>(resized);
  }

  /// Returns an [XFile] containing the video that was picked.
  ///
  /// The [source] argument controls where the video comes from. This can
  /// be either [ImageSource.camera] or [ImageSource.gallery].
  ///
  /// Note that the `maxDuration` argument is not supported on the web. If the argument is supplied, it'll be silently ignored by the web version of the plugin.
  ///
  /// Use `preferredCameraDevice` to specify the camera to use when the `source` is [ImageSource.camera].
  /// The `preferredCameraDevice` is ignored when `source` is [ImageSource.gallery]. It is also ignored if the chosen camera is not supported on the device.
  /// Defaults to [CameraDevice.rear].
  ///
  /// If no images were picked, the return value is null.
  @override
  Future<XFile?> getVideo({
    required ImageSource source,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    Duration? maxDuration,
  }) async {
    final String? capture =
        computeCaptureAttribute(source, preferredCameraDevice);
    final List<XFile> files = await getFiles(
      accept: _kAcceptVideoMimeType,
      capture: capture,
    );
    return files.isEmpty ? null : files.first;
  }

  /// Injects a file input, and returns a list of XFile media that the user selected locally.
  @override
  Future<List<XFile>> getMedia({
    required MediaOptions options,
  }) async {
    final List<XFile> images = await getFiles(
      accept: '$_kAcceptImageMimeType,$_kAcceptVideoMimeType',
      multiple: options.allowMultiple,
    );
    final Iterable<Future<XFile>> resized = images.map((XFile media) {
      if (mime.lookupMimeType(media.path)?.startsWith('image/') ?? false) {
        return _imageResizer.resizeImageIfNeeded(
          media,
          options.imageOptions.maxWidth,
          options.imageOptions.maxHeight,
          options.imageOptions.imageQuality,
        );
      }
      return Future<XFile>.value(media);
    });

    return Future.wait<XFile>(resized);
  }

  /// Injects a file input with the specified accept+capture attributes, and
  /// returns a list of XFile that the user selected locally.
  ///
  /// `capture` is only supported in mobile browsers.
  ///
  /// `multiple` can be passed to allow for multiple selection of files. Defaults
  /// to false.
  ///
  /// See https://caniuse.com/#feat=html-media-capture
  @visibleForTesting
  Future<List<XFile>> getFiles({
    String? accept,
    String? capture,
    bool multiple = false,
  }) {
    final html.FileUploadInputElement input = createInputElement(
      accept,
      capture,
      multiple: multiple,
    ) as html.FileUploadInputElement;
    _injectAndActivate(input);

    return _getSelectedXFiles(input).whenComplete(input.remove);
  }

  // Deprecated methods follow...

  /// Returns an [XFile] with the image that was picked.
  ///
  /// The `source` argument controls where the image comes from. This can
  /// be either [ImageSource.camera] or [ImageSource.gallery].
  ///
  /// Note that the `maxWidth`, `maxHeight` and `imageQuality` arguments are not supported on the web. If any of these arguments is supplied, it'll be silently ignored by the web version of the plugin.
  ///
  /// Use `preferredCameraDevice` to specify the camera to use when the `source` is [ImageSource.camera].
  /// The `preferredCameraDevice` is ignored when `source` is [ImageSource.gallery]. It is also ignored if the chosen camera is not supported on the device.
  /// Defaults to [CameraDevice.rear].
  ///
  /// If no images were picked, the return value is null.
  @override
  @Deprecated('Use getImageFromSource instead.')
  Future<XFile?> getImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    return getImageFromSource(
        source: source,
        options: ImagePickerOptions(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: imageQuality,
          preferredCameraDevice: preferredCameraDevice,
        ));
  }

  /// Injects a file input, and returns a list of XFile images that the user selected locally.
  @override
  @Deprecated('Use getMultiImageWithOptions instead.')
  Future<List<XFile>> getMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    return getMultiImageWithOptions(
      options: MultiImagePickerOptions(
        imageOptions: ImageOptions(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: imageQuality,
        ),
      ),
    );
  }

  // DOM methods

  /// Converts plugin configuration into a proper value for the `capture` attribute.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/file#capture
  @visibleForTesting
  String? computeCaptureAttribute(ImageSource source, CameraDevice device) {
    if (source == ImageSource.camera) {
      return (device == CameraDevice.front) ? 'user' : 'environment';
    }
    return null;
  }

  List<html.File>? _getFilesFromInput(html.FileUploadInputElement input) {
    if (_hasOverrides) {
      return _overrides!.getMultipleFilesFromInput(input);
    }
    return input.files;
  }

  /// Handles the OnChange event from a FileUploadInputElement object
  /// Returns a list of selected files.
  List<html.File>? _handleOnChangeEvent(html.Event event) {
    final html.FileUploadInputElement? input =
        event.target as html.FileUploadInputElement?;
    return input == null ? null : _getFilesFromInput(input);
  }

  /// Monitors an <input type="file"> and returns the selected file(s).
  Future<List<XFile>> _getSelectedXFiles(html.FileUploadInputElement input) {
    final Completer<List<XFile>> completer = Completer<List<XFile>>();
    // Observe the input until we can return something
    input.onChange.first.then((html.Event event) {
      final List<html.File>? files = _handleOnChangeEvent(event);
      if (!completer.isCompleted && files != null) {
        completer.complete(files.map((html.File file) {
          return XFile(
            html.Url.createObjectUrl(file),
            name: file.name,
            length: file.size,
            lastModified: DateTime.fromMillisecondsSinceEpoch(
              file.lastModified ?? DateTime.now().millisecondsSinceEpoch,
            ),
            mimeType: file.type,
          );
        }).toList());
      }
    });

    input.addEventListener('cancel', (html.Event _) {
      completer.complete(<XFile>[]);
    });

    input.onError.first.then((html.Event event) {
      if (!completer.isCompleted) {
        completer.completeError(event);
      }
    });
    // Note that we don't bother detaching from these streams, since the
    // "input" gets re-created in the DOM every time the user needs to
    // pick a file.
    return completer.future;
  }

  /// Initializes a DOM container where we can host input elements.
  html.Element _ensureInitialized(String id) {
    html.Element? target = html.querySelector('#$id');
    if (target == null) {
      final html.Element targetElement =
          html.Element.tag('flt-image-picker-inputs')..id = id;

      html.querySelector('body')!.children.add(targetElement);
      target = targetElement;
    }
    return target;
  }

  /// Creates an input element that accepts certain file types, and
  /// allows to `capture` from the device's cameras (where supported)
  @visibleForTesting
  html.Element createInputElement(
    String? accept,
    String? capture, {
    bool multiple = false,
  }) {
    if (_hasOverrides) {
      return _overrides!.createInputElement(accept, capture);
    }

    final html.Element element = html.FileUploadInputElement()
      ..accept = accept
      ..multiple = multiple;

    if (capture != null) {
      element.setAttribute('capture', capture);
    }

    return element;
  }

  /// Injects the file input element, and clicks on it
  void _injectAndActivate(html.Element element) {
    _target.children.clear();
    _target.children.add(element);
    // TODO(dit): Reimplement this with the showPicker() API, https://github.com/flutter/flutter/issues/130365
    element.click();
  }
}

// Some tools to override behavior for unit-testing
/// A function that creates a file input with the passed in `accept` and `capture` attributes.
@visibleForTesting
typedef OverrideCreateInputFunction = html.Element Function(
  String? accept,
  String? capture,
);

/// A function that extracts list of files from the file `input` passed in.
@visibleForTesting
typedef OverrideExtractMultipleFilesFromInputFunction = List<html.File>
    Function(html.Element? input);

/// Overrides for some of the functionality above.
@visibleForTesting
class ImagePickerPluginTestOverrides {
  /// Override the creation of the input element.
  late OverrideCreateInputFunction createInputElement;

  /// Override the extraction of the selected files from an input element.
  late OverrideExtractMultipleFilesFromInputFunction getMultipleFilesFromInput;
}
