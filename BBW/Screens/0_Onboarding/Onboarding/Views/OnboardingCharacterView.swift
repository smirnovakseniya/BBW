import SwiftUI

struct OnboardingCharacterView: View {
    let model: OnboardingCharacter
    
    var onSliderValueChange: ((OnboardingCharacterData) -> ())?
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(model.list, id: \.id) { item in
                CustomSlider(data: item) { value in
                    onSliderValueChange?(.init(type: item.type, value: value))
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct CustomSlider: View {
    @State private var value: CGFloat = 0.5
    
    let data: OnboardingCharacterSlider
    
    var onSliderValueChange: ((CGFloat) -> ())?
    
    var body: some View {
        VStack {
            HStack {
                Text(data.leftTitle)
                Spacer()
                Text(data.rightTitle)
            }
            .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 18))
            .foregroundColor(Asset.Colors._000000.swiftUIColor)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Asset.Colors.fff0Fa.swiftUIColor)
                        .frame(height: 16)
                        .clipShape(Capsule())
                    
                    Text(data.emoji)
                        .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 28))
                        .padding(6)
                        .background(customGradient)
                        .clipShape(Circle())
                        .offset(x: geometry.size.width * value - 15)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    value = min(max(gesture.location.x / geometry.size.width, 0), 1)
                                    onSliderValueChange?(value)
                                }
                        )
                }
            }
            .frame(height: 65)
        }
    }
}
