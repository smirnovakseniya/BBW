import SwiftUI

struct OnboardingAgeView: View {
    let model: OnboardingAge
    
    let onAgePickerValueChanged: ((Int) -> ())?
    
    var body: some View {
        OnboardingHPickerView(
            model: model.agePickerData,
            colors: [
                Asset.Colors._8A73E4.swiftUIColor,
                Asset.Colors._603Af2.swiftUIColor
            ]
        ) { pickerValue in
            onAgePickerValueChanged?(pickerValue)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

