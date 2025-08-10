import SwiftUI

struct OnboardingHeightNWeightView: View {
    let model: OnboardingHeightNWeight
    
    let onHeightPickerValueChanged: ((Int) -> ())?
    let onWeightPickerValueChanged: ((Int) -> ())?
    
    var body: some View {
        VStack(spacing: 8) {
            OnboardingHPickerView(
                model: model.heightPickerData,
                colors: [
                    Asset.Colors.e958Bf.swiftUIColor,
                    Asset.Colors.ff4A6E.swiftUIColor
                ]
            ) { pickerValue in
                onHeightPickerValueChanged?(pickerValue)
            }
            
            OnboardingHPickerView(
                model: model.weightPickerData,
                colors: [
                    Asset.Colors._69965B.swiftUIColor,
                    Asset.Colors._5Ed639.swiftUIColor
                ]
            ) { pickerValue in
                onWeightPickerValueChanged?(pickerValue)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

