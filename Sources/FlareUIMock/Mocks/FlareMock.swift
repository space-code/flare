//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import FlareMock
import Foundation
import Log
import StoreKit

public final class FlareMock: IFlare {
    public init() {}

    public var invokedLogLevelSetter = false
    public var invokedLogLevelSetterCount = 0
    public var invokedLogLevel: Log.LogLevel?
    public var invokedLogLevelList = [Log.LogLevel]()
    public var invokedLogLevelGetter = false
    public var invokedLogLevelGetterCount = 0
    public var stubbedLogLevel: Log.LogLevel!

    public var logLevel: Log.LogLevel {
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

    public var invokedFetchProductIDs = false
    public var invokedFetchProductIDsCount = 0
    public var invokedFetchProductIDsParameters: (productIDs: Any, completion: Closure<Result<[StoreProduct], IAPError>>)?
    public var invokedFetchProductIDsParametersList = [(productIDs: Any, completion: Closure<Result<[StoreProduct], IAPError>>)]()

    public func fetch(productIDs: some Collection<String>, completion: @escaping Closure<Result<[StoreProduct], IAPError>>) {
        invokedFetchProductIDs = true
        invokedFetchProductIDsCount += 1
        invokedFetchProductIDsParameters = (productIDs, completion)
        invokedFetchProductIDsParametersList.append((productIDs, completion))
    }

    public var invokedFetch = false
    public var invokedFetchCount = 0
    public var invokedFetchParameters: (productIDs: Any, Void)?
    public var invokedFetchParametersList = [(productIDs: Any, Void)]()
    public var stubbedFetchError: Error?
    public var stubbedInvokedFetch: [StoreProduct] = []

    public func fetch(productIDs: some Collection<String>) async throws -> [StoreProduct] {
        invokedFetch = true
        invokedFetchCount += 1
        invokedFetchParameters = (productIDs, ())
        invokedFetchParametersList.append((productIDs, ()))
        if let stubbedFetchError = stubbedFetchError {
            throw stubbedFetchError
        }
        return stubbedInvokedFetch
    }

    public var invokedPurchaseProductPromotionalOffer = false
    public var invokedPurchaseProductPromotionalOfferCount = 0
    public var invokedPurchaseProductPromotionalOfferParameters: (
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: Closure<Result<StoreTransaction, IAPError>>
    )?
    public var invokedPurchaseProductPromotionalOfferParametersList = [(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: Closure<Result<StoreTransaction, IAPError>>
    )]()

    public func purchase(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping Closure<Result<StoreTransaction, IAPError>>
    ) {
        invokedPurchaseProductPromotionalOffer = true
        invokedPurchaseProductPromotionalOfferCount += 1
        invokedPurchaseProductPromotionalOfferParameters = (product, promotionalOffer, completion)
        invokedPurchaseProductPromotionalOfferParametersList.append((product, promotionalOffer, completion))
    }

    public var invokedPurchase = false
    public var invokedPurchaseCount = 0
    public var invokedPurchaseParameters: (product: StoreProduct, promotionalOffer: PromotionalOffer?)?
    public var invokedPurchaseParametersList = [(product: StoreProduct, promotionalOffer: PromotionalOffer?)]()
    public var stubbedPurchaseError: Error?
    public var stubbedPurchase: StoreTransaction!

    public func purchase(product: StoreProduct, promotionalOffer: PromotionalOffer?) async throws -> StoreTransaction {
        invokedPurchase = true
        invokedPurchaseCount += 1
        invokedPurchaseParameters = (product, promotionalOffer)
        invokedPurchaseParametersList.append((product, promotionalOffer))
        if let stubbedPurchaseError = stubbedPurchaseError {
            throw stubbedPurchaseError
        }
        return stubbedPurchase
    }

    public var invokedPurchaseProductOptionsPromotionalOffer = false
    public var invokedPurchaseProductOptionsPromotionalOfferCount = 0
    public var invokedPurchaseProductOptionsPromotionalOfferParameters: (
        product: StoreProduct,
        options: Any,
        promotionalOffer: PromotionalOffer?,
        completion: SendableClosure<Result<StoreTransaction, IAPError>>
    )?
    public var invokedPurchaseProductOptionsPromotionalOfferParametersList = [(
        product: StoreProduct,
        options: Any,
        promotionalOffer: PromotionalOffer?,
        completion: SendableClosure<Result<StoreTransaction, IAPError>>
    )]()

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func purchase(
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

    public var invokedPurchaseProductOptions = false
    public var invokedPurchaseProductOptionsCount = 0
    public var invokedPurchaseProductOptionsParameters: (product: StoreProduct, options: Any, promotionalOffer: PromotionalOffer?)?
    public var invokedPurchaseProductOptionsParametersList = [(product: StoreProduct, options: Any, promotionalOffer: PromotionalOffer?)]()

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?
    ) {
        invokedPurchaseProductOptions = true
        invokedPurchaseProductOptionsCount += 1
        invokedPurchaseProductOptionsParameters = (product, options, promotionalOffer)
        invokedPurchaseProductOptionsParametersList.append((product, options, promotionalOffer))
    }

    public var invokedReceiptCompletion = false
    public var invokedReceiptCompletionCount = 0
    public var invokedReceiptCompletionParameters: (completion: Closure<Result<String, IAPError>>, Void)?
    public var invokedReceiptCompletionParametersList = [(completion: Closure<Result<String, IAPError>>, Void)]()

    public func receipt(completion: @escaping Closure<Result<String, IAPError>>) {
        invokedReceiptCompletion = true
        invokedReceiptCompletionCount += 1
        invokedReceiptCompletionParameters = (completion, ())
        invokedReceiptCompletionParametersList.append((completion, ()))
    }

    public var invokedReceipt = false
    public var invokedReceiptCount = 0

    public func receipt() {
        invokedReceipt = true
        invokedReceiptCount += 1
    }

    public var invokedFinishTransaction = false
    public var invokedFinishTransactionCount = 0
    public var invokedFinishTransactionParameters: (transaction: StoreTransaction, Void)?
    public var invokedFinishTransactionParametersList = [(transaction: StoreTransaction, Void)]()
    public var shouldInvokeFinishTransactionCompletion = false

    public func finish(transaction: StoreTransaction, completion: (@Sendable () -> Void)?) {
        invokedFinishTransaction = true
        invokedFinishTransactionCount += 1
        invokedFinishTransactionParameters = (transaction, ())
        invokedFinishTransactionParametersList.append((transaction, ()))
        if shouldInvokeFinishTransactionCompletion {
            completion?()
        }
    }

    public var invokedFinish = false
    public var invokedFinishCount = 0
    public var invokedFinishParameters: (transaction: StoreTransaction, Void)?
    public var invokedFinishParametersList = [(transaction: StoreTransaction, Void)]()

    public func finish(transaction: StoreTransaction) {
        invokedFinish = true
        invokedFinishCount += 1
        invokedFinishParameters = (transaction, ())
        invokedFinishParametersList.append((transaction, ()))
    }

    public var invokedAddTransactionObserver = false
    public var invokedAddTransactionObserverCount = 0
    public var invokedAddTransactionObserverParameters: (fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?, Void)?
    public var invokedAddTransactionObserverParametersList = [(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?, Void)]()

    public func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        invokedAddTransactionObserver = true
        invokedAddTransactionObserverCount += 1
        invokedAddTransactionObserverParameters = (fallbackHandler, ())
        invokedAddTransactionObserverParametersList.append((fallbackHandler, ()))
    }

    public var invokedRemoveTransactionObserver = false
    public var invokedRemoveTransactionObserverCount = 0

    public func removeTransactionObserver() {
        invokedRemoveTransactionObserver = true
        invokedRemoveTransactionObserverCount += 1
    }

    public var invokedCheckEligibility = false
    public var invokedCheckEligibilityCount = 0
    public var invokedCheckEligibilityParameters: (productIDs: Set<String>, Void)?
    public var invokedCheckEligibilityParametersList = [(productIDs: Set<String>, Void)]()

    public func checkEligibility(productIDs: Set<String>) {
        invokedCheckEligibility = true
        invokedCheckEligibilityCount += 1
        invokedCheckEligibilityParameters = (productIDs, ())
        invokedCheckEligibilityParametersList.append((productIDs, ()))
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func purchase(
        product _: StoreProduct,
        options _: Set<Product.PurchaseOption>,
        promotionalOffer _: PromotionalOffer?
    ) async throws -> StoreTransaction {
        StoreTransaction(paymentTransaction: PaymentTransaction(PaymentTransactionMock()))
    }

    public func receipt() async throws -> String {
        ""
    }

    public func checkEligibility(productIDs _: Set<String>) async throws -> [String: SubscriptionEligibility] {
        [:]
    }

    public var invokedRestore = false
    public var invokedRestoreCount = 0
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func restore() async throws {
        invokedRestore = true
        invokedRestoreCount += 1
    }

    #if os(iOS) || VISION_OS
        public var invokedBeginRefundRequest = false
        public var invokedBeginRefundRequestCount = 0
        public var invokedBeginRefundRequestParameters: (productID: String, Void)?
        public var invokedBeginRefundRequestParametersList = [(productID: String, Void)]()
        public var stubbedBeginRefundRequest: RefundRequestStatus!

        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        public func beginRefundRequest(productID: String) async throws -> RefundRequestStatus {
            invokedBeginRefundRequest = true
            invokedBeginRefundRequestCount += 1
            invokedBeginRefundRequestParameters = (productID, ())
            invokedBeginRefundRequestParametersList.append((productID, ()))
            return stubbedBeginRefundRequest
        }

        public var invokedPresentCodeRedemptionSheet = false
        public var invokedPresentCodeRedemptionSheetCount = 0

        @available(iOS 14.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        public func presentCodeRedemptionSheet() {
            invokedPresentCodeRedemptionSheet = true
            invokedPresentCodeRedemptionSheetCount += 1
        }

        public var invokedPresentOfferCodeRedeemSheet = false
        public var invokedPresentOfferCodeRedeemSheetCount = 0

        @available(iOS 16.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        public func presentOfferCodeRedeemSheet() {
            invokedPresentOfferCodeRedeemSheet = true
            invokedPresentOfferCodeRedeemSheetCount += 1
        }
    #endif
}
