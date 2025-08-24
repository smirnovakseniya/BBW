import Foundation

final class OnboardingIntent {
    
    private let router: Router
    private let model: OnboardingModelActionsProtocol
    private let inputData: OnboardingInputData?
    
    var onboardingData = OnboardingFinalModel()
    
    init(router: Router, model: OnboardingModelActionsProtocol, inputData: OnboardingInputData?) {
        self.router = router
        self.model = model
        self.inputData = inputData
    }
}

extension OnboardingIntent: OnboardingIntentProtocol { }

extension OnboardingIntent: OnboardingActionProtocol {
    
    func updateCommonData(for type: OnboardingFields) {
        switch type {
        case .name(let data):
            onboardingData.name = data
            model.handleIsDisabledButton(data.isEmpty)
        case .height(let data):
            onboardingData.height = data
        case .weight(let data):
            onboardingData.weight = data
        case .age(let data):
            onboardingData.age = data
        case .nationality(let data):
            onboardingData.nationality = data
            nextStep()
        case .clothing(let data):
            onboardingData.clothing = data
            nextStep()
        case .figure(let data):
            onboardingData.figure = data
            nextStep()
        case .bestPhoto(let data):
            onboardingData.bestPhoto = data
        case .talkAbout(let data):
            onboardingData.toggleTalkAbout(data)
            model.handleIsDisabledButton(onboardingData.talkAbout.isEmpty)
        case .character(let data):
            onboardingData.updateCharacterValue(with: data)
        }
        print("## onboardingData: \(onboardingData)")
    }
    
    func nextStep() {
        if model.moveToNextStep() {
            completeOnboarding()
        }
    }
    
    func handleRandomName() {
        model.setRandomName()
    }
    
    func completeOnboarding() {
        router.navigate(.push(screen: .onboarding(.paywall)))
    }
    
    
    func prepareGirlsPhoto() -> String {
        guard
            let nationality: String = onboardingData.nationality?.type.rawValue,
            let clothing: String = onboardingData.clothing?.type.rawValue
        else {
            return Asset.Assets.imgOnboardingPaywallCircles.name
        }
        
        return "img_onboarding_\(nationality)_\(clothing)"
    }
}
