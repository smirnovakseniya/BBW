import Foundation
import StoreKit

public enum ProductsIds: String, CaseIterable {
    case week = "BBW.com.week"
    case month = "BBW.com.month"
    
    static var identifiers: Set<String> {
        Set(allCases.map { $0.rawValue })
    }
}

final class PurchasesManager: NSObject {
    
    // MARK: - Shared Instance
    static let shared = PurchasesManager()
    
    // MARK: - Properties
    private var products = [SKProduct]()
    private var productsRequest: SKProductsRequest?
    private var productsCompletion: ((Result<[SKProduct], Error>) -> Void)?
    private var purchaseCompletion: ((Result<Bool, Error>) -> Void)?
    private var restoreCompletion: ((Result<Bool, Error>) -> Void)?
    
    // MARK: - Initialization
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    // MARK: - Product Fetching
    public func fetchProducts(completion: @escaping (Result<[SKProduct], Error>) -> Void) {
        DispatchQueue.main.async {
            self.productsRequest?.cancel()
            self.productsCompletion = completion
            
            let request = SKProductsRequest(productIdentifiers: ProductsIds.identifiers)
            request.delegate = self
            self.productsRequest = request
            request.start()
        }
    }
    
    // MARK: - Purchase
    public func purchase(product: ProductsIds, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.main.async {
            guard SKPaymentQueue.canMakePayments() else {
                completion(.failure(PurchaseError.paymentsNotAllowed))
                return
            }
            
            guard let productToPurchase = self.products.first(where: { $0.productIdentifier == product.rawValue }) else {
                completion(.failure(PurchaseError.productNotFound))
                return
            }
            
            self.purchaseCompletion = completion
            let paymentRequest = SKPayment(product: productToPurchase)
            SKPaymentQueue.default().add(paymentRequest)
        }
    }
    
    // MARK: - Restore Purchases
    public func restorePurchases(completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.main.async {
            self.restoreCompletion = completion
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    // MARK: - Price Formatting
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
        case paymentsNotAllowed
        case productNotFound
        case purchaseFailed
        case restoreFailed
    }
}

// MARK: - SKProductsRequestDelegate
extension PurchasesManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.products = response.products
            self.productsCompletion?(.success(response.products))
            self.productsCompletion = nil
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.productsCompletion?(.failure(error))
            self.productsCompletion = nil
        }
    }
}

// MARK: - SKPaymentTransactionObserver
extension PurchasesManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        DispatchQueue.main.async {
            for transaction in transactions {
                switch transaction.transactionState {
                case .purchased:
                    self.handlePurchaseSuccess(transaction)
                    
                case .restored:
                    self.handleRestoreSuccess(transaction)
                    
                case .failed:
                    self.handleFailure(transaction)
                    
                case .deferred, .purchasing:
                    break
                    
                @unknown default:
                    break
                }
            }
        }
    }
    
    private func handlePurchaseSuccess(_ transaction: SKPaymentTransaction) {
        purchaseCompletion?(.success(true))
        purchaseCompletion = nil
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func handleRestoreSuccess(_ transaction: SKPaymentTransaction) {
        restoreCompletion?(.success(true))
        restoreCompletion = nil
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func handleFailure(_ transaction: SKPaymentTransaction) {
        if let error = transaction.error as? SKError {
            if error.code != .paymentCancelled {
                purchaseCompletion?(.failure(error))
                restoreCompletion?(.failure(error))
            }
        }
        purchaseCompletion = nil
        restoreCompletion = nil
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        restoreCompletion?(.success(true))
        restoreCompletion = nil
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        restoreCompletion?(.failure(error))
        restoreCompletion = nil
    }
}

// MARK: - App Integration
extension PurchasesManager {
    
    func configureForAppLaunch() {
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
