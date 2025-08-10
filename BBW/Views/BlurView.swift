import SwiftUI
import VisualEffectView

struct BlurView: UIViewRepresentable {
    var colorTint: UIColor = .white
    var colorTintAlpha: CGFloat = 0.1
    var blurRadius: CGFloat = 7
    var scale: CGFloat = 1
    
    func makeUIView(context: Context) -> VisualEffectView {
        let view = VisualEffectView()
        view.colorTint = colorTint
        view.colorTintAlpha = colorTintAlpha
        view.blurRadius = blurRadius
        view.scale = scale
        return view
    }
    
    func updateUIView(_ uiView: VisualEffectView, context: Context) {
        uiView.colorTint = colorTint
        uiView.colorTintAlpha = colorTintAlpha
        uiView.blurRadius = blurRadius
        uiView.scale = scale
    }
}

