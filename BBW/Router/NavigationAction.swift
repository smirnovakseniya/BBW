import Foundation

enum NavigationAction {
    case push(screen: AppScreen)
    case pop
    case popBy(index: Int)
    case popToRoot
}
