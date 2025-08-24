import UIKit

enum AppConfig {
    enum InfoUrls: String {
        case terms = "https://docs.google.com/document/d/1F6A6VIrqGSdlsIAmlltvzBgQQUIbPUcS0z1E5dndf1w"
        case privacy = "https://docs.google.com/document/d/16ydxVUApfdQlnxUXWWY8DJqXlK4AKFlQLlYJ-V10Io8/edit#heading=h.xitncj7v7"
        
        func open() {
            guard let url = URL(string: self.rawValue) else { return }
            UIApplication.shared.open(url)
        }
    }
}

protocol MoreInfoActionProtocol {
    func onTermsOfUseButtonTapped()
    func onPrivacyPolicyButtonTapped()
    func onRestoreButtonTapped()
}

extension MoreInfoActionProtocol {
    
    func onTermsOfUseButtonTapped() {
        AppConfig.InfoUrls.terms.open()
    }
    
    func onPrivacyPolicyButtonTapped() {
        AppConfig.InfoUrls.privacy.open()
    }
}
