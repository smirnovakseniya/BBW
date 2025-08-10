import SwiftUI

struct RootView: View {
    @StateObject private var appState = AppStateManager()
    
    var body: some View {
        switch appState.currentState {
        case .onboarding:
            
            OnboardingBuilder()
//                .environmentObject(appState)
                .build()
        case .main:
            OnboardingBuilder()
//                .environmentObject(appState)
                .build()
        }
    }
}
