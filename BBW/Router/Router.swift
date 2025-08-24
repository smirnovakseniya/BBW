import SwiftUI
import Combine

final class Router: ObservableObject {
    private(set) var dismissSubject: PassthroughSubject<Void, Never> = .init()
    private(set) var navigationSubject: PassthroughSubject<NavigationAction, Never> = .init()
    private(set) var presentationSubject: PassthroughSubject<ModalPresentationAction, Never> = .init()
    
    func navigate(_ action: NavigationAction) {
        navigationSubject.send(action)
    }
    
    func present(_ action: ModalPresentationAction) {
        presentationSubject.send(action)
    }
    
    func dismiss() {
        dismissSubject.send()
    }
}

//MARK: Alert

extension Router {
    func showAlert(
        title: String,
        message: String? = nil,
        buttons: [AlertButton]
    ) {
        present(.alert(AlertConfig(title: title, message: message, buttons: buttons)))
    }
    
    func showErrorAlert(
        title: String = L10n.alertErrorTitle,
        message: String,
        dismissButtonTitle: String = L10n.alertOkButton
    ) {
        showAlert(
            title: title,
            message: message,
            buttons: [AlertButton(title: dismissButtonTitle)]
        )
    }
    
    func showConfirmationAlert(
        title: String,
        message: String? = nil,
        confirmTitle: String = "Confirm",
        cancelTitle: String = "Cancel",
        onConfirm: @escaping () -> Void = {}
    ) {
        showAlert(
            title: title,
            message: message,
            buttons: [
                AlertButton(title: cancelTitle, style: .cancel),
                AlertButton(title: confirmTitle, action: onConfirm)
            ]
        )
    }
}


