//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

public typealias PurchaseCompletionHandler = @Sendable (Result<StoreTransaction, IAPError>) -> Void

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
    func addTransactionObserver(fallbackHandler: SendableClosure<Result<StoreTransaction, IAPError>>?)

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

    /// Restores completed transactions.
    ///
    /// This method initiates the process of restoring any previously completed transactions.
    /// It is an asynchronous function that might throw an error if the restoration fails.
    ///
    /// - Throws: An error if the restoration process encounters an issue.
    ///
    /// - Note: This method should be called when you need to restore purchases made by the user on a different device or after
    /// reinstallation.
    func restore() async throws

    /// Restores completed transactions.
    ///
    /// This method initiates the process of restoring any previously completed transactions.
    /// It uses a completion handler to provide the result of the restoration process.
    ///
    /// - Parameter completion: A closure that gets called with a `Result` indicating success or failure of the restoration.
    ///   - On success, it returns `Result<Void, Error>.success(())`.
    ///   - On failure, it returns `Result<Void, Error>.failure(Error)` with an error describing the issue.
    ///
    /// - Note: Use this method when you need to handle the restoration process asynchronously and provide feedback through the completion
    /// handler.
    func restore(_ completion: @escaping @Sendable (Result<Void, Error>) -> Void)
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
