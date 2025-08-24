import SwiftUI

struct OnboardingButton: View {
    let isDisabled: Bool
    let text: String
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.sfProRoundedSemibold(size: 24))
                .frame(maxWidth: .infinity)
                .frame(height: 68)
                .foregroundColor(.FFFDFB)
                .scaleEffect(isDisabled ? 1.0 : 1.02)
                .background(
                    Group {
                        if isDisabled {
                            Color.gray
                                .blur(radius: 30)
                        } else {
                            Color._000000
                        }
                    }
                )
                .clipShape(Capsule())
        }
        .disabled(isDisabled)
    }
}

#Preview {
    OnboardingButton(
        isDisabled: false,
        text: "asdsad",
        action: {}
    )
}
