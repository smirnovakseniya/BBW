import Foundation
import RouterModifier

final class MainIntent: MainIntentProtocol {
    
    private let router: MainRouterTypes
    private let model: MainModelActionsProtocol
    private let inputData: MainInputData?
    
    init(
        router: MainRouterTypes,
        model: MainModelActionsProtocol,
        inputData: MainInputData?
    ) {
        self.router = router
        self.model = model
        self.inputData = inputData
    }
    
    func viewOnAppear() {}
}

extension MainIntent: MainActionProtocol {
    
}
