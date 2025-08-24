import SwiftUI

struct OnboardingGirlsIntroCellView: View {
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
