import UIKit

protocol MoreInfoActionProtocol {
    func onTermsOfUseButtonTappred()
    func onPrivacyPoliceButtonTappred()
    func onRestoreButtonTappred()
}

extension MoreInfoActionProtocol {
    
    func onTermsOfUseButtonTappred() {
        let termsURL = "https://docs.google.com/document/d/1F6A6VIrqGSdlsIAmlltvzBgQQUIbPUcS0z1E5dndf1w"
        if let url = URL(string: termsURL) {
            UIApplication.shared.open(url)
        }
    }
    
    func onPrivacyPoliceButtonTappred() {
        let privacyURL = "https://docs.google.com/document/d/16ydxVUApfdQlnxUXWWY8DJqXlK4AKFlQLlYJ-V10Io8/edit#heading=h.xitncj7rnsv7"
        if let url = URL(string: privacyURL) {
            UIApplication.shared.open(url)
        }
    }
}
