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

private struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

