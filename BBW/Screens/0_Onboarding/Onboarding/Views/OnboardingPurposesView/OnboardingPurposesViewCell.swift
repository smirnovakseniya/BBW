import SwiftUI

struct OnboardingPurposesViewCell: View {
    let data: OnboardingPurposesCell
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Text(data.emoji)
                Text(data.title)
                    .foregroundColor(._000000)
            }
            .font(.sfProRoundedMedium(size: 20))
            
            Text(data.description)
                .font(.sfProRoundedRegular(size: 14))
                .foregroundColor(._000000.opacity(0.4))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(.FFF_0_FA)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

