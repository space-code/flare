//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit

final class IAPProviderMock: IIAPProvider {
    var invokedCanMakePayments = false
    var invokedCanMakePaymentsCount = 0
    var stubbedCanMakePayments: Bool = false

    var canMakePayments: Bool {
        invokedCanMakePayments = true
        invokedCanMakePaymentsCount += 1
        return stubbedCanMakePayments
    }

    var invokedFetch = false
    var invokedFetchCount = 0
    var invokedFetchParameters: (productIDs: Set<String>, completion: Closure<Result<[StoreProduct], IAPError>>)?
    var invokedFetchParametersList = [(productIDs: Set<String>, completion: Closure<Result<[StoreProduct], IAPError>>)]()

    func fetch(productIDs: Set<String>, completion: @escaping Closure<Result<[StoreProduct], IAPError>>) {
        invokedFetch = true
        invokedFetchCount += 1
        invokedFetchParameters = (productIDs, completion)
        invokedFetchParametersList.append((productIDs, completion))
    }

    var invokedPurchase = false
    var invokedPurchaseCount = 0
    var invokedPurchaseParameters: (product: StoreProduct, completion: Closure<Result<StoreTransaction, IAPError>>)?
    var invokedPurchaseParametersList = [(product: StoreProduct, completion: Closure<Result<StoreTransaction, IAPError>>)]()

    func purchase(product: StoreProduct, completion: @escaping Closure<Result<StoreTransaction, IAPError>>) {
        invokedPurchase = true
        invokedPurchaseCount += 1
        invokedPurchaseParameters = (product, completion)
        invokedPurchaseParametersList.append((product, completion))
    }

    var invokedRefreshReceipt = false
    var invokedRefreshReceiptCount = 0
    var invokedRefreshReceiptParameters: (completion: Closure<Result<String, IAPError>>, Void)?
    var invokedRefreshReceiptParametersList = [(completion: Closure<Result<String, IAPError>>, Void)]()
    var stubbedRefreshReceiptResult: Result<String, IAPError>?

    func refreshReceipt(completion: @escaping Closure<Result<String, IAPError>>) {
        invokedRefreshReceipt = true
        invokedRefreshReceiptCount += 1
        invokedRefreshReceiptParameters = (completion, ())
        invokedRefreshReceiptParametersList.append((completion, ()))

        if let result = stubbedRefreshReceiptResult {
            completion(result)
        }
    }

    var invokedFinishTransaction = false
    var invokedFinishTransactionCount = 0
    var invokedFinishTransactionParameters: (StoreTransaction, Void)?
    var invokedFinishTransactionParanetersList = [(StoreTransaction, Void)]()

    func finish(transaction: StoreTransaction, completion _: (@Sendable () -> Void)?) {
        invokedFinishTransaction = true
        invokedFinishTransactionCount += 1
        invokedFinishTransactionParameters = (transaction, ())
        invokedFinishTransactionParanetersList.append((transaction, ()))
    }

    var invokedAddTransactionObserver = false
    var invokedAddTransactionObserverCount = 0
    var invokedAddTransactionObserverParameters: (fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?, Void)?
    var invokedAddTransactionObserverParametersList = [(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?, Void)]()

    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        invokedAddTransactionObserver = true
        invokedAddTransactionObserverCount += 1
        invokedAddTransactionObserverParameters = (fallbackHandler, ())
        invokedAddTransactionObserverParametersList.append((fallbackHandler, ()))
    }

    var invokedRemoveTransactionObserver = false
    var invokedRemoveTransactionObserverCount = 0

    func removeTransactionObserver() {
        invokedRemoveTransactionObserver = true
        invokedRemoveTransactionObserverCount += 1
    }

    var invokedFetchAsync = false
    var invokedFetchAsyncCount = 0
    var invokedFetchAsyncParameters: (productIDs: Set<String>, Void)?
    var invokedFetchAsyncParametersList = [(productIDs: Set<String>, Void)]()
    var fetchAsyncResult: [StoreProduct] = []

    func fetch(productIDs: Set<String>) async throws -> [StoreProduct] {
        invokedFetchAsync = true
        invokedFetchAsyncCount += 1
        invokedFetchAsyncParameters = (productIDs, ())
        invokedFetchAsyncParametersList.append((productIDs, ()))
        return fetchAsyncResult
    }

    var invokedAsyncPurchase = false
    var invokedAsyncPurchaseCount = 0
    var invokedAsyncPurchaseParameters: (product: StoreProduct, Void)?
    var invokedAsyncPurchaseParametersList = [(product: StoreProduct, Void)?]()
    var stubbedAsyncPurchase: StoreTransaction!

    func purchase(product: StoreProduct) async throws -> StoreTransaction {
        invokedAsyncPurchase = true
        invokedAsyncPurchaseCount += 1
        invokedAsyncPurchaseParameters = (product, ())
        invokedAsyncPurchaseParametersList.append((product, ()))
        return stubbedAsyncPurchase
    }

    var invokedAsyncRefreshReceipt = false
    var invokedAsyncRefreshReceiptCounter = 0
    var stubbedRefreshReceiptAsyncResult: Result<String, IAPError>!

    func refreshReceipt() async throws -> String {
        invokedAsyncRefreshReceipt = true
        invokedAsyncRefreshReceiptCounter += 1

        let result = stubbedRefreshReceiptAsyncResult

        switch result {
        case let .success(receipt):
            return receipt
        case let .failure(error):
            throw error
        default:
            fatalError("An unknown type")
        }
    }

    var invokedBeginRefundRequest = false
    var invokedBeginRefundRequestCount = 0
    var invokedBeginRefundRequestParameters: (productID: String, Void)?
    var invokedBeginRefundRequestParametersList = [(productID: String, Void)]()
    var stubbedBeginRefundRequest: RefundRequestStatus!
    func beginRefundRequest(productID: String) async throws -> RefundRequestStatus {
        invokedBeginRefundRequest = true
        invokedBeginRefundRequestCount += 1
        invokedBeginRefundRequestParameters = (productID, ())
        invokedBeginRefundRequestParametersList.append((productID, ()))
        return stubbedBeginRefundRequest
    }

    var invokedPurchaseWithOptions = false
    var invokedPurchaseWithOptionsCount = 0
    var invokedPurchaseWithOptionsParameters: (product: StoreProduct, options: Any)?
    var invokedPurchaseWithOptionsParametersList = [(product: StoreProduct, options: Any)]()
    var stubbedPurchaseWithOptionsResult: Result<StoreTransaction, IAPError>?

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<Product.PurchaseOption>,
        completion: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    ) {
        invokedPurchaseWithOptions = true
        invokedPurchaseWithOptionsCount += 1
        invokedPurchaseWithOptionsParameters = (product, options)
        invokedPurchaseWithOptionsParametersList.append((product, options))

        if let result = stubbedPurchaseWithOptionsResult {
            completion(result)
        }
    }

    var invokedAsyncPurchaseWithOptions = false
    var invokedAsyncPurchaseWithOptionsCount = 0
    var invokedAsyncPurchaseWithOptionsParameters: (product: StoreProduct, options: Any)?
    var invokedAsyncPurchaseWithOptionsParametersList = [(product: StoreProduct, options: Any)]()
    var stubbedAsyncPurchaseWithOptions: StoreTransaction!

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<Product.PurchaseOption>
    ) async throws -> StoreTransaction {
        invokedAsyncPurchaseWithOptions = true
        invokedAsyncPurchaseWithOptionsCount += 1
        invokedAsyncPurchaseWithOptionsParameters = (product, options)
        invokedAsyncPurchaseWithOptionsParametersList.append((product, options))
        return stubbedAsyncPurchaseWithOptions
    }

    func promotionalOffer(
        productDiscount _: StoreProductDiscount,
        product _: StoreProduct,
        completion _: @escaping @Sendable (Result<PromotionalOffer, IAPError>) -> Void
    ) {}

    func purchase(
        product _: StoreProduct,
        promotionalOffer _: PromotionalOffer?,
        completion _: @escaping Closure<Result<StoreTransaction, IAPError>>
    ) {}

    var invokedPurchaseWithPromotionalOffer = false
    var invokedPurchaseWithPromotionalOfferCount = 0
    var stubbedPurchaseWithPromotionalOffer: StoreTransaction!

    func purchase(
        product _: StoreProduct,
        promotionalOffer _: PromotionalOffer?
    ) async throws -> StoreTransaction {
        invokedPurchaseWithPromotionalOffer = true
        invokedPurchaseWithPromotionalOfferCount += 1
        return stubbedPurchaseWithPromotionalOffer
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product _: StoreProduct,
        options _: Set<Product.PurchaseOption>,
        promotionalOffer _: PromotionalOffer?,
        completion _: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    ) {}

    var invokedPurchaseWithOptionsAndPromotionalOffer = false
    var invokedPurchaseWithOptionsAndPromotionalOfferCount = 0
    var stubbedPurchaseWithOptionsAndPromotionalOffer: StoreTransaction!

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product _: StoreProduct,
        options _: Set<Product.PurchaseOption>,
        promotionalOffer _: PromotionalOffer?
    ) async throws -> StoreTransaction {
        invokedPurchaseWithOptionsAndPromotionalOffer = true
        invokedPurchaseWithOptionsAndPromotionalOfferCount += 1
        return stubbedPurchaseWithOptionsAndPromotionalOffer
    }
}
