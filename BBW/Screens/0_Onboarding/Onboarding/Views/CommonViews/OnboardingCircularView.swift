import SwiftUI

struct CircularView: View {
    
    var body: some View {
        ZStack {
            BlurView(
                colorTint: Asset.Colors.fffdfb.color,
                colorTintAlpha: 0.3,
                blurRadius: 5,
                scale: 1
            )
            .mask(
                Circle()
                    .frame(width: 770, height: 770)
                    .offset(y: 300)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
            BlurView(
                colorTint: Asset.Colors.fffdfb.color,
                colorTintAlpha: 0.5,
                blurRadius: 10,
                scale: 1
            )
            .mask(
                Circle()
                    .frame(width: 560, height: 560)
                    .offset(y: 300)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.all)
    }
}


