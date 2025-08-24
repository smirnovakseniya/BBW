import SwiftUI

final class AppStateManager: ObservableObject {
    @Published var currentState: AppState
    
    private var userDefaults: UserDefaultsManager
    
    init(userDefaults: UserDefaultsManager) {
        self.userDefaults = userDefaults
        
        let isCompletedOnboarding = userDefaults.isCompletedOnboarding
        currentState = isCompletedOnboarding == true ? .main : .onboarding
    }
    
    func completeOnboarding() {
        currentState = .main
//        userDefaults.isCompletedOnboarding = true //MARK: TODO KS
    }
}
