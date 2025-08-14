import SwiftUI

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


