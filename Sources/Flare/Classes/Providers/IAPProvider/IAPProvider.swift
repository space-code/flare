//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

/// A class that provides in-app purchase functionality.
final class IAPProvider: IIAPProvider {
    // MARK: Properties

    /// The queue of payment transactions to be processed by the App Store.
    private let paymentQueue: PaymentQueue
    /// The provider is responsible for fetching StoreKit products.
    private let productProvider: IProductProvider
    /// The provider is responsible for purchasing products.
    private let purchaseProvider: IPurchaseProvider
    /// The provider is responsible for refreshing receipts.
    private let receiptRefreshProvider: IReceiptRefreshProvider
    /// The provider is responsible for refunding purchases
    private let refundProvider: IRefundProvider
    /// The provider is responsible for eligibility checking.
    private let eligibilityProvider: IEligibilityProvider
    /// The provider is tasked with handling code redemption.
    private let redeemCodeProvider: IRedeemCodeProvider

    // MARK: Initialization

    /// Creates a new `IAPProvider` instance.
    ///
    /// - Parameters:
    ///   - paymentQueue: The queue of payment transactions to be processed by the App Store.
    ///   - productProvider: The provider is responsible for fetching StoreKit products.
    ///   - purchaseProvider: The provider is respinsible for purchasing StoreKit product.
    ///   - receiptRefreshProvider: The provider is responsible for refreshing receipts.
    ///   - refundProvider: The provider is responsible for refunding purchases.
    ///   - eligibilityProvider: The provider is responsible for eligibility checking.
    ///   - redeemCodeProvider: The provider is tasked with handling code redemption.
    init(
        paymentQueue: PaymentQueue,
        productProvider: IProductProvider,
        purchaseProvider: IPurchaseProvider,
        receiptRefreshProvider: IReceiptRefreshProvider,
        refundProvider: IRefundProvider,
        eligibilityProvider: IEligibilityProvider,
        redeemCodeProvider: IRedeemCodeProvider
    ) {
        self.paymentQueue = paymentQueue
        self.productProvider = productProvider
        self.purchaseProvider = purchaseProvider
        self.receiptRefreshProvider = receiptRefreshProvider
        self.refundProvider = refundProvider
        self.eligibilityProvider = eligibilityProvider
        self.redeemCodeProvider = redeemCodeProvider
    }

    // MARK: Internal

    var canMakePayments: Bool {
        paymentQueue.canMakePayments
    }

    func fetch(productIDs: Set<String>, completion: @escaping Closure<Result<[StoreProduct], IAPError>>) {
        if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
            AsyncHandler.call(
                strategy: .runOnMain,
                completion: { (result: Result<[StoreProduct], Error>) in
                    switch result {
                    case let .success(products):
                        completion(.success(products))
                    case let .failure(error):
                        completion(.failure(.with(error: error)))
                    }
                },
                asyncMethod: {
                    try await self.productProvider.fetch(productIDs: productIDs)
                }
            )
        } else {
            productProvider.fetch(
                productIDs: productIDs,
                requestID: UUID().uuidString,
                completion: completion
            )
        }
    }

    func fetch(productIDs: Set<String>) async throws -> [StoreProduct] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetch(productIDs: productIDs) { result in
                continuation.resume(with: result)
            }
        }
    }

    func purchase(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping Closure<Result<StoreTransaction, IAPError>>
    ) {
        purchaseProvider.purchase(product: product, promotionalOffer: promotionalOffer) { result in
            switch result {
            case let .success(transaction):
                completion(.success(transaction))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func purchase(product: StoreProduct, promotionalOffer: PromotionalOffer?) async throws -> StoreTransaction {
        try await withCheckedThrowingContinuation { continuation in
            self.purchase(product: product, promotionalOffer: promotionalOffer) { result in
                continuation.resume(with: result)
            }
        }
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping SendableClosure<Result<StoreTransaction, IAPError>>
    ) {
        purchaseProvider.purchase(product: product, options: options, promotionalOffer: promotionalOffer, completion: completion)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?
    ) async throws -> StoreTransaction {
        try await withCheckedThrowingContinuation { continuation in
            purchase(product: product, options: options, promotionalOffer: promotionalOffer) { result in
                continuation.resume(with: result)
            }
        }
    }

    func refreshReceipt(completion: @escaping Closure<Result<String, IAPError>>) {
        receiptRefreshProvider.refresh(requestID: UUID().uuidString) { [weak self] result in
            switch result {
            case .success:
                if let receipt = self?.receiptRefreshProvider.receipt {
                    completion(.success(receipt))
                } else {
                    completion(.failure(.receiptNotFound))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func refreshReceipt() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            refreshReceipt { result in
                continuation.resume(with: result)
            }
        }
    }

    func finish(transaction: StoreTransaction, completion: (@Sendable () -> Void)?) {
        purchaseProvider.finish(transaction: transaction, completion: completion)
    }

    func finish(transaction: StoreTransaction) async {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            finish(transaction: transaction) {
                continuation.resume(returning: ())
            }
        }
    }

    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        purchaseProvider.addTransactionObserver(fallbackHandler: fallbackHandler)
    }

    func removeTransactionObserver() {
        purchaseProvider.removeTransactionObserver()
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func checkEligibility(productIDs: Set<String>) async throws -> [String: SubscriptionEligibility] {
        let products = try await fetch(productIDs: productIDs)
        return try await eligibilityProvider.checkEligibility(products: products)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func restore() async throws {
        try await purchaseProvider.restore()
    }

    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func beginRefundRequest(productID: String) async throws -> RefundRequestStatus {
            try await refundProvider.beginRefundRequest(productID: productID)
        }

        @available(iOS 14.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func presentCodeRedemptionSheet() {
            Logger.debug(message: L10n.Redeem.presentingCodeRedemptionSheet)
            paymentQueue.presentCodeRedemptionSheet()
        }

        @available(iOS 16.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func presentOfferCodeRedeemSheet() async throws {
            try await redeemCodeProvider.presentOfferCodeRedeemSheet()
        }
    #endif
}
