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
            
            VStack(spacing: 80) {
                gridView(itemWidth: itemWidth, itemHeight: itemHeight)
                    .padding(.horizontal, horizontalPadding)
                
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

//MARK: Subviews

private struct OnboardingPerfectLookDataView: View {
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
                    .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 12))
                    .frame(maxHeight: .infinity, alignment: .top)
                
                Text(value?.description ?? "--")
                    .font(FontFamily.SFProRounded.semibold.swiftUIFont(size: 42))
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            .foregroundColor(Asset.Colors.fffdfb.swiftUIColor)
            .padding(8)
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private struct OnboardingPerfectLookImageView: View {
    let image: String?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            if let image = image, !image.isEmpty {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
            } else {
                Color.clear
                    .frame(width: width, height: height)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .contentShape(RoundedRectangle(cornerRadius: 10))
    }
}
