import Foundation

final class MainIntent: MainIntentProtocol {
    
    private let router: Router
    private let model: MainModelActionsProtocol
    private let inputData: MainInputData?
    
    init(
        router: Router,
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
