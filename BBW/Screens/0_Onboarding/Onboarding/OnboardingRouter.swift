import SwiftUI
import RouterModifier

enum OnboardingRouterScreenType: RouterScreenProtocol {
    case paywall
}

enum OnboardingRouterAlertType: RouterAlertScreenProtocol {
    case skipConfirmation
}

struct OnboardingRouter: RouterModifierProtocol {
    let routerEvents: OnboardingRouterTypes
    private let intent: OnboardingIntentProtocol & OnboardingActionProtocol
    
    init(routerEvents: OnboardingRouterTypes, intent: OnboardingIntentProtocol & OnboardingActionProtocol) {
        self.routerEvents = routerEvents
        self.intent = intent
    }
    
    @ViewBuilder
    func getScreen(for type: OnboardingRouterScreenType) -> some View {
        switch type {
        case .paywall:
            OnboardingPaywallBuilder()
                .set(inputData: .init(girlImageName: intent.prepareGirlsPhoto()))
                .build()
        }
    }
    
    func getScreenPresentationType(for type: OnboardingRouterScreenType) -> RouterScreenPresentationType {
        switch type {
        
        case .paywall:
            return .navigationDestination
        }
    }
}
