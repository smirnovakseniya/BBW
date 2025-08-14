import SwiftUI
import RouterModifier

enum OnboardingPaywallRouterScreenType: RouterScreenProtocol {
    case dismiss
}

enum OnboardingPaywallRouterAlertType: RouterAlertScreenProtocol {
    case failed(error: String)
    
    var title: String {
        switch self {
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .failed(let errorMessage):
            return errorMessage
        }
    }
}

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
        case .dismiss:
            EmptyView()
        }
    }
    
    func getScreenPresentationType(for type: OnboardingPaywallRouterScreenType) -> RouterScreenPresentationType {
        switch type {
        case .dismiss:
            return .navigationDestination
        }
    }
    
    // MARK: Alert Methods
    
    func getAlertTitle(for type: OnboardingPaywallRouterAlertType) -> Text? {
        return Text(type.title)
    }
    
    func getAlertMessage(for type: OnboardingPaywallRouterAlertType) -> Text {
        return Text(type.message)
    }
    
    func getAlertActions(for type: OnboardingPaywallRouterAlertType) -> Button<Text> {
        return Button("Close", role: .cancel) { }
    }
}
