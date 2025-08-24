import SwiftUI

struct RouterModifier: ViewModifier {
    private var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    @State private var path = NavigationPath()
    @State private var modalPresentation: ModalPresentationAction = .none
    
    func body(content: Content) -> some View {
        NavigationStack(path: $path) {
            content
                .navigationDestination(for: AppScreen.self) { (screen) in
                    AppScreen.makeView(
                        screen: screen,
                        router: router
                    )
                }
                .modifier(
                    ModalPresentationModifier(
                        presentation: $modalPresentation,
                        router: router
                    )
                )
        }
        .onReceive(router.navigationSubject) { handleNavigation($0) }
        .onReceive(router.presentationSubject) { modalPresentation = $0 }
    }
}

private extension RouterModifier {
    func handleNavigation(_ action: NavigationAction) {
        switch action {
        case let .push( screen):
            path.append(screen)
        case .pop:
            if !path.isEmpty { path.removeLast() }
        case let .popBy(index):
            guard index <= path.count else { return }
            path.removeLast(index)
        case .popToRoot:
            path = NavigationPath()
        }
    }
}
