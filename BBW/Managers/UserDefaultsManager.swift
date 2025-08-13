import SwiftUI

enum UserDefaultsKeys: String {
    case isFirstLaunch = "isFirstLaunch"
    case isCompletedOnboarding = "isCompletedOnboarding"
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults: UserDefaults
    
    @Published var isFirstLaunch: Bool
    @Published var isCompletedOnboarding: Bool
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        
        self.isFirstLaunch = userDefaults.object(forKey: UserDefaultsKeys.isFirstLaunch.rawValue) as? Bool ?? true
        self.isCompletedOnboarding = userDefaults.object(forKey: UserDefaultsKeys.isCompletedOnboarding.rawValue) as? Bool ?? false
    }
    
    func save<T>(_ value: T, forKey key: UserDefaultsKeys) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func load<T>(forKey key: UserDefaultsKeys) -> T? {
        return userDefaults.object(forKey: key.rawValue) as? T
    }
    
    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
