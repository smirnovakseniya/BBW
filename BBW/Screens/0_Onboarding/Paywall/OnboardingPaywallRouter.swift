import SwiftUI
import Combine

final class OnboardingPaywallRouter: ObservableObject {
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

