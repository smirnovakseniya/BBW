import Foundation

protocol OnboardingPaywallIntentProtocol {
    func viewOnAppear()
    func viewOnDisappear()
}

protocol OnboardingPaywallActionProtocol {
    func onDismiss()
    func onPurchaseButtonTap()
}

protocol OnboardingPaywallModelStatePotocol: ObservableObject {
    var data: OnboardingPaywallData { get set }
    var girlImageName: String { get set }
    var prices: OnboardingPaywallPricesnData { get set }
    var isSelectedProductId: ProductsIds { get set }
}

protocol OnboardingPaywallModelActionsProtocol {
    func configurePrices(with data: OnboardingPaywallPricesnData)
    func configureGirlImageName(with data: String)
}


