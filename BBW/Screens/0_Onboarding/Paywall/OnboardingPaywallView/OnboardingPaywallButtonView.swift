import SwiftUI
import VisualEffectView

struct OnboardingPaywallButtonView: View {
    @Binding var isSelectedType: OnboardingPaywallButtonType
    let data: OnboardingPaywallButtonData
    let price: OnboardingPaywallPricePeriodData
    
    private var isSelected: Bool {
        isSelectedType == data.type
    }
    
    private var cornerShape: some InsettableShape {
        RoundedCorner(radius: 20, corners: data.type == .left ? [.topLeft, .bottomLeft] : [.topRight, .bottomRight])
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Text(data.title)
                .font(.sfProRoundedMedium(size: 14))
                .foregroundColor(._000000.opacity(0.7))
            Text(price.price)
                .font(.sfProRoundedSemibold(size: 26))
                .foregroundColor(._000000)
            Text(price.pricePerDay)
                .font(.sfProRoundedRegular(size: 14))
                .foregroundColor(._000000.opacity(0.4))
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(
            VisualEffect(colorTint: isSelected ? .E_958_BF : .FFF_0_FA, colorTintAlpha: 0.2, blurRadius: 10, scale: 1)
        )
        .overlay(
            cornerShape
                .stroke(customGradient, lineWidth: isSelected ? 1 : 0)
        )
        .clipShape(
            data.type == .left
            ? UnevenRoundedRectangle(
                cornerRadii: .init(
                    topLeading: 20.0,
                    bottomLeading: 20.0
                )
            )
            : UnevenRoundedRectangle(
                cornerRadii: .init(
                    bottomTrailing: 20.0,
                    topTrailing: 20.0
                )
            )
        )
        .onTapGesture {
            isSelectedType = data.type
        }
    }
}

