import SwiftUI

struct OnboardingCellView: View {
    let model: TitledImageCell
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(model.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            
            Text(model.title.capitalized)
                .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 18))
                .foregroundColor(Asset.Colors.fffdfb.swiftUIColor)
                .padding(.vertical, 4)
                .padding(.horizontal, 24)
                .background(
                    BlurView(
                        colorTint: Asset.Colors._000000.color,
                        colorTintAlpha: 0.2,
                        blurRadius: 10,
                        scale: 1
                    )
                )
                .cornerRadius(20, corners: [.topLeft, .topRight])
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

