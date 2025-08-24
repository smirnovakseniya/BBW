import SwiftUI

struct OnboardingPurposesView: View {
    let model: OnboardingPurposes
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(model.list, id: \.id) { item in
                    OnboardingPurposesViewCell(data: item)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
