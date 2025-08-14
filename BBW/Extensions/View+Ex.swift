import SwiftUI

extension View {
    var customGradient: LinearGradient {
        LinearGradient(
            colors: [
                Asset.Colors.e958Bf.swiftUIColor,
                Asset.Colors.ff4A6E.swiftUIColor
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
