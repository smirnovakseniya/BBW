import SwiftUI

final class OnboardingPaywallModel: OnboardingPaywallModelStatePotocol {
    
    @Published var data: OnboardingPaywallInputData = .init(
        image: Asset.Assets.imgOnboardingGirl.name,
        title: L10n.onboardingOnboardingPaywallTitle,
        features: [
            .init(title: L10n.onboardingOnboardingPaywallFeatures1, emoji: "💎"),
            .init(title: L10n.onboardingOnboardingPaywallFeatures2, emoji: "💬"),
            .init(title: L10n.onboardingOnboardingPaywallFeatures3, emoji: "✨"),
            .init(title: L10n.onboardingOnboardingPaywallFeatures4, emoji: "🚫")
        ],
        leftButton: .init(
            type: .left,
            title: L10n.onboardingOnboardingPaywallLeftButtonTitle
        ),
        rightButton: .init(
            type: .right,
            title: L10n.onboardingOnboardingPaywallRightButtonTitle
        ),
        description: L10n.onboardingOnboardingPaywallDescription,
        buttonTitle: L10n.onboardingOnboardingPaywallButton,
        moreInfoViewData: .init(
            privacyPolice: L10n.onboardingOnboardingPaywallPrivacyPolice,
            termsOfUse: L10n.onboardingOnboardingPaywallTermsOfUse,
            restore: L10n.onboardingOnboardingPaywallRestore
        )
    )
    
    @Published var prices: OnboardingPaywallPricesnData = .init(
        monthlyPrice: .init(price: "--", pricePerDay: "--"),
        weeklyPrice: .init(price: "--", pricePerDay: "--")
    )
}


extension OnboardingPaywallModel: OnboardingPaywallModelActionsProtocol {
    
    func configurePrices(with data: OnboardingPaywallPricesnData) {
        prices = data
    }
}
