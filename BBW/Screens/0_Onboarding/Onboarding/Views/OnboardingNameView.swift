import SwiftUI

typealias OnOnboardingName = ((String) -> Void)?

struct OnboardingNameView: View {
    @State private var localText: String
    
    let name: String
    let placeholder: String
    var action: OnOnboardingName
    
    init(model: OnboardingName, action: OnOnboardingName) {
        self.placeholder = model.placeholder
        self.action = action
        self._localText = State(initialValue: model.text)
        self.name = model.text
    }
    
    var body: some View {
        TextField(placeholder, text: $localText)
            .foregroundColor(._000000)
            .font(.sfProRoundedMedium(size: 24))
            .padding(.horizontal, 24)
            .frame(height: 64)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.FFF_0_FA)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(customGradient, lineWidth: 1)
            )
            .frame(maxHeight: .infinity, alignment: .top)
            .onChange(of: localText) { newValue in
                action?(newValue)
            }
            .onChange(of: name) { newValue in  
                localText = newValue
            }
    }
}


