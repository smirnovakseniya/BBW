import SwiftUI

struct OnboardingBestPhotoView: View {
    var model: [OnboardingBestPhotoCell]
    
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @State private var activeIndex: Int = 0
    
    let onValueChanged: ((OnboardingBestPhotoCell) -> ())?
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(model) { item in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(getStrokeStyle(for: item.index), lineWidth: 4)
                        
                        Image(item.image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(6)
                    }
                    .frame(
                        width: geo.size.width * 0.6,
                        height: geo.size.height * 0.8
                    )
                    .scaleEffect(scale(for: item.index))
                    .opacity(opacity(for: item.index))
                    .offset(x: myXOffset(item.index, cardWidth: geo.size.width * 0.6))
                    .zIndex(zIndex(for: item.index))
                    .animation(.easeOut(duration: 0.25), value: draggingItem)
                }
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .gesture(getDragGesture())
        }
        .onAppear {
            onValueChanged?(model[activeIndex])
        }
    }
    
    private func scale(for index: Int) -> CGFloat {
        let dist = abs(distance(index))
        return CGFloat(1.0 - dist * 0.1)
    }
    
    private func opacity(for index: Int) -> Double {
        let dist = abs(distance(index))
        return 1.0 - dist * 0.3
    }
    
    private func zIndex(for index: Int) -> Double {
        return 1.0 - abs(distance(index)) * 0.1
    }
    
    private func getDragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                draggingItem = snappedItem + value.translation.width / 300
                
                let currentIndex = Int((draggingItem + Double(model.count))
                    .truncatingRemainder(dividingBy: Double(model.count)))
                
                if currentIndex >= 0 && currentIndex < model.count {
                    onValueChanged?(model[currentIndex])
                }
            }
            .onEnded { value in
                withAnimation(.spring()) {
                    draggingItem = snappedItem + value.predictedEndTranslation.width / 300
                    draggingItem = round(draggingItem)
                        .remainder(dividingBy: Double(model.count))
                    snappedItem = draggingItem
                    activeIndex = Int((draggingItem + Double(model.count))
                                      .truncatingRemainder(dividingBy: Double(model.count)))
                    
                    onValueChanged?(model[activeIndex])
                }
            }
    }
    
    private func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item))
            .remainder(dividingBy: Double(model.count))
    }
    
    private func myXOffset(_ item: Int, cardWidth: CGFloat) -> Double {
        let totalSpacing = cardWidth + 4
        return distance(item) * totalSpacing
    }
    
    private func getStrokeStyle(for index: Int) -> some ShapeStyle {
        activeIndex == index ? AnyShapeStyle(customGradient) : AnyShapeStyle(Color.clear)
    }
}
