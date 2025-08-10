import SwiftUI

struct GradientButton: View {
    let text: String
    let image: String?
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Group {
                if let image {
                    Label(text, image: image)
                } else {
                    Label(text, image: "")
                }
            }
            .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 24))
            .frame(maxWidth: .infinity)
            .frame(height: 68)
            .foregroundColor(Asset.Colors.fffdfb.swiftUIColor)
            .background(customGradient)
            .clipShape(Capsule())
        }
    }
}
