import SwiftUI

@main
struct BBWApp: App {
    @InjectedObject(\.appStateManager) var appStateManager
    @Injected(\.purchasesManager) var purchasesManager: PurchasesManager
    
    init() {
        configureManagers()
    }
    
    var body: some Scene {
        WindowGroup {
            AppScreen.rootView(currentState: appStateManager.currentState)
        }
    }
    
    func configureManagers() {
        purchasesManager.configureForAppLaunch()
    }
}

