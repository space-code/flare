//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import FlareMock
import Foundation
import Log
import StoreKit

final class FlareMock: IFlare {
    var invokedLogLevelSetter = false
    var invokedLogLevelSetterCount = 0
    var invokedLogLevel: Log.LogLevel?
    var invokedLogLevelList = [Log.LogLevel]()
    var invokedLogLevelGetter = false
    var invokedLogLevelGetterCount = 0
    var stubbedLogLevel: Log.LogLevel!

    var logLevel: Log.LogLevel {
        set {
            invokedLogLevelSetter = true
            invokedLogLevelSetterCount += 1
            invokedLogLevel = newValue
            invokedLogLevelList.append(newValue)
        }
        get {
            invokedLogLevelGetter = true
            invokedLogLevelGetterCount += 1
            return stubbedLogLevel
        }
    }

    var invokedFetchProductIDs = false
    var invokedFetchProductIDsCount = 0
    var invokedFetchProductIDsParameters: (productIDs: Set<String>, completion: Closure<Result<[StoreProduct], IAPError>>)?
    var invokedFetchProductIDsParametersList = [(productIDs: Set<String>, completion: Closure<Result<[StoreProduct], IAPError>>)]()

    func fetch(productIDs: Set<String>, completion: @escaping Closure<Result<[StoreProduct], IAPError>>) {
        invokedFetchProductIDs = true
        invokedFetchProductIDsCount += 1
        invokedFetchProductIDsParameters = (productIDs, completion)
        invokedFetchProductIDsParametersList.append((productIDs, completion))
    }

    var invokedFetch = false
    var invokedFetchCount = 0
    var invokedFetchParameters: (productIDs: Set<String>, Void)?
    var invokedFetchParametersList = [(productIDs: Set<String>, Void)]()
    var stubbedFetchError: Error?
    var stubbedInvokedFetch: [StoreProduct] = []

    func fetch(productIDs: Set<String>) async throws -> [StoreProduct] {
        invokedFetch = true
        invokedFetchCount += 1
        invokedFetchParameters = (productIDs, ())
        invokedFetchParametersList.append((productIDs, ()))
        if let stubbedFetchError = stubbedFetchError {
            throw stubbedFetchError
        }
        return stubbedInvokedFetch
    }

    var invokedPurchaseProductPromotionalOffer = false
    var invokedPurchaseProductPromotionalOfferCount = 0
    var invokedPurchaseProductPromotionalOfferParameters: (
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: Closure<Result<StoreTransaction, IAPError>>
    )?
    var invokedPurchaseProductPromotionalOfferParametersList = [(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: Closure<Result<StoreTransaction, IAPError>>
    )]()

    func purchase(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping Closure<Result<StoreTransaction, IAPError>>
    ) {
        invokedPurchaseProductPromotionalOffer = true
        invokedPurchaseProductPromotionalOfferCount += 1
        invokedPurchaseProductPromotionalOfferParameters = (product, promotionalOffer, completion)
        invokedPurchaseProductPromotionalOfferParametersList.append((product, promotionalOffer, completion))
    }

    var invokedPurchase = false
    var invokedPurchaseCount = 0
    var invokedPurchaseParameters: (product: StoreProduct, promotionalOffer: PromotionalOffer?)?
    var invokedPurchaseParametersList = [(product: StoreProduct, promotionalOffer: PromotionalOffer?)]()
    var stubbedPurchaseError: Error?
    var stubbedPurchase: StoreTransaction!

    func purchase(product: StoreProduct, promotionalOffer: PromotionalOffer?) async throws -> StoreTransaction {
        invokedPurchase = true
        invokedPurchaseCount += 1
        invokedPurchaseParameters = (product, promotionalOffer)
        invokedPurchaseParametersList.append((product, promotionalOffer))
        if let stubbedPurchaseError = stubbedPurchaseError {
            throw stubbedPurchaseError
        }
        return stubbedPurchase
    }

    var invokedPurchaseProductOptionsPromotionalOffer = false
    var invokedPurchaseProductOptionsPromotionalOfferCount = 0
    var invokedPurchaseProductOptionsPromotionalOfferParameters: (
        product: StoreProduct,
        options: Any,
        promotionalOffer: PromotionalOffer?,
        completion: SendableClosure<Result<StoreTransaction, IAPError>>
    )?
    var invokedPurchaseProductOptionsPromotionalOfferParametersList = [(
        product: StoreProduct,
        options: Any,
        promotionalOffer: PromotionalOffer?,
        completion: SendableClosure<Result<StoreTransaction, IAPError>>
    )]()

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    ) {
        invokedPurchaseProductOptionsPromotionalOffer = true
        invokedPurchaseProductOptionsPromotionalOfferCount += 1
        invokedPurchaseProductOptionsPromotionalOfferParameters = (product, options, promotionalOffer, completion)
        invokedPurchaseProductOptionsPromotionalOfferParametersList.append((product, options, promotionalOffer, completion))
    }

    var invokedPurchaseProductOptions = false
    var invokedPurchaseProductOptionsCount = 0
    var invokedPurchaseProductOptionsParameters: (product: StoreProduct, options: Any, promotionalOffer: PromotionalOffer?)?
    var invokedPurchaseProductOptionsParametersList = [(product: StoreProduct, options: Any, promotionalOffer: PromotionalOffer?)]()

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?
    ) {
        invokedPurchaseProductOptions = true
        invokedPurchaseProductOptionsCount += 1
        invokedPurchaseProductOptionsParameters = (product, options, promotionalOffer)
        invokedPurchaseProductOptionsParametersList.append((product, options, promotionalOffer))
    }

    var invokedReceiptCompletion = false
    var invokedReceiptCompletionCount = 0
    var invokedReceiptCompletionParameters: (completion: Closure<Result<String, IAPError>>, Void)?
    var invokedReceiptCompletionParametersList = [(completion: Closure<Result<String, IAPError>>, Void)]()

    func receipt(completion: @escaping Closure<Result<String, IAPError>>) {
        invokedReceiptCompletion = true
        invokedReceiptCompletionCount += 1
        invokedReceiptCompletionParameters = (completion, ())
        invokedReceiptCompletionParametersList.append((completion, ()))
    }

    var invokedReceipt = false
    var invokedReceiptCount = 0

    func receipt() {
        invokedReceipt = true
        invokedReceiptCount += 1
    }

    var invokedFinishTransaction = false
    var invokedFinishTransactionCount = 0
    var invokedFinishTransactionParameters: (transaction: StoreTransaction, Void)?
    var invokedFinishTransactionParametersList = [(transaction: StoreTransaction, Void)]()
    var shouldInvokeFinishTransactionCompletion = false

    func finish(transaction: StoreTransaction, completion: (@Sendable () -> Void)?) {
        invokedFinishTransaction = true
        invokedFinishTransactionCount += 1
        invokedFinishTransactionParameters = (transaction, ())
        invokedFinishTransactionParametersList.append((transaction, ()))
        if shouldInvokeFinishTransactionCompletion {
            completion?()
        }
    }

    var invokedFinish = false
    var invokedFinishCount = 0
    var invokedFinishParameters: (transaction: StoreTransaction, Void)?
    var invokedFinishParametersList = [(transaction: StoreTransaction, Void)]()

    func finish(transaction: StoreTransaction) {
        invokedFinish = true
        invokedFinishCount += 1
        invokedFinishParameters = (transaction, ())
        invokedFinishParametersList.append((transaction, ()))
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

    var invokedCheckEligibility = false
    var invokedCheckEligibilityCount = 0
    var invokedCheckEligibilityParameters: (productIDs: Set<String>, Void)?
    var invokedCheckEligibilityParametersList = [(productIDs: Set<String>, Void)]()

    func checkEligibility(productIDs: Set<String>) {
        invokedCheckEligibility = true
        invokedCheckEligibilityCount += 1
        invokedCheckEligibilityParameters = (productIDs, ())
        invokedCheckEligibilityParametersList.append((productIDs, ()))
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product _: StoreProduct,
        options _: Set<Product.PurchaseOption>,
        promotionalOffer _: PromotionalOffer?
    ) async throws -> StoreTransaction {
        .fake()
    }

    func receipt() async throws -> String {
        ""
    }

    func checkEligibility(productIDs _: Set<String>) async throws -> [String: SubscriptionEligibility] {
        [:]
    }

    var invokedRestore = false
    var invokedRestoreCount = 0
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func restore() async throws {
        invokedRestore = true
        invokedRestoreCount += 1
    }

    #if os(iOS) || VISION_OS
        var invokedBeginRefundRequest = false
        var invokedBeginRefundRequestCount = 0
        var invokedBeginRefundRequestParameters: (productID: String, Void)?
        var invokedBeginRefundRequestParametersList = [(productID: String, Void)]()
        var stubbedBeginRefundRequest: RefundRequestStatus!

        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func beginRefundRequest(productID: String) async throws -> RefundRequestStatus {
            invokedBeginRefundRequest = true
            invokedBeginRefundRequestCount += 1
            invokedBeginRefundRequestParameters = (productID, ())
            invokedBeginRefundRequestParametersList.append((productID, ()))
            return stubbedBeginRefundRequest
        }

        var invokedPresentCodeRedemptionSheet = false
        var invokedPresentCodeRedemptionSheetCount = 0

        @available(iOS 14.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func presentCodeRedemptionSheet() {
            invokedPresentCodeRedemptionSheet = true
            invokedPresentCodeRedemptionSheetCount += 1
        }

        var invokedPresentOfferCodeRedeemSheet = false
        var invokedPresentOfferCodeRedeemSheetCount = 0

        @available(iOS 16.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func presentOfferCodeRedeemSheet() {
            invokedPresentOfferCodeRedeemSheet = true
            invokedPresentOfferCodeRedeemSheetCount += 1
        }
    #endif
}
