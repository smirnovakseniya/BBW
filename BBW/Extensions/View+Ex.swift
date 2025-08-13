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

struct RoundedCorner: InsettableShape {
    var radius: CGFloat
    var corners: UIRectCorner
    var inset: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect.insetBy(dx: inset, dy: inset),
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.inset += amount
        return shape
    }
}

