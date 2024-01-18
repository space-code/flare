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
    /// The configuration provider.
    private let configurationProvider: IConfigurationProvider

    // MARK: Initialization

    /// Creates a new `PurchaseProvider` instance.
    ///
    /// - Parameters:
    ///   - paymentProvider: The provider is responsible for purchasing products.
    ///   - transactionListener: The transaction listener.
    ///   - configurationProvider: The configuration provider.
    init(
        paymentProvider: IPaymentProvider,
        transactionListener: ITransactionListener? = nil,
        configurationProvider: IConfigurationProvider
    ) {
        self.paymentProvider = paymentProvider
        self.configurationProvider = configurationProvider

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
        promotionalOffer: PromotionalOffer?,
        completion: @escaping @MainActor (Result<StoreTransaction, IAPError>) -> Void
    ) {
        let payment = SKMutablePayment(product: sk1StoreProduct.product)
        payment.applicationUsername = configurationProvider.applicationUsername
        payment.paymentDiscount = promotionalOffer?.signedData.skPromotionalOffer
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
        promotionalOffer: PromotionalOffer?,
        completion: @escaping @MainActor (Result<StoreTransaction, IAPError>) -> Void
    ) {
        AsyncHandler.call(completion: { (result: Result<Product.PurchaseResult, Error>) in
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
            var options: Set<StoreKit.Product.PurchaseOption> = options ?? []
            try self.configure(options: &options, promotionalOffer: promotionalOffer)
            return try await sk2StoreProduct.product.purchase(options: options)
        })
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    private func configure(options: inout Set<StoreKit.Product.PurchaseOption>, promotionalOffer: PromotionalOffer?) throws {
        if let promotionalOffer {
            try options.insert(promotionalOffer.signedData.promotionalOffer)
        }

        if let applicationUsername = configurationProvider.applicationUsername, let uuid = UUID(uuidString: applicationUsername) {
            // If options contain an app account token, the next line of code doesn't affect it.
            options.insert(.appAccountToken(uuid))
        }
    }
}

// MARK: IPurchaseProvider

extension PurchaseProvider: IPurchaseProvider {
    func purchase(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping PurchaseCompletionHandler
    ) {
        if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *),
           let sk2Product = product.underlyingProduct as? SK2StoreProduct
        {
            self.purchase(sk2StoreProduct: sk2Product, promotionalOffer: promotionalOffer, completion: completion)
        } else if let sk1Product = product.underlyingProduct as? SK1StoreProduct {
            purchase(sk1StoreProduct: sk1Product, promotionalOffer: promotionalOffer, completion: completion)
        }
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping PurchaseCompletionHandler
    ) {
        if let sk2Product = product.underlyingProduct as? SK2StoreProduct {
            purchase(
                sk2StoreProduct: sk2Product,
                options: options,
                promotionalOffer: promotionalOffer,
                completion: completion
            )
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
