import SwiftUI

typealias OnSliderValueChange = ((CGFloat) -> Void)?

struct OnboardingCustomSlider: View {
    @State private var value: CGFloat = 0.5
    
    let data: OnboardingCharacterSlider
    var onSliderValueChange: OnSliderValueChange
    
    private let thumbSize: CGFloat = 40
    
    var body: some View {
        VStack {
            HStack {
                Text(data.leftTitle)
                Spacer()
                Text(data.rightTitle)
            }
            .font(.sfProRoundedMedium(size: 18))
            .foregroundColor(._000000)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.FFF_0_FA)
                        .frame(height: 16)
                        .clipShape(Capsule())
                    
                    Text(data.emoji)
                        .font(.sfProRoundedMedium(size: 28))
                        .padding(6)
                        .background(customGradient)
                        .clipShape(Circle())
                        .frame(width: thumbSize, height: thumbSize)
                        .offset(x: calculateThumbPosition(width: geometry.size.width))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    let newValue = min(max((gesture.location.x - thumbSize/2) / (geometry.size.width - thumbSize), 0), 1)
                                    value = newValue
                                    onSliderValueChange?(value)
                                }
                        )
                }
            }
            .frame(height: 65)
        }
    }
    
    private func calculateThumbPosition(width: CGFloat) -> CGFloat {
        let availableWidth = width - thumbSize
        return availableWidth * value
    }
}
