import SwiftUI

typealias onOnboardingPickerValueChanged = ((Int) -> Void)?

struct OnboardingHeightNWeightView: View {
    let model: OnboardingHeightNWeight
    
    let onHeightPickerValueChanged: onOnboardingPickerValueChanged
    let onWeightPickerValueChanged: onOnboardingPickerValueChanged
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                OnboardingHPickerView(
                    model: model.heightPickerData,
                    colors: [
                        .E_958_BF,
                        .FF_4_A_6_E
                    ]
                ) { pickerValue in
                    onHeightPickerValueChanged?(pickerValue)
                }
                
                OnboardingHPickerView(
                    model: model.weightPickerData,
                    colors: [
                        ._69965_B,
                        ._5_ED_639
                    ]
                ) { pickerValue in
                    onWeightPickerValueChanged?(pickerValue)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

