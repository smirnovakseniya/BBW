import SwiftUI

struct OnboardingGirlsIntroView: View {
    let model: OnboardingGirlIntro
    let name: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(model.title + " " + name.capitalized + " " + model.emoji)
                .font(.sfProRoundedSemibold(size: 34))
                .foregroundColor(._000000)
            
            VStack(spacing: 8) {
                
                HStack(spacing: 8) {
                    ForEach(model.list, id: \.self) { item in
                        GirlsIntroCellView(title: item)
                    }
                }
                
                Text(model.description)
                    .font(.sfProRoundedRegular(size: 18))
                    .foregroundColor(._000000)
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
            .font(.sfProRoundedMedium(size: 16))
            .foregroundColor(.FFF_0_FA)
            .padding(.vertical, 8)
            .padding(.horizontal, 24)
            .frame(alignment: .center)
            .background(customGradient)
            .clipShape(Capsule())
    }
}
