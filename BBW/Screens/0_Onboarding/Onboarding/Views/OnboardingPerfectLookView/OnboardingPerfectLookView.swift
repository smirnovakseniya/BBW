import SwiftUI

struct OnboardingPerfectLookView: View {
    let model: OnboardingPerfectLook
    let userData: OnboardingFinalModel
    
    private let horizontalPadding: CGFloat = 50
    private let spacing: CGFloat = 8
    private let aspectRatio: CGFloat = 82 / 120
    
    var body: some View {
        GeometryReader { geometry in
            let itemWidth = (geometry.size.width - 2 * horizontalPadding - 2 * spacing) / 3
            let itemHeight = itemWidth / aspectRatio
            
            ZStack {
                gridView(itemWidth: itemWidth, itemHeight: itemHeight)
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 46)
                    .frame(maxHeight: .infinity, alignment: .top)
                
                VStack(spacing: 28) {
                    Text(model.title)
                        .font(.sfProRoundedSemibold(size: 30))
                        .foregroundColor(._000000)
                    
                    ContainerProgressView(data: model.progressViewTitle)
                }
                .padding(.bottom, 20)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
    
    private func gridView(itemWidth: CGFloat, itemHeight: CGFloat) -> some View {
        VStack(spacing: spacing) {
            HStack(spacing: spacing) {
                cellView(title: model.ageTitle, value: userData.age, width: itemWidth, height: itemHeight)
                imageCell(image: userData.nationality?.image, width: itemWidth, height: itemHeight)
                imageCell(image: userData.clothing?.image, width: itemWidth, height: itemHeight)
            }
            HStack(spacing: spacing) {
                imageCell(image: userData.figure?.image, width: itemWidth, height: itemHeight)
                imageCell(image: userData.bestPhoto?.image, width: itemWidth, height: itemHeight)
                cellView(title: model.weightTitle, value: userData.weight, width: itemWidth, height: itemHeight)
            }
        }
    }
    
    private func cellView(title: String, value: Int?, width: CGFloat, height: CGFloat) -> some View {
        OnboardingPerfectLookDataView(title: title, value: value, width: width, height: height)
    }
    
    private func imageCell(image: String?, width: CGFloat, height: CGFloat) -> some View {
        OnboardingPerfectLookImageView(image: image, width: width, height: height)
    }
}
