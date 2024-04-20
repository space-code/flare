//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

/// Protocol for objects that listen for transactions.
protocol ITransactionListener: Sendable {
    /// Listen for incoming transactions asynchronously.
    func listenForTransaction() async

    /// Handle the purchase result asynchronously.
    ///
    /// - Parameters:
    ///   - purchaseResult: The result of a StoreKit product purchase.
    /// - Returns: An optional `StoreTransaction` if handling is successful.
    ///
    /// - Note: Available on iOS 15.0+, tvOS 15.0+, macOS 12.0+, watchOS 8.0+.
    @available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
    func handle(purchaseResult: StoreKit.Product.PurchaseResult) async throws -> StoreTransaction?

    func set(delegate: TransactionListenerDelegate) async
}
