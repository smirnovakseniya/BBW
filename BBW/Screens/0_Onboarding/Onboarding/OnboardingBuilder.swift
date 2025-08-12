import SwiftUI

// MARK: Main Models
struct OnboardingFinalModel {
    var name: String = ""
    var height: Int?
    var weight: Int?
    var age: Int?
    var nationality: OnboardingNationalityCell?
    var clothing: OnboardingClothingCell?
    var figure: OnboardingFigureCell?
    var bestPhoto: OnboardingBestPhotoCell?
    var talkAbout: Set<OnboardingTalkAboutCell> = []
}

enum OnboardingFields {
    case name(String)
    case height(Int)
    case weight(Int)
    case age(Int)
    case nationality(OnboardingNationalityCell)
    case clothing(OnboardingClothingCell)
    case figure(OnboardingFigureCell)
    case bestPhoto(OnboardingBestPhotoCell)
    case talkAbout(OnboardingTalkAboutCell)
}

struct OnboardingInputData {}

// MARK: Onboarding Data Types
enum OnboardingData {
    case welcome(OnboardingWelcome)
    case name(OnboardingName)
    case weightAHeight(OnboardingHeightNWeight)
    case age(OnboardingAge)
    case nationality(OnboardingNationality)
    case clothing(OnboardingClothing)
    case figure(OnboardingFigure)
    case bestPhoto(OnboardingBestPhoto)
    case perfectLook(OnboardingPerfectLook)
    case talkAbout(OnboardingTalkAbout)
}

extension OnboardingData {
    var index: Int? {
        switch self {
        case .welcome, .perfectLook:
            return nil
        case let .name(data as StepIndexable),
            let .weightAHeight(data as StepIndexable),
            let .age(data as StepIndexable),
            let .nationality(data as StepIndexable),
            let .clothing(data as StepIndexable),
            let .figure(data as StepIndexable),
            let .bestPhoto(data as StepIndexable),
            let .talkAbout(data as StepIndexable):
            return data.index
        }
    }
}

// MARK:  Protocols
protocol Titled {
    var title: String { get }
}

protocol TitledDescription {
    var description: String { get }
}

protocol StepIndexable {
    var index: Int { get }
}

protocol TitledButton {
    var buttonTitle: String { get }
}

protocol TitledImageCell {
    var image: String { get }
    var title: String { get }
}

protocol BackgroundImage {
    var backgroundImage: String { get }
}

// MARK:  Onboarding Steps

// Welcome Step
struct OnboardingWelcome: TitledButton, BackgroundImage {
    let title1: String
    let title2: String
    let title3: String
    let backgroundImage: String
    let buttonTitle: String
}

// Name Step
struct OnboardingName: StepIndexable, Titled {
    let index: Int
    let title: String
    let placeholder: String
    var text: String
    let buttonTitle: String
    let randomButtonTitle: String
    
    mutating func updateText(_ newText: String) -> Self {
        var copy = self
        copy.text = newText
        return copy
    }
}

// Picker Data Model
struct OnboardingHPickerViewDataModel {
    let title: String
    let minValue: Int
    let maxValue: Int
    let step: Int
    let defaultValue: Int
}

// Height & Weight Step
struct OnboardingHeightNWeight: StepIndexable, Titled, TitledButton {
    let index: Int
    let title: String
    let heightPickerData: OnboardingHPickerViewDataModel
    let weightPickerData: OnboardingHPickerViewDataModel
    let buttonTitle: String
}

// Age Step
struct OnboardingAge: StepIndexable, Titled, TitledButton {
    let index: Int
    let title: String
    let agePickerData: OnboardingHPickerViewDataModel
    let buttonTitle: String
}

// MARK: Selection Types

// Nationality Types
enum NationalityType {
    case european
    case asian
    case afro
    case arab
    case latina
    case indian
}

struct OnboardingNationalityCell: TitledImageCell {
    var id = UUID()
    let type: NationalityType
    let image: String
    let title: String
}

struct OnboardingNationality: StepIndexable, Titled, TitledDescription {
    let index: Int
    let title: String
    let description: String
    let list: [OnboardingNationalityCell]
}

// Clothing Types
enum ClothingType {
    case casual
    case sport
    case office
    case feminine
    case uniform
    case underwear
}

struct OnboardingClothingCell: TitledImageCell {
    var id = UUID()
    let type: ClothingType
    let image: String
    let title: String
}

struct OnboardingClothing: StepIndexable, Titled {
    let index: Int
    let title: String
    let list: [OnboardingClothingCell]
}

// Figure Types
enum FigureType {
    case conceals
    case emphasizes
}

struct OnboardingFigureCell: TitledImageCell {
    var id = UUID()
    let type: FigureType
    let image: String
    let title: String
}

struct OnboardingFigure: StepIndexable, Titled {
    let index: Int
    let title: String
    let list: [OnboardingFigureCell]
}

// Best photo
struct OnboardingBestPhotoCell: Identifiable {
    var id = UUID()
    var index: Int
    let image: String
}

struct OnboardingBestPhoto: StepIndexable, Titled, TitledButton, TitledDescription {
    let index: Int
    let title: String
    let description: String
    let photos: [OnboardingBestPhotoCell]
    let buttonTitle: String
}

// Perfect look
struct OnboardingPerfectLook: TitledButton, BackgroundImage {
    let title: String
    let backgroundImage: String
    let ageTitle: String
    let weightTitle: String
    let progressViewTitle: [String]
    let buttonTitle: String
}

// Talk about
enum TalkAboutStyle {
    case justTalkin
    case makeFriends
    case confidence
    case romance
    case relationship
    case flirt
    case rolePlaying
    case psychology
    case support
    case problemsInLife
}

struct OnboardingTalkAboutCell: Hashable {
    var id = UUID()
    let type: TalkAboutStyle
    let title: String
    let image: String
}

struct OnboardingTalkAbout: StepIndexable, Titled, TitledButton {
    let index: Int
    let title: String
    let list: [OnboardingTalkAboutCell]
    let buttonTitle: String
}

// MARK:  Builder
final class OnboardingBuilder {
    private var inputData: OnboardingInputData?
    
    func build() -> some View {
        let router = OnboardingRouterTypes()
        let model = OnboardingModel()
        let intent = OnboardingIntent(
            router: router,
            model: model,
            inputData: inputData
        )
        let routeModifier = OnboardingRouter(
            routerEvents: router,
            intent: intent
        )
        
        let view = OnboardingContainerView(
            model: model,
            intent: intent
        )
        .modifier(routeModifier)
        .modifier(NavigationModifiers())
        
        return view
    }
}
