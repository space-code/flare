//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - StoreTransaction

/// A class represent a StoreKit transaction.
public final class StoreTransaction {
    // MARK: Properties

    /// The StoreKit transaction.
    let storeTransaction: IStoreTransaction

    // MARK: Initialization

    /// Creates a new `StoreTransaction` instance.
    ///
    /// - Parameter storeTransaction: The StoreKit transaction.
    init(storeTransaction: IStoreTransaction) {
        self.storeTransaction = storeTransaction
    }
}

// MARK: - Convinience Initializators

extension StoreTransaction {
    /// Creates a new `StoreTransaction` instance.
    ///
    /// - Parameter paymentTransaction: The StoreKit transaction.
    convenience init(paymentTransaction: PaymentTransaction) {
        self.init(storeTransaction: SK1StoreTransaction(transaction: paymentTransaction))
    }

    /// Creates a new `StoreTransaction` instance.
    ///
    /// - Parameters:
    ///   - transaction: The StoreKit transaction.
    ///   - jwtRepresentation: The server environment where the receipt was generated.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    convenience init(transaction: StoreKit.Transaction, jwtRepresentation: String) {
        self.init(storeTransaction: SK2StoreTransaction(transaction: transaction, jwsRepresentation: jwtRepresentation))
    }
}

// MARK: IStoreTransaction

extension StoreTransaction: IStoreTransaction {
    var productIdentifier: String {
        storeTransaction.productIdentifier
    }

    var purchaseDate: Date {
        storeTransaction.purchaseDate
    }

    var hasKnownPurchaseDate: Bool {
        storeTransaction.hasKnownPurchaseDate
    }

    var transactionIdentifier: String {
        storeTransaction.transactionIdentifier
    }

    var hasKnownTransactionIdentifier: Bool {
        storeTransaction.hasKnownTransactionIdentifier
    }

    var quantity: Int {
        storeTransaction.quantity
    }

    var jwsRepresentation: String? {
        storeTransaction.jwsRepresentation
    }

    var environment: StoreEnvironment? {
        storeTransaction.environment
    }
}
