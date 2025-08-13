import Foundation
import RouterModifier

final class OnboardingPaywallIntent: OnboardingPaywallIntentProtocol {
    @InjectedObject(\.appStateManager) var appStateManager: AppStateManager
    @Injected(\.purchasesManager) var purchasesManager: PurchasesManager
    
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
    

    func viewOnAppear() {
        let monthlyPrice = purchasesManager.getPrice(for: .month) ?? "--"
        let monthlyPricePerDay = purchasesManager.getMonthlyPricePerDay() ?? "--"
        let weeklyPrice = purchasesManager.getPrice(for: .week) ?? "--"
        let weeklyPricePerDay = purchasesManager.getWeekPricePerDay() ?? "--"
        
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
        
    }
}
