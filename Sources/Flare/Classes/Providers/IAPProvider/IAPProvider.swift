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

    // MARK: Initialization

    init(
        paymentQueue: PaymentQueue = SKPaymentQueue.default(),
        productProvider: IProductProvider = ProductProvider(),
        paymentProvider: IPaymentProvider = PaymentProvider(),
        receiptRefreshProvider: IReceiptRefreshProvider = ReceiptRefreshProvider()
    ) {
        self.paymentQueue = paymentQueue
        self.productProvider = productProvider
        self.paymentProvider = paymentProvider
        self.receiptRefreshProvider = receiptRefreshProvider
    }

    // MARK: Internal

    var canMakePayments: Bool {
        paymentQueue.canMakePayments
    }

    func fetch(productsIds: Set<String>, completion: @escaping Closure<Result<[SKProduct], IAPError>>) {
        productProvider.fetch(
            productIds: productsIds,
            requestId: UUID().uuidString,
            completion: completion
        )
    }

    func fetch(productsIDs: Set<String>) async throws -> [SKProduct] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetch(productsIds: productsIDs) { result in
                continuation.resume(with: result)
            }
        }
    }

    func purchase(productId: String, completion: @escaping Closure<Result<PaymentTransaction, IAPError>>) {
        productProvider.fetch(productIds: [productId], requestId: UUID().uuidString) { result in
            switch result {
            case let .success(products):
                guard let product = products.first else {
                    completion(.failure(.storeProductNotAvailable))
                    return
                }

                let payment = SKPayment(product: product)

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

    func purchase(productId: String) async throws -> PaymentTransaction {
        try await withCheckedThrowingContinuation { continuation in
            purchase(productId: productId) { result in
                continuation.resume(with: result)
            }
        }
    }

    func refreshReceipt(completion: @escaping Closure<Result<String, IAPError>>) {
        receiptRefreshProvider.refresh(requestId: UUID().uuidString) { [weak self] result in
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
}
