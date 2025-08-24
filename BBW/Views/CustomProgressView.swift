import SwiftUI

struct CustomProgressView: View {
    let title: String
    let progress: Double
    let maxValue: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.sfProRoundedMedium(size: 16))
                .foregroundColor(._000000)
                .padding(.horizontal, 8)
            
            HStack(spacing: 12) {
                Capsule()
                    .fill(.FFFDFB)
                    .overlay(alignment: .leading) {
                        GeometryReader { geometry in
                            Capsule()
                                .foregroundStyle(customGradient)
                                .frame(width: geometry.size.width * CGFloat(progress / maxValue))
                        }
                    }
                    .frame(height: 12.0)
                
                AnimatedNumberText(value: progress)
                    .font(.sfProRoundedMedium(size: 16))
                    .foregroundColor(._000000)
                    .frame(alignment: .trailing)
                    .frame(width: 50, alignment: .trailing)
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

#Preview {
    CustomProgressView(
        title: "asdasd",
        progress: 5,
        maxValue: 10
    )
}
