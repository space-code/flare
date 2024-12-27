//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

public struct PaymentTransaction: Equatable, Sendable {
    // MARK: Lifecycle

    init(_ skTransaction: SKPaymentTransaction) {
        self.skTransaction = skTransaction
    }

    // MARK: Public

    public enum State: Equatable {
        case purchasing
        case purchased
        case failed
        case restored
        case deferred
        case unknown(rawValue: Int)

        // MARK: Lifecycle

        init(_ skState: SKPaymentTransactionState) {
            switch skState {
            case .purchasing:
                self = .purchasing
            case .purchased:
                self = .purchased
            case .failed:
                self = .failed
            case .deferred:
                self = .deferred
            case .restored:
                self = .restored
            @unknown default:
                self = .unknown(rawValue: skState.rawValue)
            }
        }
    }

    /// A string that uniquely identifies a successful payment transaction.
    public var transactionIdentifier: String? {
        skTransaction.transactionIdentifier
    }

    /// A string that uniquely identifies a successful payment transaction.
    public var originalTransactionIdentifier: String? {
        skTransaction.original?.transactionIdentifier
    }

    /// A string used to identify a product that can be purchased from within your app.
    public var productIdentifier: String {
        skTransaction.payment.productIdentifier
    }

    public var state: State {
        PaymentTransaction.State(skTransaction.transactionState)
    }

    /// The transaction that was restored by the App Store.
    public var original: PaymentTransaction? {
        guard let original = skTransaction.original else {
            return nil
        }
        return .init(original)
    }

    /// An object describing the error that occurred while processing the transaction.
    public var error: Error? {
        if let skError = skTransaction.error as? SKError {
            return IAPError(error: skError)
        }
        return skTransaction.error
    }

    public var transactionDate: Date? {
        skTransaction.transactionDate
    }

    /// A `Bool` value indicating that the user canceled a payment request.
    public var isCancelled: Bool {
        (skTransaction.error as? SKError)?.code == SKError.Code.paymentCancelled
    }

    // MARK: Internal

    /// Original transaction object.
    let skTransaction: SKPaymentTransaction
}
