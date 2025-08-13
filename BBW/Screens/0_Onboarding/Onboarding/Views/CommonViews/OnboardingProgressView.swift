import SwiftUI

struct ContainerProgressView: View {
    @State private var progresses: [Double]
    
    let data: [String]
    let animationDuration: Double = 2.0
    let maxValue: Double = 100.0
    
    init(data: [String]) {
        self.data = data
        self._progresses = State(initialValue: Array(repeating: 0.0, count: data.count))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(Array(data.enumerated()), id: \.offset) { index, title in
                CustomProgressView(
                    title: title,
                    progress: progresses[index],
                    maxValue: maxValue
                )
            }
        }
        .onAppear {
            animateProgressBarsSequentially()
        }
    }
    
    private func animateProgressBarsSequentially() {
        for index in 0..<data.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * animationDuration) {
                withAnimation(.linear(duration: animationDuration)) {
                    progresses[index] = maxValue
                }
            }
        }
    }
}
