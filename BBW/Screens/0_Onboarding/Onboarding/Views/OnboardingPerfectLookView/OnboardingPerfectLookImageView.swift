import SwiftUI

struct OnboardingPerfectLookImageView: View {
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
