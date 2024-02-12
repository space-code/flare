//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

public typealias PurchaseCompletionHandler = @MainActor @Sendable (Result<StoreTransaction, IAPError>) -> Void

// MARK: - IPurchaseProvider

protocol IPurchaseProvider {
    /// Removes a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameters:
    ///   - transaction: An object in the payment queue.
    ///   - completion: If a completion closure is provided, call it after finishing the transaction.
    func finish(transaction: StoreTransaction, completion: (@Sendable () -> Void)?)

    /// Adds transaction observer to the payment queue.
    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func addTransactionObserver(fallbackHandler: Closure<Result<PaymentTransaction, IAPError>>?)

    /// Removes transaction observer from the payment queue.
    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func removeTransactionObserver()

    /// Purchases a product.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - promotionalOffer: The promotional offer.
    ///   - completion: The closure to be executed once the purchase is complete.
    func purchase(
        product: StoreProduct,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping PurchaseCompletionHandler
    )

    /// Purchases a product.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - options: The optional settings for a product purchase.
    ///   - promotionalOffer: The promotional offer.
    ///   - completion: The closure to be executed once the purchase is complete.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        promotionalOffer: PromotionalOffer?,
        completion: @escaping PurchaseCompletionHandler
    )
}

extension IPurchaseProvider {
    /// Purchases a product.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - completion: The closure to be executed once the purchase is complete.
    func purchase(
        product: StoreProduct,
        completion: @escaping PurchaseCompletionHandler
    ) {
        purchase(product: product, promotionalOffer: nil, completion: completion)
    }

    /// Purchases a product.
    ///
    /// - Parameters:
    ///   - product: The product to be purchased.
    ///   - options: The optional settings for a product purchase.
    ///   - completion: The closure to be executed once the purchase is complete.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        completion: @escaping PurchaseCompletionHandler
    ) {
        purchase(product: product, options: options, promotionalOffer: nil, completion: completion)
    }
}
