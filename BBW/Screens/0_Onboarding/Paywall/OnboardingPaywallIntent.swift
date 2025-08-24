import Foundation

final class OnboardingPaywallIntent: OnboardingPaywallIntentProtocol {
    @Injected(\.purchasesManager) var purchasesManager: PurchasesManager
    @InjectedObject(\.appStateManager) var appStateManager
    
    private let router: Router
    private let model: any OnboardingPaywallModelActionsProtocol & OnboardingPaywallModelStatePotocol
    private let inputData: OnboardingPaywallInputData?
    
    init(
        router: Router,
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
    
    func viewOnDisappear() {
        appStateManager.completeOnboarding()
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
        router.navigate(.popToRoot)
        router.navigate(.push(screen: .main(0)))
    }
    
    func onPurchaseButtonTap() {
        purchasesManager.purchase(product: model.isSelectedProductId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                onDismiss()
                
            case .failure(let error):
                router.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
}

extension OnboardingPaywallIntent: MoreInfoActionProtocol {
    
    func onRestoreButtonTapped() {
        purchasesManager.restorePurchases { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success:
                onDismiss()
                
            case .failure(let error):
                router.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
}
