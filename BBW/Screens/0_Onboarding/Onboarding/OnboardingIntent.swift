import Foundation
import RouterModifier

final class OnboardingIntent {
    private let router: OnboardingRouterTypes
    private let model: OnboardingModelActionsProtocol
    private let inputData: OnboardingInputData?
    
    var onboardingData = OnboardingFinalModel()
    
    init(router: OnboardingRouterTypes, model: OnboardingModelActionsProtocol, inputData: OnboardingInputData?) {
        self.router = router
        self.model = model
        self.inputData = inputData
    }
}

extension OnboardingIntent: OnboardingIntentProtocol {
    
    func viewOnAppear() {
//        guard let inputData else { return }
//        model.configure(with: inputData)
    }
}

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
        }
        print("## onboardingData: \(onboardingData)")
    }
    
    func isButtonEnabled(for type: OnboardingFields) -> Bool {
        switch type {
        case .name(_):
            return onboardingData.name.isEmpty
        case .height(_), .weight(_), .age(_), .nationality(_), .clothing(_), .figure(_):
            return true
        }
    }
    
    func nextStep() {
        model.moveToNextStep()
    }
    
    func handleRandomName() {
            model.setRandomName()
        }
    
    func completeOnboarding() {
        print("Onboarding completed with data:", onboardingData)
        model.completeOnboarding()
        router.routeTo(.mainApp)
    }
}
