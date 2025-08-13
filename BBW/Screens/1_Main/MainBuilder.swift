import SwiftUI

struct MainInputData {
    let labelText1: String
    
}

final class MainBuilder {
    
    private var inputData: MainInputData?
    
    func build() -> some View {
        let router = MainRouterTypes()
        let model = MainModel()
        let intent = MainIntent(
            router: router,
            model: model,
            inputData: inputData
        )
        let routeModifier = MainRouter(
            routerEvents: router,
            intent: intent
        )
        let view = MainView(
            model: model,
            intent: intent
        )
            .modifier(routeModifier)
            .modifier(NavigationModifiers())
        return view
    }
}
