import SwiftUI

@main
struct BBWApp: App {
    @StateObject private var userDefaultsManager = UserDefaultsManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(userDefaultsManager)
        }
    }
}

struct NavigationModifiers: ViewModifier {
    func body(content: Content) -> some View {
        NavigationStack { content }
    }
}

