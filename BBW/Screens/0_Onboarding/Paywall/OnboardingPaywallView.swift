import SwiftUI
import RouterModifier

struct OnboardingPaywallView<Model: OnboardingPaywallModelStatePotocol>: View {
    
    @ObservedObject var model: Model
    let intent: (OnboardingPaywallIntentProtocol & OnboardingPaywallActionProtocol)
    
    var body: some View {
        ZStack {}
        
    }
    
}
