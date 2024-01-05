//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - PurchaseProvider

final class PurchaseProvider {
    // MARK: Properties

    /// The provider is responsible for making in-app payments.
    private let paymentProvider: IPaymentProvider
    /// The transaction listener.
    private let transactionListener: ITransactionListener?

    // MARK: Initialization

    /// Creates a new `PurchaseProvider` instance.
    ///
    /// - Parameters:
    ///   - paymentProvider: The provider is responsible for purchasing products.
    ///   - transactionListener: The transaction listener.
    init(
        paymentProvider: IPaymentProvider = PaymentProvider(),
        transactionListener: ITransactionListener? = nil
    ) {
        self.paymentProvider = paymentProvider

        if let transactionListener = transactionListener {
            self.transactionListener = transactionListener
        } else if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
            self.transactionListener = TransactionListener(updates: StoreKit.Transaction.updates)
        } else {
            self.transactionListener = nil
        }
    }

    // MARK: Private

    private func purchase(
        sk1StoreProduct: SK1StoreProduct,
        completion: @escaping @MainActor (Result<StoreTransaction, IAPError>) -> Void
    ) {
        let payment = SKPayment(product: sk1StoreProduct.product)
        paymentProvider.add(payment: payment) { _, result in
            Task {
                switch result {
                case let .success(transaction):
                    await completion(.success(StoreTransaction(paymentTransaction: PaymentTransaction(transaction))))
                case let .failure(error):
                    await completion(.failure(error))
                }
            }
        }
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    private func purchase(
        sk2StoreProduct: SK2StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>? = nil,
        completion: @escaping @MainActor (Result<StoreTransaction, IAPError>) -> Void
    ) {
        AsyncHandler.call(completion: { result in
            Task {
                switch result {
                case let .success(result):
                    if let transaction = try await self.transactionListener?.handle(purchaseResult: result) {
                        await completion(.success(transaction))
                    } else {
                        await completion(.failure(IAPError.unknown))
                    }
                case let .failure(error):
                    await completion(.failure(IAPError(error: error)))
                }
            }
        }, asyncMethod: {
            try await sk2StoreProduct.product.purchase(options: options ?? [])
        })
    }
}

// MARK: IPurchaseProvider

extension PurchaseProvider: IPurchaseProvider {
    func purchase(product: StoreProduct, completion: @escaping PurchaseCompletionHandler) {
        if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *),
           let sk2Product = product.underlyingProduct as? SK2StoreProduct
        {
            self.purchase(sk2StoreProduct: sk2Product, completion: completion)
        } else if let sk1Product = product.underlyingProduct as? SK1StoreProduct {
            purchase(sk1StoreProduct: sk1Product, completion: completion)
        }
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<Product.PurchaseOption>,
        completion: @escaping PurchaseCompletionHandler
    ) {
        if let sk2Product = product.underlyingProduct as? SK2StoreProduct {
            purchase(sk2StoreProduct: sk2Product, options: options, completion: completion)
        } else {
            Task {
                await completion(.failure(.unknown))
            }
        }
    }

    func finish(transaction: StoreTransaction, completion: (@Sendable () -> Void)?) {
        if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *),
           let sk2Transaction = transaction.storeTransaction as? SK2StoreTransaction
        {
            AsyncHandler.call(
                completion: { _ in
                    completion?()
                },
                asyncMethod: {
                    await sk2Transaction.transaction.finish()
                }
            )
        } else if let sk1Transaction = transaction.storeTransaction as? SK1StoreTransaction {
            paymentProvider.finish(transaction: sk1Transaction.transaction)
            completion?()
        }
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
