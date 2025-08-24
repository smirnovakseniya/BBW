import SwiftUI

struct MainView<Model: MainModelStatePotocol>: View {
    
    @ObservedObject var model: Model
    let intent: (MainIntentProtocol & MainActionProtocol)
    
    var body: some View {
        VStack {
            Text("Main")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        
        
    }
    
}
