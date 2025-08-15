import Foundation
import RouterModifier

final class OnboardingPaywallIntent: OnboardingPaywallIntentProtocol {
    @InjectedObject(\.appStateManager) var appStateManager: AppStateManager
    @Injected(\.purchasesManager) var purchasesManager: PurchasesManager
    
    private let router: OnboardingPaywallRouterTypes
    private let model: any OnboardingPaywallModelActionsProtocol & OnboardingPaywallModelStatePotocol
    private let inputData: OnboardingPaywallInputData?
    
    init(
        router: OnboardingPaywallRouterTypes,
        model: any OnboardingPaywallModelActionsProtocol & OnboardingPaywallModelStatePotocol,
        inputData: OnboardingPaywallInputData?
    ) {
        self.router = router
        self.model = model
        self.inputData = inputData
    }

    func viewOnAppear() {
        model.configureGirlImageName(with: inputData?.girlImageName ?? Asset.Assets.imgOnboardingPaywallCircles.name)
        preparePrice()
    }
}

private extension OnboardingPaywallIntent {
    
    func preparePrice() {
        let monthlyPrice = purchasesManager.getMonthlyPrice() ?? "--"
        let monthlyPricePerDay = purchasesManager.getMonthlyPricePerDay() ?? "--"
        let weeklyPrice = purchasesManager.getWeeklyPrice() ?? "--"
        let weeklyPricePerDay = purchasesManager.getWeeklyPricePerDay() ?? "--"
        
        let prices: OnboardingPaywallPricesnData = .init(
            monthlyPrice: .init(
                price: monthlyPrice,
                pricePerDay: L10n.onboardingOnboardingPaywallLeftButtonPricePerDay(monthlyPricePerDay)
            ),
            weeklyPrice: .init(
                price: weeklyPrice,
                pricePerDay: L10n.onboardingOnboardingPaywallRightButtonPricePerDay(weeklyPricePerDay)
            )
        )
        
        model.configurePrices(with: prices)
    }
}

extension OnboardingPaywallIntent: OnboardingPaywallActionProtocol {
    
    func onDismiss() {
        appStateManager.completeOnboarding()
    }
    
    func onPurchaseButtonTap() {
        purchasesManager.purchase(product: model.isSelectedProductId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                onDismiss()
                
            case .failure(let error):
                router.presentAlert(.failed(error: error.localizedDescription))
            }
        }
    }
}

extension OnboardingPaywallIntent: MoreInfoActionProtocol {
    
    func onRestoreButtonTappred() {
        purchasesManager.restorePurchases { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                onDismiss()
                
            case .failure(let error):
                router.presentAlert(.failed(error: error.localizedDescription))
            }
        }
    }
}
