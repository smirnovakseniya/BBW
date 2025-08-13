import SwiftyStoreKit
import StoreKit
//import AppsFlyerLib
//import FBSDKCoreKit
//import YandexMobileMetrica
//import FirebaseAnalytics

struct StoreProduct {
    var bundle: String
    var price: Double
    var numberOfUnits: Int
    var unit: SKProduct.PeriodUnit
    var currency: String
}

public enum ProductsIds: CaseIterable {
    case week,  month
    
    static let identifiers: Set<String> = Set(ProductsIds.allCases.map { $0.identifier })
    
    var identifier: String {
        switch self {
        case .week:
            return "BBW.com.week"
        case .month:
            return "BBW.com.month"
        }
    }
    
    static func from(identifier: String) -> ProductsIds? {
        return allCases.first { $0.identifier == identifier }
    }
}

final class PurchasesManager: NSObject {
    
    public enum PurchaseState {
        case successful, failed, cancelled
    }
    
    public enum RestoreState {
        case successful, failed
    }
    
    //MARK: - Singleton
    public static let shared = PurchasesManager()
    
    //MARK: - Properties
    private let simulatesAskToBuyInSandbox: AppleReceiptValidator.VerifyReceiptURLType = .production
    private let sharedKey = ""
    public var areProductsNotAvailable = false
    
    var storeProducts: [StoreProduct] = []
    var skProducts: [SKProduct] = []
    var isTestingMode: Bool = false
    
    public var isActive: Bool {
        return false
//        get {
//            if UserDefaultsHelper.isFreeVersionFromDeeplink {
//                return true
//            }
//            
//            return UserDefaultsHelper.isUserPremium
//        }
//        set {
//            UserDefaultsHelper.isUserPremium = newValue
//        }
    }
    
    //MARK: - Completion all transaction and start this method from AppDelegate
    public func completionAllTransaction() {
        
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction { SwiftyStoreKit.finishTransaction(purchase.transaction) }
                default: break
                }
            }
        }
        
        //MARK: Call Verify subscription
        self.verifySubscription()
    }
    
    //MARK: - Verify subscription
    private func verifySubscription(completion: ((_ result: Bool) -> ())? = nil) {
        
        let appleValidator = AppleReceiptValidator(service: simulatesAskToBuyInSandbox, sharedSecret: sharedKey)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { (result) in
            switch result {
            case .success(receipt: let receipt):
                
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(ofType: .autoRenewable, productIds: ProductsIds.identifiers, inReceipt: receipt)
                switch purchaseResult {
                case .purchased(expiryDate: let expiryDate, items: _):
                    expiryDateLocal = expiryDate
                    completion?(true)
                    
                    print("\(ProductsIds.identifiers) is valid until \(expiryDate)")
                case .expired(expiryDate: let expiryDate, items: _):
                    
                    completion?(false)
                    print("\(ProductsIds.identifiers) is expired since \(expiryDate)")
                case .notPurchased:
                    
                    completion?(false)
                    print("The user has never purchased \(ProductsIds.identifiers)")
                }
                
            case .error(error: let error):
                
                completion?(false)
                print("Receipt verification failed: \(error.localizedDescription)")
            }
        }
    }
    
    public func appendOneDay() {
        
        var dayComponent    = DateComponents()
        dayComponent.day    = 1
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
        expiryDateLocal = nextDate
    }
    
    func logEvent(name: String) {
//        AppsFlyerLib.shared().logEvent(name, withValues: nil)
//        YMMYandexMetrica.reportEvent(name)
//        AppEvents.shared.logEvent(AppEvents.Name(name))
//        Analytics.logEvent(name, parameters: nil)
    }
    
    //MARK: - Purchase
    public func purchase(product: ProductsIds, completion: @escaping (_ result: PurchaseState) -> ()) {
        print(product)
        
        SwiftyStoreKit.purchaseProduct(product.identifier,
                                       simulatesAskToBuyInSandbox: simulatesAskToBuyInSandbox == .sandbox ? true : false) { [self] (result) in
            switch result {
            case .success(purchase: let purchase):
                
                self.logEvent(name: "SubscriptionDone_\(product)")
                
                self.logEvent(name: "SubscriptionDone")
//                AppsFlyerLib.shared().logEvent(AFEventPurchase, withValues: ["eventValue": ""])
//                AppEvents.shared.logPurchase(amount: Double(truncating:  purchase.product.price), currency: "USD")
//                AppEvents.shared.logEvent(.subscribe)
//                
//                UserAcquisitionManager.shared.logPurchase(of: purchase.product)
                self.verifySubscription()
                self.finishPurchaseTransaction(purchase: purchase)
                
                let token = UserDefaults.standard.string(forKey: "TokenNotification") ?? ""
                
//                UserAcquisitionManager.shared.logPurchase(of: purchase.product)
//                UserAcquisitionManager.shared.log(pushDeviceToken: token, and: purchase.originalTransaction?.transactionIdentifier ?? "")
                
                
                appendOneDay()
                
                completion(.successful)
            case .error(error: let error):
                
                switch error.code {
                case .paymentCancelled:
                    completion(.cancelled)
                default:
                    completion(.failed)
                }
            case .deferred(purchase: let purchase):
                break
            }
        }
    }
    
    func getCurrency(for productId: ProductsIds) -> String? {
        guard let product = skProducts.first(where: { $0.productIdentifier == productId.identifier }) else {
            return nil
        }
        
        return product.priceLocale.currencySymbol
    }
    
    func getDoublePrice(for productId: ProductsIds) -> NSDecimalNumber? {
        guard let product = skProducts.first(where: { $0.productIdentifier == productId.identifier }) else {
            return nil
        }
        
        return product.price
    }
    
    public func getPrice(for productId: ProductsIds) -> String? {
        skProducts.forEach {
            print($0.productIdentifier)
        }
        
        print(skProducts.count)
        
        guard let product = skProducts.first(where: { $0.productIdentifier == productId.identifier }) else {
            return nil
        }
        
        return product.localizedPrice
    }
    
    public func retriveInfo() {
        
        SwiftyStoreKit.retrieveProductsInfo(ProductsIds.identifiers) { (result) in
            
            result.retrievedProducts.forEach { (product) in
                
                let filter = ProductsIds.identifiers.filter({ $0 == product.productIdentifier }).first ?? .none
                if let filter = filter {
                    self.skProducts.append(product)
                }
            }
            
            print(result.invalidProductIDs.count)
            let invalidateIDs = result.invalidProductIDs.count
            
            if let product = result.retrievedProducts.first {
                print("ProductIdentifier: \(product.productIdentifier), price: \(product.localizedPrice!)")
                
            } else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
                
            } else {
                print("Error: \(result.error?.localizedDescription ?? "")")
                
            }
        }
    }
    
    internal func divider(price: Double,
                          currency: String,
                          wantToUnit: SKProduct.PeriodUnit,
                          currentUnit: SKProduct.PeriodUnit,
                          numberOfUnit: Int) -> String {
        
        let divider = self.returnValue(wantToUnit: wantToUnit,
                                       currentUnit: currentUnit,
                                       numberOfUnit: numberOfUnit)
        let finalPrice = price / Double(divider)
        let roundedPrice = Double(round(100 * finalPrice) / 100)
        let unitStirng = wantToUnit == .day
        ? "day"
        : wantToUnit == .week
        ? "week".lowercased()
        : wantToUnit == .month
        ? "month"
        : "year"
        
//        ? "day".localized()
//        : wantToUnit == .week
//        ? "week".localized().lowercased()
//        : wantToUnit == .month
//        ? "month".localized()
//        : "year".localized()
        
        return "\(roundedPrice)\(currency)/\(unitStirng)"
    }
    
    fileprivate func returnValue(wantToUnit: SKProduct.PeriodUnit,
                                 currentUnit: SKProduct.PeriodUnit,
                                 numberOfUnit: Int) -> Int {
        switch wantToUnit {
        case .day:
            return self.day(currentUnit: currentUnit,
                            numberOfUnit: numberOfUnit)
        case .week:
            return self.week(currentUnit: currentUnit,
                             numberOfUnit: numberOfUnit)
        case .month:
            return self.month(currentUnit: currentUnit,
                              numberOfUnit: numberOfUnit)
        default:
            return self.year(currentUnit: currentUnit,
                             numberOfUnit: numberOfUnit)
        }
    }
    
    fileprivate func day(currentUnit: SKProduct.PeriodUnit,
                         numberOfUnit: Int) -> Int {
        switch currentUnit {
        case .week:
            return 7 * numberOfUnit
        case .month:
            return 30 * numberOfUnit
        case .year:
            return 365 * numberOfUnit
        default:
            return numberOfUnit
        }
    }
    
    fileprivate func week(currentUnit: SKProduct.PeriodUnit,
                          numberOfUnit: Int) -> Int {
        switch currentUnit {
        case .week:
            return numberOfUnit
        case .month:
            return 4 * numberOfUnit
        case .year:
            return 52 * numberOfUnit
        default:
            return 0
        }
    }
    
    fileprivate func month(currentUnit: SKProduct.PeriodUnit,
                           numberOfUnit: Int) -> Int {
        switch currentUnit {
        case .month:
            return numberOfUnit
        case .year:
            return 12 * numberOfUnit
        default:
            return 0
        }
    }
    
    fileprivate func year(currentUnit: SKProduct.PeriodUnit,
                          numberOfUnit: Int) -> Int {
        switch currentUnit {
        case .year:
            return numberOfUnit
        default:
            return 0
        }
    }
    
    //MARK: - Restore purchase
    public func restore(completion: @escaping (_ result: RestoreState) -> ()) {
        
        SwiftyStoreKit.restorePurchases(atomically: true) { (results) in
            
            if results.restoreFailedPurchases.count > 0 {
                
                completion(.failed)
            } else if results.restoredPurchases.count > 0 {
                
                results.restoredPurchases.forEach({ self.finishPurchaseRestoreTransaction(purchase: $0) })
                self.verifySubscription { (result) in
                    completion(result ? .successful : .failed)
                    
                }
            } else {
                completion(.failed)
            }
        }
    }
    
    //MARK: - LocalizedPrice
    
    private func getPriceFormatter(for skProduct: SKProduct) -> NumberFormatter {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        priceFormatter.locale = skProduct.priceLocale
        return priceFormatter
    }
    
    func getPaywallLocalizedPrice(for productId: ProductsIds) -> String? {
        guard
            let skProduct = PurchasesManager.shared.skProducts.first(where: {
                ProductsIds.from(identifier: $0.productIdentifier) == productId
            })
        else { return nil }
        
        let priceFormatter = getPriceFormatter(for: skProduct)
        let localizedPrice = priceFormatter.string(from: skProduct.price) ?? "\(skProduct.price)"
        
        return localizedPrice
    }
    
    private func formatPrice(_ price: NSDecimalNumber, for skProduct: SKProduct, fractionDigits: Int? = nil) -> String {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        priceFormatter.locale = skProduct.priceLocale
        
        if let digits = fractionDigits {
            priceFormatter.minimumFractionDigits = digits
            priceFormatter.maximumFractionDigits = digits
        }
        
        return priceFormatter.string(from: price) ?? "\(price)"
    }
    
    private func getLocalizedPrice(for productId: ProductsIds) -> String? {
        guard
            let skProduct = PurchasesManager.shared.skProducts.first(where: {
                ProductsIds.from(identifier: $0.productIdentifier) == productId
            })
        else { return nil }
        
        return formatPrice(skProduct.price, for: skProduct)
    }
    
    func getFirstWeekPrice() -> String? {
        guard
            let skProduct = PurchasesManager.shared.skProducts.first(where: {
                ProductsIds.from(identifier: $0.productIdentifier) == .week
            }),
            let introductoryPrice = skProduct.introductoryPrice
        else { return nil }
        
        return introductoryPrice.localizedPrice
    }
    
    func getRegularWeekPrice() -> String? {
        getLocalizedPrice(for: ProductsIds.week)
    }
    
    private func getDividedLocalizedPrice(for productId: ProductsIds, divisor: Int) -> String? {
        guard
            let skProduct = PurchasesManager.shared.skProducts.first(where: {
                ProductsIds.from(identifier: $0.productIdentifier) == productId
            })
        else { return nil }
        
        let dividedPrice = skProduct.price.dividing(by: NSDecimalNumber(value: divisor))
        return formatPrice(dividedPrice, for: skProduct, fractionDigits: 2)
    }
    
    func getWeekPricePerDay() -> String? {
        getDividedLocalizedPrice(for: ProductsIds.week, divisor: 7)
    }
    
    func getMonthlyPricePerDay() -> String? {
        getDividedLocalizedPrice(for: ProductsIds.month, divisor: 30)
    }
    
    //MARK: - Finish transaction
    private func finishPurchaseTransaction(purchase: PurchaseDetails) {
        
        if purchase.needsFinishTransaction { SwiftyStoreKit.finishTransaction(purchase.transaction) }
    }
    
    private func finishPurchaseRestoreTransaction(purchase: Purchase) {
        
        if purchase.needsFinishTransaction { SwiftyStoreKit.finishTransaction(purchase.transaction) }
    }
}

internal var expiryDateLocal: Date? {
    get {
        return UserDefaults.standard.value(forKey: "storeManagerExpiryDate") as? Date
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "storeManagerExpiryDate")
    }
}

internal var isNotNeedFirstMeasuring: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "isNotNeedFirstMeasuring") as Bool
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "isNotNeedFirstMeasuring")
    }
}

