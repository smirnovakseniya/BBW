import SwiftUI

struct OnboardingPaywallInputData {
    let labelText1: String
    
}

final class OnboardingPaywallBuilder {
    
    private var inputData: OnboardingPaywallInputData?
    
    func build() -> some View {
        let router = OnboardingPaywallRouterTypes()
        let model = OnboardingPaywallModel()
        let intent = OnboardingPaywallIntent(
            router: router,
            model: model,
            inputData: inputData
        )
        let routeModifier = OnboardingPaywallRouter(
            routerEvents: router,
            intent: intent
        )
        let view = OnboardingPaywallView(
            model: model,
            intent: intent
        )
            .modifier(routeModifier)
        return view
    }
}
