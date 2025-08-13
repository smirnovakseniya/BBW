import SwiftUI

public protocol InjectionKey {
    associatedtype Value

    static var currentValue: Self.Value { get set }
}

struct InjectedValues {
    private static var current = InjectedValues()
    
    static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    var projectedValue: Injected<T> { self }
    
    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

@propertyWrapper
struct InjectedObject<T>: DynamicProperty where T: ObservableObject {
    @ObservedObject private var value: T
    
    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.value = InjectedValues[keyPath]
    }
    
    var wrappedValue: T { value }
    var projectedValue: ObservedObject<T>.Wrapper { $value }
}

extension Injected where T: ObservableObject {
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    var projectedValue: ObservedObject<T>.Wrapper {
        ObservedObject(wrappedValue: wrappedValue).projectedValue
    }
}

extension InjectedValues {
    var userDefaultsManager: UserDefaultsManager {
        get { Self[UserDefaultsManagerKey.self] }
        set { Self[UserDefaultsManagerKey.self] = newValue }
    }
    
    var appStateManager: AppStateManager {
        get { Self[AppStateManagerKey.self] }
        set { Self[AppStateManagerKey.self] = newValue }
    }
    
    var purchasesManager: PurchasesManager {
        get { Self[PurchasesManagerKey.self] }
        set { Self[PurchasesManagerKey.self] = newValue }
    }
}

private struct UserDefaultsManagerKey: InjectionKey {
    static var currentValue: UserDefaultsManager = UserDefaultsManager()
}

private struct AppStateManagerKey: InjectionKey {
    static var currentValue: AppStateManager = AppStateManager(userDefaults: UserDefaultsManager.shared)
}

private struct PurchasesManagerKey: InjectionKey {
    static var currentValue: PurchasesManager = PurchasesManager.shared
}

