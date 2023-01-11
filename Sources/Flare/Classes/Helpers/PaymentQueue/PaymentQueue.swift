//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

/// `PaymentQueue` interacts with the server-side payment queue
public protocol PaymentQueue: AnyObject {
    /// `False` if this device is not able or allowed to make payments
    var canMakePayments: Bool { get }
    /// Payment transactions.
    var transactions: [SKPaymentTransaction] { get }

    /// The transactions array will only be synchronized with the server while the queue has observers.
    /// This may require that the user authenticate.
    func add(_ observer: SKPaymentTransactionObserver)
    /// The transactions array will only be synchronized with the server while the queue has observers.
    /// This may require that the user authenticate.
    func remove(_ observer: SKPaymentTransactionObserver)

    /// Add a payment to the server queue.  The payment is copied to add an SKPaymentTransaction to the transactions array.
    /// The same payment can be added multiple times to create multiple transactions.
    func add(_ payment: SKPayment)
    /// Will add completed transactions for the current user back to the queue to be re-completed.
    /// User will be asked to authenticate.  Observers will receive 0 or more -paymentQueue:updatedTransactions:,
    ///  followed by either -paymentQueueRestoreCompletedTransactionsFinished: on success or
    ///  -paymentQueue:restoreCompletedTransactionsFailedWithError: on failure.  In the case of partial success,
    ///  some transactions may still be delivered.
    func restoreCompletedTransactions()

    /// Remove a finished (i.e. failed or completed) transaction from the queue.
    /// Attempting to finish a purchasing transaction will throw an exception.
    func finishTransaction(_ transaction: SKPaymentTransaction)
}
