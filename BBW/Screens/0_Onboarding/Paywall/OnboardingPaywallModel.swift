import SwiftUI

final class OnboardingPaywallModel: OnboardingPaywallModelStatePotocol {
    
    @Published var data: OnboardingPaywallInputData = .init(
        labelText1: "Track the real-time location"
    )
}


extension OnboardingPaywallModel: OnboardingPaywallModelActionsProtocol {}
