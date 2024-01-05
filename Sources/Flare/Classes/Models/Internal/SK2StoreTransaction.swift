//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - SK2StoreTransaction

/// A struct representing the second version of the transaction.
@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
struct SK2StoreTransaction {
    // MARK: Properties

    /// The StoreKit transaction.
    let transaction: StoreKit.Transaction
    /// The raw JWS repesentation of the transaction.
    private let _jwsRepresentation: String?

    // MARK: Initialization

    /// Creates a new `SK1StoreTransaction` instance.
    ///
    /// - Parameters:
    ///   - transaction: The StoreKit transaction.
    ///   - jwsRepresentation: The raw JWS repesentation of the transaction.
    init(transaction: StoreKit.Transaction, jwsRepresentation: String) {
        self.transaction = transaction
        _jwsRepresentation = jwsRepresentation
    }
}

// MARK: IStoreTransaction

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
extension SK2StoreTransaction: IStoreTransaction {
    var productIdentifier: String {
        transaction.productID
    }

    var purchaseDate: Date {
        transaction.purchaseDate
    }

    var hasKnownPurchaseDate: Bool {
        true
    }

    var transactionIdentifier: String {
        String(transaction.id)
    }

    var hasKnownTransactionIdentifier: Bool {
        true
    }

    var quantity: Int {
        transaction.purchasedQuantity
    }

    var jwsRepresentation: String? {
        _jwsRepresentation
    }

    var environment: StoreEnvironment? {
        StoreEnvironment(transaction: transaction)
    }
}
