//import SwiftUI
//
//enum MainRouterScreenType: RouterScreenProtocol {
//    case nextScreen
//}
//
//enum MainRouterAlertType: RouterAlertScreenProtocol {}
//
//struct MainRouter: RouterModifierProtocol {
//    
//    let routerEvents: MainRouterTypes
//    private let intent: MainIntentProtocol
//    
//    init(
//        routerEvents: MainRouterTypes,
//        intent: MainIntentProtocol
//    ) {
//        self.routerEvents = routerEvents
//        self.intent = intent
//    }
//    
//    @ViewBuilder
//    func getScreen(for type: MainRouterScreenType) -> some View {
//        switch type {
//        case .nextScreen:
//            EmptyView()
//        }
//    }
//    
//    func getScreenPresentationType(for type: MainRouterScreenType) -> RouterScreenPresentationType {
//        switch type {
//        case .nextScreen:
//            return .navigationDestination
//        }
//    }
//}
