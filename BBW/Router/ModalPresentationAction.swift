import Foundation

enum ModalPresentationAction {
    case sheet(screen: AppScreen)
    case full(screen: AppScreen)
    case alert(AlertConfig)
    case none
}
