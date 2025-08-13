import Foundation
import RouterModifier

typealias MainRouterTypes = RouterEvents<MainRouterScreenType, MainRouterAlertType>

protocol MainIntentProtocol {
    func viewOnAppear()
}

protocol MainActionProtocol {
   
}

protocol MainModelStatePotocol: ObservableObject {
    var data: MainInputData { get set }
}

protocol MainModelActionsProtocol {}
