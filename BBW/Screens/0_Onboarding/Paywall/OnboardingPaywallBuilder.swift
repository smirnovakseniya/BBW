import SwiftUI

struct OnboardingPaywallInputData {
    let girlImageName: String
}

struct OnboardingPaywallData {
    let title: String
    let features: [OnboardingPaywallFeaturesData]
    let leftButton: OnboardingPaywallButtonData
    let rightButton: OnboardingPaywallButtonData
    let description: String
    let buttonTitle: String
    let moreInfoViewData: MoreInfoViewData
}

struct OnboardingPaywallFeaturesData {
    var id = UUID()
    let title: String
    let emoji: String
}

enum OnboardingPaywallButtonType {
    case left
    case right
}

struct OnboardingPaywallButtonData {
    let type: OnboardingPaywallButtonType
    let title: String
}

struct MoreInfoViewData {
    let privacyPolice: String
    let termsOfUse: String
    let restore: String
}

struct OnboardingPaywallPricePeriodData {
    let price: String
    let pricePerDay: String
}

struct OnboardingPaywallPricesnData {
    let monthlyPrice: OnboardingPaywallPricePeriodData
    let weeklyPrice: OnboardingPaywallPricePeriodData
}

final class OnboardingPaywallBuilder {
    
    private var inputData: OnboardingPaywallInputData?
    
    func set(inputData: OnboardingPaywallInputData) -> OnboardingPaywallBuilder {
        self.inputData = inputData
        return self
    }
    
    func build(router: Router) -> some View {
        let model = OnboardingPaywallModel()
        let intent = OnboardingPaywallIntent(
            router: router,
            model: model,
            inputData: inputData
        )
        let view = OnboardingPaywallView(
            model: model,
            intent: intent
        )
        return view
    }
}
