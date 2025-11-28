//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

/// Type that provides payment functionality.
protocol IPaymentProvider: AnyObject {
    /// False if this device is not able or allowed to make payments
    var canMakePayments: Bool { get }

    /// The active payment transactinos.
    var transactions: [PaymentTransaction] { get }

    /// Adds transaction observer to a payment queue.
    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func addTransactionObserver()

    /// Removes transaction observer from a payment queue.
    /// The transactions array will only be synchronized with the server while the queue has observers.
    ///
    /// - Note: This may require that the user authenticate.
    func removeTransactionObserver()

    /// Restores completed transactions for the current user back to the queue for re-completion.
    ///
    /// - Note: A user will be asked to authenticate.
    ///
    /// - Parameter handler: A restore handler.
    func restoreCompletedTransactions(handler: @escaping RestoreHandler)

    /// Adds a payment to the payment queue.
    ///
    /// - Parameters:
    ///   - payment: The payment object identifies a product and specifies the quantity of
    ///              those items the user would like to purchase.
    ///   - handler: The closure to be executed once the purchase is complete.
    func add(payment: SKPayment, handler: @escaping PaymentHandler)

    /// Adds a handler to the payment queue with a specific ID.
    ///
    /// - Parameters:
    ///   - productID: The product identifier.
    ///   - handler: The closure to be executed once the purchase is complete.
    func addPaymentHandler(productID: String, handler: @escaping PaymentHandler)

    /// Adds an App Store payment handler to the system.
    func set(shouldAddStorePaymentHandler: @escaping ShouldAddStorePaymentHandler)

    /// Sets a common handler for transactions that do not have a dedicated payment handler.
    ///
    /// - Parameter fallbackHandler: The closure to be executed for all payments that don't have a dedicated payment handler.
    func set(fallbackHandler: @escaping PaymentHandler)

    /// Removes a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    ///
    /// - Parameter transaction: The payment transaction.
    func finish(transaction: PaymentTransaction)
}
