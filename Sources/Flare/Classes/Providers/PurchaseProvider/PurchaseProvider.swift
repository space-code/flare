//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - PurchaseProvider

final class PurchaseProvider {
    // MARK: Properties

    /// The provider is responsible for making in-app payments.
    private let paymentProvider: IPaymentProvider
    /// <#Description#>
    private let transactionListener: ITransactionListener?

    // MARK: Initialization

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - paymentProvider: <#paymentProvider description#>
    ///   - transactionListener: <#transactionListener description#>
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
            try await sk2StoreProduct.product.purchase(options: [.simulatesAskToBuyInSandbox(false)])
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
