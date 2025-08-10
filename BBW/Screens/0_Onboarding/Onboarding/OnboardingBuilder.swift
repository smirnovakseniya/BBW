import SwiftUI

// MARK: Main Models
struct OnboardingFinalModel {
    var name: String = ""
    var height: Int?
    var weight: Int?
    var age: Int?
    var nationality: NationalityType?
    var clothing: ClothingType?
    var figure: FigureType?
}

enum OnboardingFields {
    case name(String)
    case height(Int)
    case weight(Int)
    case age(Int)
    case nationality(NationalityType)
    case clothing(ClothingType)
    case figure(FigureType)
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
}

extension OnboardingData {
    var index: Int? {
        switch self {
        case .welcome: return nil
        case let .name(data as StepIndexable),
             let .weightAHeight(data as StepIndexable),
             let .age(data as StepIndexable),
             let .nationality(data as StepIndexable),
             let .clothing(data as StepIndexable),
            let .figure(data as StepIndexable):
            return data.index
        }
    }
}

// MARK:  Protocols
protocol Titled {
    var title: String { get }
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

// MARK:  Onboarding Steps

// Welcome Step
struct OnboardingWelcome: TitledButton {
    let title1: String
    let title2: String
    let title3: String
    let imageName: String
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

struct OnboardingNationality: StepIndexable, Titled {
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
    let concealsData: OnboardingFigureCell
    let emphasizesData: OnboardingFigureCell
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
