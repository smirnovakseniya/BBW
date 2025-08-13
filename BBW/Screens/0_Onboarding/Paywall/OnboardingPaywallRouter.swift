import SwiftUI
import RouterModifier

enum OnboardingPaywallRouterScreenType: RouterScreenProtocol {
    case nextScreen
}

enum OnboardingPaywallRouterAlertType: RouterAlertScreenProtocol {}

struct OnboardingPaywallRouter: RouterModifierProtocol {
    
    let routerEvents: OnboardingPaywallRouterTypes
    private let intent: OnboardingPaywallIntentProtocol
    
    init(
        routerEvents: OnboardingPaywallRouterTypes,
        intent: OnboardingPaywallIntentProtocol
    ) {
        self.routerEvents = routerEvents
        self.intent = intent
    }
    
    @ViewBuilder
    func getScreen(for type: OnboardingPaywallRouterScreenType) -> some View {
        switch type {
        case .nextScreen:
            EmptyView()
        }
    }
    
    func getScreenPresentationType(for type: OnboardingPaywallRouterScreenType) -> RouterScreenPresentationType {
        switch type {
        case .nextScreen:
            return .navigationDestination
        }
    }
}
