import SwiftUI

struct OnboardingTalkAboutCellView: View {
    let data: OnboardingTalkAboutCell
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Text(data.emoji)
            
            Text(data.title)
                .font(.sfProRoundedMedium(size: 18))
                .foregroundColor(isSelected ? .FFFDFB : ._000000)
                .padding(.vertical, 17.5)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            isSelected ? AnyShapeStyle(customGradient) : AnyShapeStyle(.FFF_0_FA)
        )
        .clipShape(Capsule())
    }
}
