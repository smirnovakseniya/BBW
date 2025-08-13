import SwiftUI

struct OnboardingGirlsIntroView: View {
    let model: OnboardingGirlIntro
    let name: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(model.title + " " + name.capitalized + " " + model.emoji)
                .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 34))
                .foregroundColor(Asset.Colors._000000.swiftUIColor)
            
            VStack(spacing: 8) {
                
                HStack(spacing: 8) {
                    ForEach(model.list, id: \.self) { item in
                        GirlsIntroCellView(title: item)
                    }
                }
                
                Text(model.description)
                    .font(FontFamily.SFProRounded.regular.swiftUIFont(size: 18))
                    .foregroundColor(Asset.Colors._000000.swiftUIColor)
                    .multilineTextAlignment(.center)
                
            }
        }
        .padding(.bottom, 36)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

private struct GirlsIntroCellView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 16))
            .foregroundColor(Asset.Colors.fff0Fa.swiftUIColor)
            .padding(.vertical, 8)
            .padding(.horizontal, 24)
            .frame(alignment: .center)
            .background(customGradient)
            .clipShape(Capsule())
    }
}
