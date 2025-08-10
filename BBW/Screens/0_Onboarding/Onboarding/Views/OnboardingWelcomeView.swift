import SwiftUI

struct OnboardingWelcomeView: View {
    let model: OnboardingWelcome
    
    var body: some View {
        VStack(spacing: 12) {
            Text(model.title1)
                .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 19))
                .foregroundStyle(Asset.Colors._000000.swiftUIColor.opacity(0.4))
            VStack {
                Text(model.title2)
                    .foregroundStyle(Asset.Colors._000000.swiftUIColor)
                Text(model.title3)
                    .foregroundStyle(customGradient)
            }
            .font(FontFamily.SFProRounded.heavy.swiftUIFont(size: 38))
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 80)
    }
}
