import Foundation
import RouterModifier

typealias OnboardingRouterTypes = RouterEvents<OnboardingRouterScreenType, OnboardingRouterAlertType>

protocol OnboardingIntentProtocol { }

protocol OnboardingActionProtocol {
    var onboardingData: OnboardingFinalModel { get }
    
    func nextStep()
    func completeOnboarding()
    func updateCommonData(for type: OnboardingFields)
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
    func moveToNextStep() -> Bool
    func handleIsDisabledButton(_ isDisabled: Bool)
    func setRandomName()
}
