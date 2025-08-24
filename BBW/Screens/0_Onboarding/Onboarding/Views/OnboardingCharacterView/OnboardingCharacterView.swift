import SwiftUI

typealias OnOnboardingCharacterData = ((OnboardingCharacterData) -> Void)?

struct OnboardingCharacterView: View {
    let model: OnboardingCharacter
    
    var onSliderValueChange: OnOnboardingCharacterData
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(model.list, id: \.id) { item in
                    OnboardingCustomSlider(data: item) { value in
                        onSliderValueChange?(
                            .init(type: item.type, value: value)
                        )
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
