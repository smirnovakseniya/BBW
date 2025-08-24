import SwiftUI

struct MainInputData {
    let labelText1: String
    
}

final class MainBuilder {
    
    private var inputData: MainInputData?
    
    func build() -> some View {
        let router = Router()
        let model = MainModel()
        let intent = MainIntent(
            router: router,
            model: model,
            inputData: inputData
        )
        let view = MainView(
            model: model,
            intent: intent
        )
        return view
    }
}
