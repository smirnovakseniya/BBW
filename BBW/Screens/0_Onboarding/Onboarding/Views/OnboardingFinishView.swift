import SwiftUI

struct OnboardingFinishView: View {
    let model: OnboardingFinish
    
    var body: some View {
            VStack(spacing: 80) {
                Image(model.image)
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 28) {
                    Text(model.title)
                        .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 30))
                        .foregroundColor(Asset.Colors._000000.swiftUIColor)
                    
                    ContainerProgressView(data: model.progressViewTitle)
                }
            }
            .padding(.top, 46)
            .frame(maxHeight: .infinity, alignment: .top)
    }
}
