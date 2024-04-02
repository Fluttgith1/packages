//
//  ProxyApiTestImpl.swift
//  test_plugin
//
//  Created by Maurice Parrish on 3/27/24.
//

import Foundation

/// Handles the callback when an object is deallocated.
public protocol PenguinFinalizerDelegate: AnyObject {
  /// Invoked when the strong reference of an object is deallocated in an `InstanceManager`.
  func onDeinit(identifier: Int64)
}

// Attaches to an object to receive a callback when the object is deallocated.
internal final class PenguinFinalizer {
  private static let associatedObjectKey = malloc(1)!

  private let identifier: Int64
  // Reference to the delegate is weak because the callback should be ignored if the
  // `InstanceManager` is deallocated.
  private weak var delegate: PenguinFinalizerDelegate?

  private init(identifier: Int64, delegate: PenguinFinalizerDelegate) {
    self.identifier = identifier
    self.delegate = delegate
  }

  internal static func attach(to instance: AnyObject, identifier: Int64, delegate: PenguinFinalizerDelegate)
  {
    let finalizer = PenguinFinalizer(identifier: identifier, delegate: delegate)
    objc_setAssociatedObject(instance, associatedObjectKey, finalizer, .OBJC_ASSOCIATION_RETAIN)
  }

  static func detach(from instance: AnyObject) {
    objc_setAssociatedObject(instance, associatedObjectKey, nil, .OBJC_ASSOCIATION_ASSIGN)
  }

  deinit {
    delegate?.onDeinit(identifier: identifier)
  }
}

/// Maintains instances used to communicate with the corresponding objects in Dart.
///
/// Objects stored in this container are represented by an object in Dart that is also stored in
/// an InstanceManager with the same identifier.
///
/// When an instance is added with an identifier, either can be used to retrieve the other.
///
/// Added instances are added as a weak reference and a strong reference. When the strong
/// reference is removed and the weak reference is deallocated,`PenguinFinalizerDelegate.onDeinit`
/// is called with the instance's identifier. However, if the strong reference is removed and then the identifier is
/// retrieved with the intention to pass the identifier to Dart (e.g. by calling `identifierWithStrongReference`),
/// the strong reference to the instance is readded. The strong reference will then need to be removed manually
/// again.
///
/// Accessing and inserting to an InstanceManager is thread safe.
public class PenguinInstanceManager {
  // Identifiers are locked to a specific range to avoid collisions with objects
  // created simultaneously from Dart.
  // Host uses identifiers >= 2^16 and Dart is expected to use values n where,
  // 0 <= n < 2^16.
  private static let minHostCreatedIdentifier: Int64 = 65536

  private let lockQueue = DispatchQueue(label: "FWFInstanceManager")
  private let identifiers: NSMapTable<AnyObject, NSNumber> = NSMapTable(
    keyOptions: [.weakMemory, .objectPointerPersonality], valueOptions: .strongMemory)
  private let weakInstances: NSMapTable<NSNumber, AnyObject> = NSMapTable(
    keyOptions: .strongMemory, valueOptions: [.weakMemory, .objectPointerPersonality])
  private let strongInstances: NSMapTable<NSNumber, AnyObject> = NSMapTable(
    keyOptions: .strongMemory, valueOptions: [.strongMemory, .objectPointerPersonality])
  private let finalizerDelegate: PenguinFinalizerDelegate
  private var nextIdentifier: Int64 = minHostCreatedIdentifier

  public init(finalizerDelegate: PenguinFinalizerDelegate) {
    self.finalizerDelegate = finalizerDelegate
  }

  /// Adds a new instance that was instantiated from Dart.
  ///
  /// The same instance can be added multiple times, but each identifier must be unique. This allows
  /// two objects that are equivalent (e.g. conforms to `Equatable`)  to both be added.
  ///
  /// - Parameters:
  ///   - instance: the instance to be stored
  ///   - identifier: the identifier to be paired with instance. This value must be >= 0 and unique
  func addDartCreatedInstance(_ instance: AnyObject, withIdentifier identifier: Int64) {
    lockQueue.async {
      self.addInstance(instance, withIdentifier: identifier)
    }
  }

  /// Adds a new instance that was instantiated from the host platform.
  ///
  /// - Parameters:
  ///   - instance: the instance to be stored. This must be unique to all other added instances.
  /// - Returns: the unique identifier (>= 0) stored with instance
  func addHostCreatedInstance(_ instance: AnyObject) -> Int64 {
    precondition(!containsInstance(instance), "Instance of \(instance) has already been added.")
    var identifier: Int64 = -1
    lockQueue.sync {
      identifier = nextIdentifier
      nextIdentifier += 1
      self.addInstance(instance, withIdentifier: identifier)
    }
    return identifier
  }

  /// Removes `instanceIdentifier` and its associated strongly referenced instance, if present, from the manager.
  ///
  /// - Parameters:
  ///   - instanceIdentifier: the identifier paired to an instance.
  /// - Returns: removed instance if the manager contains the given identifier, otherwise `nil` if
  ///   the manager doesn't contain the value
  func removeInstance<T: AnyObject>(withIdentifier instanceIdentifier: Int64) -> T? {
    var instance: AnyObject? = nil
    lockQueue.sync {
      instance = strongInstances.object(forKey: NSNumber(value: instanceIdentifier))
      strongInstances.removeObject(forKey: NSNumber(value: instanceIdentifier))
    }
    return instance as? T
  }

  /// Retrieves the instance associated with identifier.
  ///
  /// - Parameters:
  ///   - instanceIdentifier: the identifier associated with an instance
  /// - Returns: the instance associated with `instanceIdentifier` if the manager contains the value, otherwise
  ///   `nil` if the manager doesn't contain the value
  func instance<T: AnyObject>(forIdentifier instanceIdentifier: Int64) -> T? {
    var instance: AnyObject? = nil
    lockQueue.sync {
      instance = weakInstances.object(forKey: NSNumber(value: instanceIdentifier))
    }
    return instance as? T
  }

  private func addInstance(_ instance: AnyObject, withIdentifier identifier: Int64) {
    assert(identifier >= 0)
    precondition(weakInstances.object(forKey: identifier as NSNumber) == nil, "Identifier has already been added: \(identifier)")
    identifiers.setObject(NSNumber(value: identifier), forKey: instance)
    weakInstances.setObject(instance, forKey: NSNumber(value: identifier))
    strongInstances.setObject(instance, forKey: NSNumber(value: identifier))
    PenguinFinalizer.attach(to: instance, identifier: identifier, delegate: finalizerDelegate)
  }

  /// Retrieves the identifier paired with an instance.
  ///
  /// If the manager contains a strong reference to `instance`, it will return the identifier
  /// associated with `instance`. If the manager contains only a weak reference to `instance`, a new
  /// strong reference to `instance` will be added and will need to be removed again with `removeInstance`.
  ///
  /// If this method returns a nonnull identifier, this method also expects the Dart
  /// `PigeonInstanceManager` to have, or recreate, a weak reference to the Dart instance the
  /// identifier is associated with.
  ///
  /// - Parameters:
  ///   - instance: an instance that may be stored in the manager
  /// - Returns: the identifier associated with `instance` if the manager contains the value, otherwise
  ///   `nil` if the manager doesn't contain the value
  func identifierWithStrongReference(forInstance instance: AnyObject) -> Int64? {
    var identifier: Int64? = nil
    lockQueue.sync {
      if let existingIdentifier = identifiers.object(forKey: instance)?.int64Value {
        strongInstances.setObject(instance, forKey: NSNumber(value: existingIdentifier))
        identifier = existingIdentifier
      }
    }
    return identifier
  }

  /// Whether this manager contains the given `instance`.
  ///
  /// - Parameters:
  ///   - instance: the instance whose presence in this manager is to be tested
  /// - Returns: whether this manager contains the given `instance`
  func containsInstance(_ instance: AnyObject) -> Bool {
    var containsInstance = false
    lockQueue.sync {
      containsInstance = identifiers.object(forKey: instance) != nil
    }
    return containsInstance
  }
  
  /// Removes all of the instances from this manager.
  ///
  /// The manager will be empty after this call returns.
  func removeAllObjects() {
    lockQueue.sync {
      identifiers.removeAllObjects()
      weakInstances.removeAllObjects()
      strongInstances.removeAllObjects()
      nextIdentifier = PenguinInstanceManager.minHostCreatedIdentifier
    }
  }

  /// The number of instances stored as a strong reference.
  ///
  /// Added for debugging and testing purposes.
  internal var strongInstanceCount: Int {
    var count: Int = 0
    lockQueue.sync {
      count = strongInstances.count
    }
    return count
  }

  /// The number of instances stored as a weak reference.
  ///
  /// Added for debugging and testing purposes. NSMapTables that store keys or objects as weak
  /// reference will be reclaimed nondeterministically.
  internal var weakInstanceCount: Int {
    var count: Int = 0
    lockQueue.sync {
      count = weakInstances.count
    }
    return count
  }
}
