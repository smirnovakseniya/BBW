import Foundation
import RouterModifier

typealias OnboardingRouterTypes = RouterEvents<OnboardingRouterScreenType, OnboardingRouterAlertType>

protocol OnboardingIntentProtocol {
    func viewOnAppear()
}

protocol OnboardingActionProtocol {
    func nextStep()
    func completeOnboarding()
    func updateCommonData(for type: OnboardingFields)
    func isButtonEnabled(for type: OnboardingFields) -> Bool
    func handleRandomName() 
}

protocol OnboardingModelStatePotocol: ObservableObject {
    var currentIndex: Int { get set }
    var inputData: [OnboardingData] { get }
    var currentData: OnboardingData { get }
    var isContinueDisabled: Bool { get set }
}

extension OnboardingModelStatePotocol {
    var currentData: OnboardingData {
        inputData[currentIndex]
    }
}

protocol OnboardingModelActionsProtocol {
    func configure(with inputData: OnboardingInputData)
    func moveToNextStep()
    func completeOnboarding()
    func handleIsDisabledButton(_ isDisabled: Bool)
    func setRandomName()
}
