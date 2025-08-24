import SwiftUI

struct AlertConfig: Identifiable {
    let id = UUID()
    let title: String
    let message: String?
    let buttons: [AlertButton]
    
    init(title: String, message: String? = nil, buttons: [AlertButton]) {
        self.title = title
        self.message = message
        self.buttons = buttons
    }
}

struct AlertButton {
    let title: String
    let action: () -> Void
    let style: AlertButtonStyle
    
    init(title: String, action: @escaping () -> Void = {}, style: AlertButtonStyle = .default) {
        self.title = title
        self.action = action
        self.style = style
    }
}

enum AlertButtonStyle {
    case `default`
    case cancel
    case destructive
}


