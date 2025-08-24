import SwiftUI

typealias EmptyClouser = () -> Void

enum AppScreen: Identifiable, Hashable {
    case onboarding(OnboardingStep)
    case main(Int) /// поменять на другую логику
}

enum OnboardingStep: Int, Identifiable, Hashable {
    case onboardingSteps = 1
    case paywall = 2
    
    var id: Int { rawValue }
}

extension AppScreen {
    static func == (lhs: AppScreen, rhs: AppScreen) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension AppScreen {
    var id: String { return "\(self)" }
    
    @ViewBuilder
    static func rootView(currentState: AppState) -> some View {
        let router = Router()
        let routerModifier = RouterModifier(router: router)
        
        let initialScreen: AppScreen = {
            switch currentState {
            case .main:
                return .main(0)
            case .onboarding:
                return .onboarding(.onboardingSteps)
            }
        }()
        
        makeView(
            screen: initialScreen,
            router: router
        )
        .modifier(routerModifier)
    }
}

extension AppScreen {
    @ViewBuilder
    static func makeView(
        screen: AppScreen,
        router: Router
    ) -> some View {
        switch screen {
        case let .main(index):
            MainBuilder()
                .build()
                
        case let .onboarding(step):
            switch step {
            case .onboardingSteps:
                OnboardingBuilder()
                    .build(router: router)
            case .paywall:
                OnboardingPaywallBuilder()
                    .build(router: router)
            }
           
        }
    }
}
