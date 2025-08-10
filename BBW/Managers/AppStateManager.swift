import SwiftUI

enum AppState {
    case onboarding
    case main
}

class AppStateManager: ObservableObject {
//    @EnvironmentObject private var userDefaults: UserDefaultsManager
    
    @Published var currentState: AppState
    
    init() {
//        let isCompletedOnboarding = userDefaults.load(forKey: .isCompletedOnboarding) as Bool?
        currentState = .onboarding//isCompletedOnboarding == true ? .main : .onboarding
    }

    
//    func completeOnboarding() {
//        currentState = .main
//        userDefaults.save(true, forKey: .isCompletedOnboarding)
//    }
}

