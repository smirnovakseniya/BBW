import SwiftUI

struct OnboardingTalkAboutView: View {
    let model: OnboardingTalkAbout
    @State private var selectedCells = Set<UUID>() 
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var onCellSelecter: ((OnboardingTalkAboutCell) -> ())?
    
    var body: some View {
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
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

private struct OnboardingTalkAboutCellView: View {
    let data: OnboardingTalkAboutCell
    let isSelected: Bool
    
    private var customGradient: LinearGradient {
        LinearGradient(
            colors: [Color(red: 1.0, green: 0.4, blue: 0.6),
            Color(red: 1.0, green: 0.2, blue: 0.5)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Text(data.image)
            
            Text(data.title)
                .font(FontFamily.SFProRounded.medium.swiftUIFont(size: 18))
                .foregroundColor(isSelected ? Asset.Colors.fffdfb.swiftUIColor : Asset.Colors._000000.swiftUIColor)
                .padding(.vertical, 17.5)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            isSelected ? AnyShapeStyle(customGradient) : AnyShapeStyle(Asset.Colors.fff0Fa.swiftUIColor)
        )
        .clipShape(Capsule())
    }
}
