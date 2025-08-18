import SwiftUI

struct OnboardingFinishView: View {
    let model: OnboardingFinish
    
    var body: some View {
        ZStack {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .padding(.top, 46)
                .frame(maxHeight: .infinity, alignment: .top)
            
            VStack(spacing: 28) {
                Text(model.title)
                    .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 30))
                    .foregroundColor(Asset.Colors._000000.swiftUIColor)
                
                ContainerProgressView(data: model.progressViewTitle)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)
        }
    }
}
