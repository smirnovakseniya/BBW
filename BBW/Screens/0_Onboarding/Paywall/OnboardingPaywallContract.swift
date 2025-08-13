import Foundation
import RouterModifier

typealias OnboardingPaywallRouterTypes = RouterEvents<OnboardingPaywallRouterScreenType, OnboardingPaywallRouterAlertType>

protocol OnboardingPaywallIntentProtocol {
    func viewOnAppear()
}

protocol OnboardingPaywallActionProtocol {
    func onDismiss()
    func onPurchaseButtonTap()
}

protocol OnboardingPaywallModelStatePotocol: ObservableObject {
    var data: OnboardingPaywallInputData { get set }
    var prices: OnboardingPaywallPricesnData { get set }
}

protocol OnboardingPaywallModelActionsProtocol {
    func configurePrices(with data: OnboardingPaywallPricesnData)
}
