import SwiftUI

struct OnboardingPerfectLookDataView: View {
    let title: String
    let value: Int?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(customGradient)
            
            ZStack {
                Text(title)
                    .font(.sfProRoundedSemibold(size: 12))
                    .frame(maxHeight: .infinity, alignment: .top)
                
                Text(value?.description ?? "--")
                    .font(.sfProRoundedSemibold(size: 42))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            .foregroundColor(.FFFDFB)
            .padding(8)
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

