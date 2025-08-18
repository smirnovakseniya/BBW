import SwiftUI

struct OnboardingPurposesView: View {
    let model: OnboardingPurposes
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(model.list, id: \.id) { item in
                    PurposesViewCell(data: item)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

private struct PurposesViewCell: View {
    let data: OnboardingPurposesCell
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Text(data.emoji)
                Text(data.title)
                    .foregroundColor(Asset.Colors._000000.swiftUIColor)
            }
            .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 20))
            
            Text(data.description)
                .font(FontFamily.SFProRounded.regular.swiftUIFont(size: 14))
                .foregroundColor(Asset.Colors._000000.swiftUIColor.opacity(0.4))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(Asset.Colors.fff0Fa.swiftUIColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
