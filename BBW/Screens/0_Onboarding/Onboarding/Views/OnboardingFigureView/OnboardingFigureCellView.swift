import SwiftUI
import VisualEffectView

struct OnboardingFigureCellView: View {
    let model: TitledImageCell
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipped()
            
            Text(model.title.capitalized)
                .font( .sfProRoundedMedium(size: 18))
                .foregroundColor(.FFFDFB)
                .padding(.vertical, 4)
                .padding(.horizontal, 24)
                .background(
                    VisualEffect(colorTint: ._000000, colorTintAlpha: 0.2, blurRadius: 10, scale: 1)
                )
                .clipShape(
                    UnevenRoundedRectangle(
                        cornerRadii: .init(
                            topLeading: 20.0,
                            topTrailing: 20.0
                        )
                    )
                )
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}


