// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Foundation

/// Implementation of `NSObject` that calls to Dart in callback methods.
class ObjectImpl: NSObject {
  let api: PigeonApiProtocolNSObject

  init(api: PigeonApiProtocolNSObject) {
    self.api = api
  }

  override func observeValue(
    forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?,
    context: UnsafeMutableRawPointer?
  ) {
    let wrapperChange = change?.map { (key: NSKeyValueChangeKey, value: Any) in
      let wrapperKey =
        switch key {
        case .indexesKey:
          KeyValueChangeKey.indexes
        case .newKey:
          KeyValueChangeKey.newValue
        case .kindKey:
          KeyValueChangeKey.kind
        case .oldKey:
          KeyValueChangeKey.oldValue
        case .notificationIsPriorKey:
          KeyValueChangeKey.notificationIsPrior
        default:
          KeyValueChangeKey.unknown
        }
      return (wrapperKey, value)
    }
    api.observeValue(
      pigeonInstance: self, keyPath: keyPath, object: object as? NSObject,
      changeKeys: wrapperChange != nil ? Dictionary(uniqueKeysWithValues: wrapperChange!) : nil
    ) { _ in }
  }
}

/// ProxyApi delegate implementation for `NSObject`.
///
/// This class may handle instantiating native object instances that are attached to a Dart
/// instance or handle method calls on the associated native class or an instance of that class.
class ObjectProxyAPIDelegate: PigeonApiDelegateNSObject {
  func pigeonDefaultConstructor(pigeonApi: PigeonApiNSObject) throws -> NSObject {
    return ObjectImpl(api: pigeonApi)
  }

  func addObserver(
    pigeonApi: PigeonApiNSObject, pigeonInstance: NSObject, observer: NSObject, keyPath: String,
    options: KeyValueObservingOptions
  ) throws {
    let nativeOptions =
      switch options {
      case .newValue:
        NSKeyValueObservingOptions.new
      case .oldValue:
        NSKeyValueObservingOptions.old
      case .initialValue:
        NSKeyValueObservingOptions.initial
      case .priorNotification:
        NSKeyValueObservingOptions.prior
      }
    pigeonInstance.addObserver(observer, forKeyPath: keyPath, options: nativeOptions, context: nil)
  }

  func removeObserver(
    pigeonApi: PigeonApiNSObject, pigeonInstance: NSObject, observer: NSObject, keyPath: String
  ) throws {
    pigeonInstance.removeObserver(observer, forKeyPath: keyPath)
  }
}
