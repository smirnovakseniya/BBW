import SwiftUI
import RouterModifier

enum OnboardingRouterScreenType: RouterScreenProtocol {

    case mainApp
}

enum OnboardingRouterAlertType: RouterAlertScreenProtocol {
    case skipConfirmation
}

struct OnboardingRouter: RouterModifierProtocol {
    let routerEvents: OnboardingRouterTypes
    private let intent: OnboardingIntentProtocol
    
    init(routerEvents: OnboardingRouterTypes, intent: OnboardingIntentProtocol) {
        self.routerEvents = routerEvents
        self.intent = intent
    }
    
    @ViewBuilder
    func getScreen(for type: OnboardingRouterScreenType) -> some View {
        switch type {
        case .mainApp:
            EmptyView() 
            
        }
    }
    
    func getScreenPresentationType(for type: OnboardingRouterScreenType) -> RouterScreenPresentationType {
        switch type {
        
        case .mainApp:
            return .fullScreenCover
        }
    }
}
