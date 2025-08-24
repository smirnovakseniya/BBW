import SwiftUI

extension SwiftUI.Font {
    
    //MARK: SFCompactRounded
    
    static func sfCompactRoundedRegular(size: CGFloat) -> SwiftUI.Font {
        return FontFamily.SFCompactRounded.regular.swiftUIFont(size: size)
    }
    
    static func sfCompactRoundedBold(size: CGFloat) -> SwiftUI.Font {
        return FontFamily.SFCompactRounded.regular.swiftUIFont(size: size)
    }
    
    //MARK: SFProRounded
    
    static func sfProRoundedMedium(size: CGFloat) -> SwiftUI.Font {
        return FontFamily.SFProRounded.medium.swiftUIFont(size: size) 
    }
    
    static func sfProRoundedSemibold(size: CGFloat) -> SwiftUI.Font {
        return FontFamily.SFProRounded.semibold.swiftUIFont(size: size)
    }
    
    static func sfProRoundedRegular(size: CGFloat) -> SwiftUI.Font {
        return FontFamily.SFProRounded.regular.swiftUIFont(size: size)
    }
    
    static func sfProRoundedHeavy(size: CGFloat) -> SwiftUI.Font {
        return FontFamily.SFProRounded.heavy.swiftUIFont(size: size)
    }
    
    
}
