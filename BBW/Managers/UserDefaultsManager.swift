import SwiftUI

enum UserDefaultsKeys: String {
    case isFirstLaunch
    case isCompletedOnboarding
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var isFirstLaunch: Bool {
        get { userDefaults.object(forKey: UserDefaultsKeys.isFirstLaunch.rawValue) as? Bool ?? true }
        set { userDefaults.set(newValue, forKey: UserDefaultsKeys.isFirstLaunch.rawValue) }
    }
    
    var isCompletedOnboarding: Bool {
        get { userDefaults.object(forKey: UserDefaultsKeys.isCompletedOnboarding.rawValue) as? Bool ?? false }
        set { userDefaults.set(newValue, forKey: UserDefaultsKeys.isCompletedOnboarding.rawValue) }
    }
}
