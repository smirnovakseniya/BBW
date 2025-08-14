import SwiftUI

final class AppStateManager: ObservableObject {
    @Published var currentState: AppState
    
    private var userDefaults: UserDefaultsManager
    
    init(userDefaults: UserDefaultsManager) {
        self.userDefaults = userDefaults
        
        let isCompletedOnboarding = userDefaults.load(forKey: .isCompletedOnboarding) as Bool?
        currentState = isCompletedOnboarding == true ? .main : .onboarding
    }
    
    func completeOnboarding() {
        currentState = .main
//        userDefaults.save(true, forKey: .isCompletedOnboarding) //MARK: TODO KS 
    }
}
