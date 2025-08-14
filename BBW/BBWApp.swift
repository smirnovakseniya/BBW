import SwiftUI

@main
struct BBWApp: App {
    @InjectedObject(\.appStateManager) var appStateManager
    @Injected(\.purchasesManager) var purchasesManager: PurchasesManager
    
    init() {
        configureManagers()
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
    
    func configureManagers() {
        purchasesManager.configureForAppLaunch()
    }
}


struct NavigationModifiers: ViewModifier {
    func body(content: Content) -> some View {
        NavigationStack { content }
    }
}

