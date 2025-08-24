import SwiftUI

struct OnboardingWelcomeView: View {
    let model: OnboardingWelcome
    
    var body: some View {
        VStack(spacing: 12) {
            Text(model.title1)
                .font(.sfProRoundedMedium(size: 19))
                .foregroundStyle(._000000.opacity(0.4))
            VStack {
                Text(model.title2)
                    .foregroundStyle(._000000)
                Text(model.title3)
                    .foregroundStyle(customGradient)
            }
            .font(.sfProRoundedHeavy(size: 38))
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 50)
    }
}

#Preview {
    OnboardingWelcomeView(
        model: .init(
            title1: "asd",
            title2: "asd",
            title3: "asd",
            backgroundImage: "asd",
            buttonTitle: "asd"
        )
    )
}
