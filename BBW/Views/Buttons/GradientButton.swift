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
            .font(.sfProRoundedSemibold(size: 24))
            .frame(maxWidth: .infinity)
            .frame(height: 68)
            .foregroundColor(.FFFDFB)
            .background(customGradient)
            .clipShape(Capsule())
        }
    }
}

struct TempLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .title
            .font(.sfProRoundedSemibold(size: 24))
            .frame(maxWidth: .infinity)
            .frame(height: 68)
            .foregroundColor(.FFFDFB)
            .clipShape(Capsule())
    }
}

struct TempButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.sfProRoundedSemibold(size: 24))
            .frame(maxWidth: .infinity)
            .frame(height: 68)
            .foregroundColor(.FFFDFB)
            .clipShape(Capsule())
    }
}

#Preview {
    GradientButton(
        text: "asd",
        image: "",
        action: {}
    )
}
