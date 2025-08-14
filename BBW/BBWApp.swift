import SwiftUI

@main
struct BBWApp: App {
    @InjectedObject(\.appStateManager) var appStateManager
    @Injected(\.purchasesManager) var purchasesManager: PurchasesManager
    
    init() {
        purchasesManager.configureForAppLaunch()
    }
    
    var body: some Scene {
        WindowGroup {
            switch appStateManager.currentState {
            case .onboarding:
                OnboardingBuilder()
                    .build()
            case .main:
                MainBuilder()
                    .build()
            }
        }
    }
}


struct NavigationModifiers: ViewModifier {
    func body(content: Content) -> some View {
        NavigationStack { content }
    }
}

