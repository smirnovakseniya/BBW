import SwiftUI

struct OnboardingTalkAboutView: View {
    let model: OnboardingTalkAbout
    @State private var selectedCells = Set<UUID>() 
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var onCellSelecter: ((OnboardingTalkAboutCell) -> ())?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(model.list, id: \.id) { item in
                    OnboardingTalkAboutCellView(
                        data: item,
                        isSelected: selectedCells.contains(item.id)
                    )
                    .onTapGesture {
                        onCellSelecter?(item)
                        
                        if selectedCells.contains(item.id) {
                            selectedCells.remove(item.id)
                        } else {
                            selectedCells.insert(item.id)
                        }
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
