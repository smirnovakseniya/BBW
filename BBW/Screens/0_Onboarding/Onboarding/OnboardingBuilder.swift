import SwiftUI

// MARK: Main Models
struct OnboardingFinalModel {
    var name: String = ""
    var height: Int = 165
    var weight: Int = 90
    var age: Int = 21
    var nationality: OnboardingNationalityCell?
    var clothing: OnboardingClothingCell?
    var figure: OnboardingFigureCell?
    var bestPhoto: OnboardingBestPhotoCell?
    var talkAbout: Set<OnboardingTalkAboutCell> = []
    var character: [OnboardingCharacterData] = [
        .init(type: .submissiveVsDominant, value: 0.5),
        .init(type: .gentleVsTough, value: 0.5),
        .init(type: .calmVsImpulsive, value: 0.5),
        .init(type: .pessimistVsOptimist, value: 0.5)
    ]
    
    mutating func updateCharacterValue(with data: OnboardingCharacterData) {
            if let index = character.firstIndex(where: { $0.type == data.type }) {
                character[index].value = data.value
            }
        }
    
    mutating func toggleTalkAbout(_ data: OnboardingTalkAboutCell) {
            if talkAbout.contains(data) {
                talkAbout.remove(data)
            } else {
                talkAbout.insert(data)
            }
        }
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
    case character(OnboardingCharacterData)
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
    case character(OnboardingCharacter)
    case purposes(OnboardingPurposes)
    case finish(OnboardingFinish)
    case girlIntro(OnboardingGirlIntro)
}

extension OnboardingData {
    var index: Int? {
        switch self {
        case .welcome, .perfectLook, .finish, .girlIntro:
            return nil
        case let .name(data as StepIndexable),
            let .weightAHeight(data as StepIndexable),
            let .age(data as StepIndexable),
            let .nationality(data as StepIndexable),
            let .clothing(data as StepIndexable),
            let .figure(data as StepIndexable),
            let .bestPhoto(data as StepIndexable),
            let .talkAbout(data as StepIndexable),
            let .character(data as StepIndexable),
            let .purposes(data as StepIndexable):
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
enum NationalityType: String {
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
enum ClothingType: String {
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
    let emoji: String
}

struct OnboardingTalkAbout: StepIndexable, Titled, TitledButton {
    let index: Int
    let title: String
    let list: [OnboardingTalkAboutCell]
    let buttonTitle: String
}

//Character
enum CharacterTypes {
    case submissiveVsDominant
    case gentleVsTough
    case calmVsImpulsive
    case pessimistVsOptimist
}
struct OnboardingCharacterSlider: Hashable {
    var id = UUID()
    let type: CharacterTypes
    let leftTitle: String
    let rightTitle: String
    var value: Float = 0.5
    let emoji: String
}
struct OnboardingCharacter: StepIndexable, Titled, TitledButton {
    let index: Int
    let title: String
    let list: [OnboardingCharacterSlider]
    let buttonTitle: String
}
struct OnboardingCharacterData {
    let type: CharacterTypes
    var value: CGFloat
}

//Purposes
enum PurposesTypes {
    case relationships
    case friendship
    case helpAndSupport
    case justSocializing
}
struct OnboardingPurposesCell: Hashable {
    var id = UUID()
    let type: PurposesTypes
    let emoji: String
    let title: String
    let description: String
}
struct OnboardingPurposes: StepIndexable, Titled, TitledButton {
    let index: Int
    let title: String
    let list: [OnboardingPurposesCell]
    let buttonTitle: String
}

// Finish
struct OnboardingFinish: TitledButton, BackgroundImage {
    let title: String
    let backgroundImage: String
    let image: String
    let progressViewTitle: [String]
    let buttonTitle: String
}

// GirlIntro
struct OnboardingGirlIntro: TitledButton {
    let title: String
    let emoji: String
    let list: [String]
    let description: String
    let buttonTitle: String
}

// MARK:  Builder
final class OnboardingBuilder {
    private var inputData: OnboardingInputData?
    
    func build(router: Router) -> some View {
        let childRouter = Router()
        let routerModifier = RouterModifier(router: childRouter)
        
        let model = OnboardingModel()
        let intent = OnboardingIntent(
            router: router,
            model: model,
            inputData: inputData
        )
        let view = OnboardingContainerView(
            model: model,
            intent: intent
        )
        .modifier(routerModifier)
        
        return view
    }
}
