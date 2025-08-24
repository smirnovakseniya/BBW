import SwiftUI

typealias OnOnboardingFigureCell = ((OnboardingFigureCell) -> ())?

struct OnboardingFigureView: View {
    let model: OnboardingFigure
    
    var leftData: OnboardingFigureCell
    var rightData: OnboardingFigureCell
    
    var action: OnOnboardingFigureCell
    
    init(model: OnboardingFigure, action: OnOnboardingFigureCell = nil) {
        self.model = model
        self.action = action
        
        leftData = model.list[0]
        rightData = model.list[1]
    }
    
    var body: some View {
        HStack(spacing: 8) {
            OnboardingFigureCellView(model: leftData)
                .onTapGesture {
                    action?(leftData)
                }
            OnboardingFigureCellView(model: rightData)
                .onTapGesture {
                    action?(rightData)
                }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

