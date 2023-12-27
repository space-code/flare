//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

public typealias PurchaseCompletionHandler = @MainActor @Sendable (Result<StoreTransaction, IAPError>) -> Void

// MARK: - IPurchaseProvider

protocol IPurchaseProvider {
    /// Removes a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameter transaction: An object in the payment queue.
    func finish(transaction: PaymentTransaction)

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

    func purchase(product: StoreProduct, completion: @escaping PurchaseCompletionHandler)

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func purchase(
        product: StoreProduct,
        options: Set<StoreKit.Product.PurchaseOption>,
        completion: @escaping PurchaseCompletionHandler
    )
}
