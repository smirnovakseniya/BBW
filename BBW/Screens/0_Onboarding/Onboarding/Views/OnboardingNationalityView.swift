import SwiftUI

struct OnboardingNationalityView: View {
    let model: OnboardingNationality
    
    var action: ((_ type: NationalityType) -> ())?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8)
                ],
                spacing: 8
            ) {
                ForEach(model.list, id: \.id) { item in
                    OnboardingCellView(model: item)
                        .onTapGesture {
                            action?(item.type)
                        }
                }
            }
        }
    }
}

