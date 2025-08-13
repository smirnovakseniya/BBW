import Foundation
import RouterModifier

typealias OnboardingPaywallRouterTypes = RouterEvents<OnboardingPaywallRouterScreenType, OnboardingPaywallRouterAlertType>

protocol OnboardingPaywallIntentProtocol {
    func viewOnAppear()
}

protocol OnboardingPaywallActionProtocol {
    func onButtonTap()
}

protocol OnboardingPaywallModelStatePotocol: ObservableObject {
    var data: OnboardingPaywallInputData { get set }
}

protocol OnboardingPaywallModelActionsProtocol {}
