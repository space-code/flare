//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

typealias FallbackHandler = SendableClosure<Result<StoreTransaction, IAPError>>

// MARK: - PurchaseProvider

final class PurchaseProvider: @unchecked Sendable {
    // MARK: Properties

    /// The provider is responsible for making in-app payments.
    private let paymentProvider: IPaymentProvider
    /// The transaction listener.
    private var transactionListener: ITransactionListener?
    /// The configuration provider.
    private let configurationProvider: IConfigurationProvider
    /// The fallback handler.
    private var fallbackHandler: FallbackHandler?

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

        if let transactionListener {
            self.transactionListener = transactionListener
        } else if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
            self.configureTransactionListener()
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
                    Logger.info(message: L10n.Purchase.purchasedProduct(sk1StoreProduct.productIdentifier))
                case let .failure(error):
                    await completion(.failure(error))
                    self.log(error: error, productID: sk1StoreProduct.productIdentifier)
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
                    do {
                        if let transaction = try await self.transactionListener?.handle(purchaseResult: result) {
                            await completion(.success(transaction))
                            Logger.info(message: L10n.Purchase.purchasedProduct(sk2StoreProduct.productIdentifier))
                        } else {
                            await completion(.failure(IAPError.unknown))
                            self.log(error: IAPError.unknown, productID: sk2StoreProduct.productIdentifier)
                        }
                    } catch {
                        if let error = error as? IAPError {
                            await completion(.failure(error))
                        } else {
                            await completion(.failure(.with(error: error)))
                        }
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

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    private func configureTransactionListener() {
        self.transactionListener = TransactionListener(delegate: self, updates: StoreKit.Transaction.updates)

        Task {
            await self.transactionListener?.listenForTransaction()
        }
    }

    private func log(error: Error, productID: String) {
        Logger.error(message: L10n.Purchase.productPurchaseFailed(productID, error.localizedDescription))
    }

    private func logPurchase(productID: String, promotionalOffer: PromotionalOffer?) {
        if let offerID = promotionalOffer?.discount.offerIdentifier {
            Logger.info(
                message: L10n.Purchase.purchasingProductWithOffer(productID, offerID)
            )
        } else {
            Logger.info(message: L10n.Purchase.purchasingProduct(productID))
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
        logPurchase(productID: product.productIdentifier, promotionalOffer: promotionalOffer)

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
        logPurchase(productID: product.productIdentifier, promotionalOffer: promotionalOffer)

        if let sk2Product = product.underlyingProduct as? SK2StoreProduct {
            purchase(
                sk2StoreProduct: sk2Product,
                options: options,
                promotionalOffer: promotionalOffer,
                completion: completion
            )
        } else {
            Task {
                completion(.failure(.unknown))
                self.log(error: IAPError.unknown, productID: product.productIdentifier)
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

                    Logger.info(
                        message: L10n.Purchase.finishingTransaction(
                            sk2Transaction.transactionIdentifier,
                            sk2Transaction.productIdentifier
                        )
                    )
                }
            )
        } else if let sk1Transaction = transaction.storeTransaction as? SK1StoreTransaction {
            paymentProvider.finish(transaction: sk1Transaction.transaction)
            completion?()
        }
    }

    func addTransactionObserver(fallbackHandler: FallbackHandler?) {
        self.fallbackHandler = fallbackHandler

        paymentProvider.set { _, result in
            switch result {
            case let .success(transaction):
                fallbackHandler?(.success(StoreTransaction(paymentTransaction: PaymentTransaction(transaction))))
            case let .failure(error):
                fallbackHandler?(.failure(error))
            }
        }
        paymentProvider.addTransactionObserver()
    }

    func removeTransactionObserver() {
        paymentProvider.removeTransactionObserver()
    }

    func restore() async throws {
        if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
            try await AppStore.sync()
        } else {
            try await withCheckedThrowingContinuation { continuation in
                restore { result in
                    continuation.resume(with: result)
                }
            }
        }
    }

    func restore(_ completion: @escaping @Sendable (Result<Void, Error>) -> Void) {
        paymentProvider.restoreCompletedTransactions { _, error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

// MARK: TransactionListenerDelegate

extension PurchaseProvider: TransactionListenerDelegate {
    func transactionListener(_: ITransactionListener, transactionDidUpdate result: Result<StoreTransaction, IAPError>) {
        switch result {
        case let .success(transaction):
            self.fallbackHandler?(.success(transaction))
        case let .failure(error):
            self.fallbackHandler?(.failure(error))
        }
    }
}
