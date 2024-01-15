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

    // MARK: Initialization

    /// Creates a new `IAPProvider` instance.
    ///
    /// - Parameters:
    ///   - paymentQueue: The queue of payment transactions to be processed by the App Store.
    ///   - productProvider: The provider is responsible for fetching StoreKit products.
    ///   - purchaseProvider:
    ///   - receiptRefreshProvider: The provider is responsible for refreshing receipts.
    ///   - refundProvider: The provider is responsible for refunding purchases.
    init(
        paymentQueue: PaymentQueue = SKPaymentQueue.default(),
        productProvider: IProductProvider = ProductProvider(),
        purchaseProvider: IPurchaseProvider = PurchaseProvider(),
        receiptRefreshProvider: IReceiptRefreshProvider = ReceiptRefreshProvider(),
        refundProvider: IRefundProvider = RefundProvider(
            systemInfoProvider: SystemInfoProvider()
        )
    ) {
        self.paymentQueue = paymentQueue
        self.productProvider = productProvider
        self.purchaseProvider = purchaseProvider
        self.receiptRefreshProvider = receiptRefreshProvider
        self.refundProvider = refundProvider
    }

    // MARK: Internal

    var canMakePayments: Bool {
        paymentQueue.canMakePayments
    }

    func fetch(productIDs: Set<String>, completion: @escaping Closure<Result<[StoreProduct], IAPError>>) {
        if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
            AsyncHandler.call(
                completion: { [weak self] (result: Result<[SK2StoreProduct], Error>) in
                    self?.handleFetchResult(result: result, completion)
                },
                asyncMethod: {
                    try await self.productProvider.fetch(productIDs: productIDs)
                }
            )
        } else {
            productProvider.fetch(
                productIDs: productIDs,
                requestID: UUID().uuidString
            ) { [weak self] result in
                self?.handleFetchResult(result: result, completion)
            }
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

    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        purchaseProvider.addTransactionObserver(fallbackHandler: fallbackHandler)
    }

    func removeTransactionObserver() {
        purchaseProvider.removeTransactionObserver()
    }

    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func beginRefundRequest(productID: String) async throws -> RefundRequestStatus {
            try await refundProvider.beginRefundRequest(productID: productID)
        }
    #endif

    // MARK: Private

    private func handleFetchResult<T: ISKProduct, E: Error>(
        result: Result<[T], E>,
        _ completion: @escaping (Result<[StoreProduct], IAPError>) -> Void
    ) {
        switch result {
        case let .success(products):
            completion(.success(products.map { StoreProduct($0) }))
        case let .failure(error):
            if let iapError = error as? IAPError {
                completion(.failure(iapError))
            } else {
                completion(.failure(IAPError(error: error)))
            }
        }
    }
}
