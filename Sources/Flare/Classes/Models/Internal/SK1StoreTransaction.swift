//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

// MARK: - SK1StoreTransaction

/// A struct representing the first version of the transaction.
struct SK1StoreTransaction {
    // MARK: Properties

    /// The StoreKit transaction.
    let transaction: PaymentTransaction

    // MARK: Initialization

    /// Creates a new `SK1StoreTransaction` instance.
    ///
    /// - Parameter transaction: The StoreKit transaction.
    init(transaction: PaymentTransaction) {
        self.transaction = transaction
    }
}

// MARK: IStoreTransaction

extension SK1StoreTransaction: IStoreTransaction {
    var originalID: UInt64? {
        nil
    }

    var productIdentifier: String {
        transaction.productIdentifier
    }

    var purchaseDate: Date {
        guard let date = transaction.transactionDate else {
            return Date(timeIntervalSince1970: 0)
        }
        return date
    }

    var hasKnownPurchaseDate: Bool {
        transaction.transactionDate != nil
    }

    var transactionIdentifier: String {
        transaction.transactionIdentifier ?? ""
    }

    var hasKnownTransactionIdentifier: Bool {
        transaction.transactionIdentifier != nil
    }

    var quantity: Int {
        let payment = transaction.skTransaction.payment
        return payment.quantity
    }

    var jwsRepresentation: String? {
        nil
    }

    var environment: StoreEnvironment? {
        nil
    }

    var price: Decimal? {
        nil
    }

    var currency: String? {
        nil
    }
}
