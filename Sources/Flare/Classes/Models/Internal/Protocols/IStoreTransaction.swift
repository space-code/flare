//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// A type that represents a store transaction.
protocol IStoreTransaction {
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

    /// The raw JWS repesentation of the transaction.
    ///
    /// - Note: this is only available for StoreKit 2 transactions.
    var jwsRepresentation: String? { get }

    /// The server environment where the receipt was generated.
    ///
    /// - Note: this is only available for StoreKit 2 transactions.
    var environment: StoreEnvironment? { get }
}
