import SwiftUI

enum OnboardingScreen: Identifiable, Hashable {
    case onboardingSteps
    case paywall
    
    var id: String { "\(self)" }
}

extension OnboardingScreen {
    @ViewBuilder
    static func makeView(screen: OnboardingScreen, router: Router, onboardingRouter: Router) -> some View {
        switch screen {
        case .onboardingSteps:
            OnboardingBuilder()
                .build(router: router)
        case .paywall:
            OnboardingPaywallBuilder()
                .build(router: router)
        }
    }
}
