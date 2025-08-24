import SwiftUI

struct ModalPresentationModifier: ViewModifier {
    
    @Binding private var presentation: ModalPresentationAction
    private var router: Router
    
    init(
        presentation: Binding<ModalPresentationAction>,
        router: Router
    ) {
        self._presentation = presentation
        self.router = router
    }
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(
                item: Binding(
                    get: {
                        if case let .full(screen) = presentation {
                            return screen
                        }
                        return nil
                    }, set: {  _ in presentation = .none }
                ),
                content: present(screen:)
            )
            .sheet(
                item: Binding(
                    get: {
                        if case let .sheet(screen) = presentation {
                            return screen
                        }
                        return nil
                    }, set: {  _ in presentation = .none }
                ),
                content: present(screen:)
            )
            .alert(
                item: Binding(
                    get: {
                        if case let .alert(config) = presentation {
                            return config
                        }
                        return nil
                    }, set: { _ in presentation = .none }
                ),
                content: { config in
                    createAlert(from: config)
                }
            )
    }
}

//MARK: - Presentation

private extension ModalPresentationModifier {
    @ViewBuilder
    func present(screen: AppScreen) -> some View {
        let childRouter = Router()
        let routerModifier = RouterModifier(router: childRouter)
        
        AppScreen.makeView(
            screen: screen,
            router: childRouter
        )
        .modifier(routerModifier)
        .onReceive(childRouter.dismissSubject) { router.present(.none) }
    }
    
    func createAlert(from config: AlertConfig) -> Alert {
        if config.buttons.count == 1 {
            return Alert(
                title: Text(config.title),
                message: config.message.map { Text($0) },
                dismissButton: .default(Text(config.buttons[0].title), action: config.buttons[0].action)
            )
        } else if config.buttons.count == 2 {
            return Alert(
                title: Text(config.title),
                message: config.message.map { Text($0) },
                primaryButton: createAlertButton(config.buttons[0]),
                secondaryButton: createAlertButton(config.buttons[1])
            )
        } else {
            return Alert(
                title: Text(config.title)
            )
        } 
    }
    
    func createAlertButton(_ button: AlertButton) -> Alert.Button {
        switch button.style {
        case .default:
            return .default(Text(button.title), action: button.action)
        case .cancel:
            return .cancel(Text(button.title), action: button.action)
        case .destructive:
            return .destructive(Text(button.title), action: button.action)
        }
    }
}
