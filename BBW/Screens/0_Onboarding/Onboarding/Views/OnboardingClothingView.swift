import SwiftUI

struct OnboardingClothingView: View {
    let model: OnboardingClothing
    
    var action: ((_ type: ClothingType) -> ())?
    
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
