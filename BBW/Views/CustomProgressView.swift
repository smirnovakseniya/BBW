import SwiftUI

struct CustomProgressView: View {
    let title: String
    let progress: Double
    let maxValue: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 16))
                .foregroundColor(Asset.Colors._000000.swiftUIColor)
                .padding(.horizontal, 8)
            
            HStack(spacing: 12) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(Asset.Colors.fffdfb.swiftUIColor)
                        
                        Rectangle()
                            .foregroundStyle(customGradient)
                            .frame(width: geometry.size.width * CGFloat(progress / maxValue))
                    }
                    .cornerRadius(4)
                }
                .frame(height: 12)
                .clipShape(Capsule())
                
                AnimatedNumberText(value: progress)
                    .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 16))
                    .foregroundColor(Asset.Colors._000000.swiftUIColor)
                    .frame(alignment: .trailing)
                    .frame(width: 40, alignment: .trailing)
            }
        }
    }
}

struct AnimatedNumberText: View, Animatable {
    var value: Double
    
    var animatableData: Double {
        get { value }
        set { value = newValue }
    }
    
    var body: some View {
        Text("\(Int(value))%")
    }
}
