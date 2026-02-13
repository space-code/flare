//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - IStoreTransaction

/// A type that represents a store transaction.
protocol IStoreTransaction: Sendable {
    /// The unique identifier for the product.
    var productIdentifier: String { get }
    /// The date when the transaction occurred.
    var purchaseDate: Date { get }
    /// A boolean indicating whether the purchase date is known.
    var hasKnownPurchaseDate: Bool { get }
    /// A unique identifier for the transaction.
    var transactionIdentifier: String { get }
    /// A boolean indicating whether the transaction identifier is known.
    var hasKnownTransactionIdentifier: Bool { get }
    /// The quantity of the product involved in the transaction.
    var quantity: Int { get }
    /// The price of the in-app purchase that the system records in the transaction.
    var price: Decimal? { get }
    /// The currency of the price of the product.
    var currency: String? { get }

    /// The raw JWS representation of the transaction.
    ///
    /// - Note: This is only available for StoreKit 2 transactions.
    var jwsRepresentation: String? { get }

    /// The server environment where the receipt was generated.
    ///
    /// - Note: This is only available for StoreKit 2 transactions.
    var environment: StoreEnvironment? { get }

    /// The original transaction identifier of a purchase.
    ///
    /// - Note: This is only available for StoreKit 2 transactions.
    var originalID: UInt64? { get }
}

/// Default implementation of the currency property for backward compatibility.
extension IStoreTransaction {
    var currency: String? {
        Locale.current.currencyCodeID
    }
}
