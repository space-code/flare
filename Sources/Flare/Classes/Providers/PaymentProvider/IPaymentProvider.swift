//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

/// Payment provider.
public protocol IPaymentProvider: AnyObject {
    /// False if this device is not able or allowed to make payments
    var canMakePayments: Bool { get }

    /// Payment transactions.
    var transactions: [PaymentTransaction] { get }

    /// The transactions array will only be synchronized with the server while the queue has observers.
    /// This may require that the user authenticate.
    func addTransactionObserver()
    /// The transactions array will only be synchronized with the server while the queue has observers.
    /// This may require that the user authenticate.
    func removeTransactionObserver()

    /// Will add completed transactions for the current user back to the queue to be re-completed.
    /// User will be asked to authenticate.
    ///
    /// - Parameter handler: A restore handler.
    func restoreCompletedTransactions(handler: @escaping RestoreHandler)

    /// Add a payment to the server queue.
    ///
    /// - Parameters:
    ///   - payment: A payment object identifies a product and the quantity of those items the user would like to purchase.
    ///   - handler: A payment handler.
    func add(payment: SKPayment, handler: @escaping PaymentHandler)

    /// Add handler to the payment with specific id.
    ///
    /// - Parameters:
    ///   - withProductIdentifier: Product identifier.
    ///   - handler: A payment handler.
    func addPaymentHandler(withProductIdentifier: String, handler: @escaping PaymentHandler)

    /// Add App Store payment handler.
    func set(shouldAddStorePaymentHandler: @escaping ShouldAddStorePaymentHandler)

    /// Common handler for transactions that don't have a dedicated payment handler.
    ///
    /// - Parameter fallbackHandler: A payment handler.
    func set(fallbackHandler: @escaping PaymentHandler)

    /// Remove a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameter transaction: An object in the payment queue.
    func finish(transaction: PaymentTransaction)
}
