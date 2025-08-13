import Foundation
import RouterModifier

final class OnboardingPaywallIntent: OnboardingPaywallIntentProtocol {
    
    private let router: OnboardingPaywallRouterTypes
    private let model: OnboardingPaywallModelActionsProtocol
    private let inputData: OnboardingPaywallInputData?
    
    init(
        router: OnboardingPaywallRouterTypes,
        model: OnboardingPaywallModelActionsProtocol,
        inputData: OnboardingPaywallInputData?
    ) {
        self.router = router
        self.model = model
        self.inputData = inputData
    }
    
    func viewOnAppear() {}
}

extension OnboardingPaywallIntent: OnboardingPaywallActionProtocol {
    
    func onButtonTap() {
        router.routeTo(.nextScreen)
    }
}
