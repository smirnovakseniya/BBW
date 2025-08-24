import SwiftUI

typealias OnAgePickerValueChanged = ((Int) -> Void)?

struct OnboardingAgeView: View {
    let model: OnboardingAge
    
    let onAgePickerValueChanged: OnAgePickerValueChanged
    
    var body: some View {
        OnboardingHPickerView(
            model: model.agePickerData,
            colors: [
                ._8_A_73_E_4,
                ._603_AF_2
            ]
        ) { pickerValue in
            onAgePickerValueChanged?(pickerValue)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

