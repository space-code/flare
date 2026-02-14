//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - StoreTransaction

/// A class represent a StoreKit transaction.
public final class StoreTransaction: Sendable {
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

// MARK: - Convenience Initializators

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
    public var originalID: UInt64? {
        storeTransaction.originalID
    }

    public var productIdentifier: String {
        storeTransaction.productIdentifier
    }

    public var purchaseDate: Date {
        storeTransaction.purchaseDate
    }

    public var hasKnownPurchaseDate: Bool {
        storeTransaction.hasKnownPurchaseDate
    }

    public var transactionIdentifier: String {
        storeTransaction.transactionIdentifier
    }

    public var hasKnownTransactionIdentifier: Bool {
        storeTransaction.hasKnownTransactionIdentifier
    }

    public var quantity: Int {
        storeTransaction.quantity
    }

    public var jwsRepresentation: String? {
        storeTransaction.jwsRepresentation
    }

    var environment: StoreEnvironment? {
        storeTransaction.environment
    }

    var price: Decimal? {
        storeTransaction.price
    }

    var currency: String? {
        storeTransaction.currency
    }
}

// MARK: Equatable

extension StoreTransaction: Equatable {
    public static func == (lhs: StoreTransaction, rhs: StoreTransaction) -> Bool {
        lhs.transactionIdentifier == rhs.transactionIdentifier
    }
}
