import SwiftUI

struct OnboardingNameView: View {
    @State private var localText: String
    
    let name: String
    let placeholder: String
    var action: ((_ name: String) -> Void)?
    
    init(model: OnboardingName, action: @escaping ((String) -> Void)) {
        self.placeholder = model.placeholder
        self.action = action
        self._localText = State(initialValue: model.text)
        self.name = model.text
    }
    
    var body: some View {
        TextField(placeholder, text: $localText)
            .foregroundColor(Asset.Colors._000000.swiftUIColor)
            .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 24))
            .padding(.horizontal, 24)
            .frame(height: 64)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Asset.Colors.fff0Fa.swiftUIColor)
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


