import SwiftUI

final class MainModel: MainModelStatePotocol {
    
    @Published var data: MainInputData = .init(
        labelText1: "Track the real-time location"
    )
}


extension MainModel: MainModelActionsProtocol {}
