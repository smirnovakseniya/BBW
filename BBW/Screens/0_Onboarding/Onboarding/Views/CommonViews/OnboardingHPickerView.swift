import SwiftUI

struct OnboardingHPickerView: View {
    @State private var selectedValue: Int
    @State private var isDragging = false
    @State private var lastPositions: [ElementPosition] = []
    @State private var delayedAction: DispatchWorkItem?
    
    private let model: OnboardingHPickerViewDataModel
    private let colors: [Color]
    private let onValueChange: (Int) -> Void
    
    init(
        model: OnboardingHPickerViewDataModel,
        colors: [Color],
        onValueChange: @escaping (Int) -> Void
    ) {
        _selectedValue = State(initialValue: model.defaultValue)
        self.model = model
        self.colors = colors
        self.onValueChange = onValueChange
    }
    
    
    var body: some View {
        ZStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(Array(stride(from: model.minValue, through: model.maxValue, by: model.step)), id: \.self) { value in
                            Text("\(value)")
                                .font(.sfProRoundedSemibold(size: 70))
                                .foregroundStyle(value == selectedValue ? .FFFDFB : .FFFDFB.opacity(0.3))
                                .animation(.spring(response: 0.3), value: selectedValue)
                                .id(value)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.preference(
                                            key: ElementPositionKey.self,
                                            value: [ElementPosition(id: value, centerX: geo.frame(in: .named("scrollView")).midX)]
                                        )
                                    }
                                )
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedValue = value
                                        proxy.scrollTo(value, anchor: .center)
                                        onValueChange(value)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, (UIScreen.main.bounds.width / 2) - 50)
                    .onPreferenceChange(ElementPositionKey.self) { positions in
                        lastPositions = positions
                        if let closest = closestElement(in: positions), selectedValue != closest.id {
                            selectedValue = closest.id
                            onValueChange(closest.id)
                        }
                    }
                }
                .coordinateSpace(name: "scrollView")
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { _ in
                            delayedAction?.cancel()
                            isDragging = true
                        }
                        .onEnded { _ in
                            isDragging = false
                            
                            let task = DispatchWorkItem {
                                if let closestElement = closestElement(in: lastPositions) {
                                    withAnimation(.spring()) {
                                        selectedValue = closestElement.id
                                        proxy.scrollTo(closestElement.id, anchor: .center)
                                        onValueChange(closestElement.id)
                                    }
                                }
                            }
                            
                            delayedAction = task
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: task)
                        }
                )
                .onAppear {
                    DispatchQueue.main.async {
                        proxy.scrollTo(model.defaultValue, anchor: .center)
                        selectedValue = model.defaultValue
                        onValueChange(model.defaultValue)
                    }
                }
            }
            
            Triangle()
                .fill(.FFFDFB)
                .frame(width: 68, height: 20)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .background(
            LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        )
        .frame(height: 188)
        .frame(maxWidth: .infinity)
    }
    
    private func closestElement(in positions: [ElementPosition]) -> ElementPosition? {
        let centerX = UIScreen.main.bounds.width / 2
        return positions.min(by: { abs($0.centerX - centerX) < abs($1.centerX - centerX) })
    }
    
    private func updateSelectedToClosest(positions: [ElementPosition]) {
        if let closest = closestElement(in: positions), selectedValue != closest.id {
            selectedValue = closest.id
            onValueChange(closest.id)
        }
    }
}

// MARK: Helper Structures

private struct ElementPosition: Equatable {
    let id: Int
    let centerX: CGFloat
}

private struct ElementPositionKey: PreferenceKey {
    static var defaultValue: [ElementPosition] = []
    
    static func reduce(value: inout [ElementPosition], nextValue: () -> [ElementPosition]) {
        value.append(contentsOf: nextValue())
    }
}

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
