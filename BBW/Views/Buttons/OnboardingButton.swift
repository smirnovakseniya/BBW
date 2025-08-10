import SwiftUI

struct OnboardingButton: View {
    let isDisabled: Bool
    let text: String
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 24))
                .frame(maxWidth: .infinity)
                .frame(height: 68)
                .foregroundColor(Asset.Colors.fffdfb.swiftUIColor)
                .scaleEffect(isDisabled ? 1.0 : 1.02)
                .background(
                    Group {
                        if isDisabled {
                            Color.gray
                                .blur(radius: 30)
                        } else {
                            Asset.Colors._000000.swiftUIColor
                        }
                    }
                )
                .clipShape(Capsule())
        }
        .disabled(isDisabled)
    }
}
