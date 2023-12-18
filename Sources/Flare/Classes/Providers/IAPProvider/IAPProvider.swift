//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

final class IAPProvider: IIAPProvider {
    // MARK: Properties

    private let paymentQueue: PaymentQueue
    private let productProvider: IProductProvider
    private let paymentProvider: IPaymentProvider
    private let receiptRefreshProvider: IReceiptRefreshProvider
    private let refundProvider: IRefundProvider

    // MARK: Initialization

    init(
        paymentQueue: PaymentQueue = SKPaymentQueue.default(),
        productProvider: IProductProvider = ProductProvider(),
        paymentProvider: IPaymentProvider = PaymentProvider(),
        receiptRefreshProvider: IReceiptRefreshProvider = ReceiptRefreshProvider(),
        refundProvider: IRefundProvider = RefundProvider(
            systemInfoProvider: SystemInfoProvider()
        )
    ) {
        self.paymentQueue = paymentQueue
        self.productProvider = productProvider
        self.paymentProvider = paymentProvider
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
                completion: { [weak self] result in
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

    func purchase(productID: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>) {
        productProvider.fetch(productIDs: [productID], requestID: UUID().uuidString) { result in
            switch result {
            case let .success(products):
                guard let product = products.first else {
                    completion(.failure(.storeProductNotAvailable))
                    return
                }

                let payment = SKPayment(product: product.product)

                self.paymentProvider.add(payment: payment) { _, result in
                    switch result {
                    case let .success(transaction):
                        completion(.success(PaymentTransaction(transaction)))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func purchase(productID: String) async throws -> PaymentTransaction {
        try await withCheckedThrowingContinuation { continuation in
            purchase(productID: productID) { result in
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

    func finish(transaction: PaymentTransaction) {
        paymentProvider.finish(transaction: transaction)
    }

    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?) {
        paymentProvider.set { _, result in
            switch result {
            case let .success(transaction):
                fallbackHandler?(.success(PaymentTransaction(transaction)))
            case let .failure(error):
                fallbackHandler?(.failure(error))
            }
        }
        paymentProvider.addTransactionObserver()
    }

    func removeTransactionObserver() {
        paymentProvider.removeTransactionObserver()
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
