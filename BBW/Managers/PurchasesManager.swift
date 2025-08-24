import Foundation
import StoreKit
import SwiftyStoreKit

public enum ProductsIds: String, CaseIterable {
    case week = "BBW.com.week"
    case month = "BBW.com.month"
    
    static var identifiers: Set<String> {
        Set(allCases.map { $0.rawValue })
    }
}

final class PurchasesManager {
    
    // MARK: - Shared Instance
    static let shared = PurchasesManager()
    
    // MARK: - Properties
    private var products = [SKProduct]()
    
    // MARK: - Initialization
    private init() {
        setupCompleteTransactions()
    }
    
    // MARK: - Setup
    private func setupCompleteTransactions() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                case .failed, .purchasing, .deferred:
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    // MARK: - Product Fetching
    public func fetchProducts(completion: @escaping (Result<[SKProduct], Error>) -> Void) {
        SwiftyStoreKit.retrieveProductsInfo(ProductsIds.identifiers) { result in
            if result.error != nil {
                completion(.failure(result.error!))
                return
            }
            
            let products = Array(result.retrievedProducts) + Array(result.invalidProductIDs.map { productID in
                let product = SKProduct()
                product.setValue(productID, forKey: "productIdentifier")
                return product
            })
            
            self.products = products
            completion(.success(products))
        }
    }
    
    // MARK: - Purchase
    public func purchase(product: ProductsIds, completion: @escaping (Result<PurchaseDetails, Error>) -> Void) {
        SwiftyStoreKit.purchaseProduct(product.rawValue, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                completion(.success(purchase))
            case .error(let error):
                completion(.failure(error))
            case .deferred:
                completion(.failure(PurchaseError.purchaseDeferred))
            }
        }
    }
    
    // MARK: - Restore Purchases
    public func restorePurchases(completion: @escaping (Result<[Purchase], Error>) -> Void) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                completion(.failure(PurchaseError.restoreFailed))
            } else if results.restoredPurchases.count > 0 {
                completion(.success(results.restoredPurchases))
            } else {
                completion(.failure(PurchaseError.noPurchasesToRestore))
            }
        }
    }
    
    // MARK: - Verify Receipt and Purchases
    public func verifyPurchase(product: ProductsIds, completion: @escaping (Result<VerifyPurchaseResult, Error>) -> Void) {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: nil)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: product.rawValue,
                    inReceipt: receipt
                )
                completion(.success(purchaseResult))
            case .error(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Check Active Subscription
    public func checkActiveSubscription(completion: @escaping (Result<Bool, Error>) -> Void) {
        let group = DispatchGroup()
        var isActive = false
        
        for product in ProductsIds.allCases {
            group.enter()
            verifySubscription(product: product) { result in
                switch result {
                case .success(let subscriptionResult):
                    switch subscriptionResult {
                    case .purchased(let expiryDate, _):
                        if expiryDate > Date() {
                            isActive = true
                        }
                    case .expired, .notPurchased:
                        break
                    }
                case .failure:
                    break
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(.success(isActive))
        }
    }
    
    // MARK: - Verify Subscription
    public func verifySubscription(product: ProductsIds, completion: @escaping (Result<VerifySubscriptionResult, Error>) -> Void) {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: nil)
        
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let subscriptionResult = SwiftyStoreKit.verifySubscription(
                    ofType: .autoRenewable,
                    productId: product.rawValue,
                    inReceipt: receipt
                )
                completion(.success(subscriptionResult))
            case .error(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Price Formatting (сохраняем существующий функционал)
    public func formattedPrice(for productId: ProductsIds) -> String? {
        guard let product = products.first(where: { $0.productIdentifier == productId.rawValue }) else {
            return nil
        }
        return priceFormatter(for: product).string(from: product.price)
    }
    
    public func getWeeklyPrice() -> String? {
        formattedPrice(for: .week)
    }
    
    public func getMonthlyPrice() -> String? {
        formattedPrice(for: .month)
    }
    
    public func getWeeklyPricePerDay() -> String? {
        calculateDailyPrice(for: .week, days: 7)
    }
    
    public func getMonthlyPricePerDay() -> String? {
        calculateDailyPrice(for: .month, days: 30)
    }
    
    // MARK: - Private Helpers
    private func priceFormatter(for product: SKProduct) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter
    }
    
    private func calculateDailyPrice(for product: ProductsIds, days: Int) -> String? {
        guard let skProduct = products.first(where: { $0.productIdentifier == product.rawValue }) else {
            return nil
        }
        
        let dailyPrice = skProduct.price.dividing(by: NSDecimalNumber(value: days))
        let formatter = priceFormatter(for: skProduct)
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: dailyPrice)
    }
    
    // MARK: - Error Handling
    private enum PurchaseError: Error {
        case purchaseDeferred
        case restoreFailed
        case noPurchasesToRestore
    }
}

// MARK: - App Integration
extension PurchasesManager {
    
    func configureForAppLaunch() {
        // Настройка наблюдения за транзакциями
        setupCompleteTransactions()
        
        // Автоматическое обновление receipt
        SwiftyStoreKit.shouldAddStorePaymentHandler = { payment, product in
            return true
        }
        
        // Загрузка продуктов при запуске
        fetchProducts { result in
            switch result {
            case .success(let products):
                print("Successfully loaded \(products.count) products")
            case .failure(let error):
                print("Failed to load products: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Упрощенные методы для быстрого использования
extension PurchasesManager {
    
    func purchaseWeekly(completion: @escaping (Bool) -> Void) {
        purchase(product: .week) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func purchaseMonthly(completion: @escaping (Bool) -> Void) {
        purchase(product: .month) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func isSubscribed(completion: @escaping (Bool) -> Void) {
        checkActiveSubscription { result in
            switch result {
            case .success(let isActive):
                completion(isActive)
            case .failure:
                completion(false)
            }
        }
    }
}
