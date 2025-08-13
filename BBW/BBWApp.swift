import SwiftUI

@main
struct BBWApp: App {
    @InjectedObject(\.appStateManager) var appStateManager
    
    init() {
        configurePurchasesManager()
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
    
    private func configurePurchasesManager() {
        PurchasesManager.shared.completionAllTransaction()
        PurchasesManager.shared.retriveInfo()
    }
    
}

struct NavigationModifiers: ViewModifier {
    func body(content: Content) -> some View {
        NavigationStack { content }
    }
}

