//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Concurrency
import StoreKit

// MARK: - PaymentProvider

/// A class provides functionality to make payments.
final class PaymentProvider: NSObject {
    // MARK: Properties

    /// The queue of payment transactions to be processed by the App Store.
    private let paymentQueue: PaymentQueue
    /// Dictionary to store payment handlers associated with transaction identifiers.
    private var paymentHandlers: [String: [PaymentHandler]] = [:]
    /// Array to store restore handlers for completed transactions.
    private var restoreHandlers: [RestoreHandler] = []
    /// Optional fallback handler for handling payments if no specific handler is found.
    private var fallbackHandler: PaymentHandler?
    /// Optional handler to determine whether to add a payment to the App Store.
    private var shouldAddStorePaymentHandler: ShouldAddStorePaymentHandler?
    /// The dispatch queue factory for handling concurrent tasks.
    private var dispatchQueueFactory: IDispatchQueueFactory

    /// Lazy-initialized private dispatch queue for handling tasks related to payment processing.
    private lazy var privateQueue: IDispatchQueue = dispatchQueueFactory.privateQueue(label: String(describing: self))

    // MARK: Initialization

    /// Creates a new `PaymentProvider` instance.
    ///
    /// - Parameters:
    ///   - paymentQueue: The queue of payment transactions to be processed by the App Store.
    ///   - dispatchQueueFactory: The dispatch queue factory.
    init(
        paymentQueue: PaymentQueue,
        dispatchQueueFactory: IDispatchQueueFactory
    ) {
        self.paymentQueue = paymentQueue
        self.dispatchQueueFactory = dispatchQueueFactory
    }
}

// MARK: IPaymentProvider

extension PaymentProvider: IPaymentProvider {
    var canMakePayments: Bool {
        paymentQueue.canMakePayments
    }

    func addTransactionObserver() {
        paymentQueue.add(self)
    }

    func removeTransactionObserver() {
        paymentQueue.remove(self)
    }

    func add(payment: SKPayment, handler: @escaping PaymentHandler) {
        addPaymentHandler(productID: payment.productIdentifier, handler: handler)
        dispatchQueueFactory.main().async {
            self.paymentQueue.add(payment)

            Logger.info(
                message: L10n.Payment.paymentQueueAddingPayment(
                    payment.productIdentifier,
                    self.paymentQueue.transactions.count
                )
            )
        }
    }

    func addPaymentHandler(productID: String, handler: @escaping PaymentHandler) {
        privateQueue.async {
            var handlers: [PaymentHandler] = self.paymentHandlers[productID] ?? []
            handlers.append(handler)
            self.paymentHandlers[productID] = handlers
        }
    }

    func restoreCompletedTransactions(handler: @escaping RestoreHandler) {
        privateQueue.async {
            self.restoreHandlers.append(handler)
            self.dispatchQueueFactory.main().async {
                self.paymentQueue.restoreCompletedTransactions()
            }
        }
    }

    func set(fallbackHandler: @escaping PaymentHandler) {
        privateQueue.async {
            self.fallbackHandler = fallbackHandler
        }
    }

    func set(shouldAddStorePaymentHandler: @escaping ShouldAddStorePaymentHandler) {
        self.shouldAddStorePaymentHandler = shouldAddStorePaymentHandler
    }
}

// MARK: SKPaymentTransactionObserver

extension PaymentProvider: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                continue
            case .deferred:
                break
            case .purchased:
                break
            case .failed, .restored:
                queue.finishTransaction(transaction)
            @unknown default:
                continue
            }
            privateQueue.async { [weak self] in
                guard let self = self else { return }

                if let handlers = self.paymentHandlers.removeValue(
                    forKey: transaction.payment.productIdentifier
                ), !handlers.isEmpty {
                    self.dispatchQueueFactory.main().async {
                        if let error = transaction.error {
                            handlers.forEach { $0(queue, .failure(IAPError(error: error))) }
                        } else {
                            handlers.forEach { $0(queue, .success(transaction)) }
                        }
                    }
                } else {
                    let handler = self.fallbackHandler
                    self.dispatchQueueFactory.main().async {
                        if let error = transaction.error {
                            handler?(queue, .failure(IAPError(error: error)))
                        } else {
                            handler?(queue, .success(transaction))
                        }
                    }
                }
            }
        }
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        privateQueue.async {
            let handlers = self.restoreHandlers
            self.restoreHandlers = []
            self.dispatchQueueFactory.main().async {
                handlers.forEach { $0(queue, nil) }
            }
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        privateQueue.async {
            let handlers = self.restoreHandlers
            self.restoreHandlers = []
            self.dispatchQueueFactory.main().async {
                handlers.forEach { $0(queue, IAPError(error: error)) }
            }
        }
    }

    #if os(iOS) || os(tvOS) || os(macOS)
        func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
            shouldAddStorePaymentHandler?(queue, payment, product) ?? false
        }
    #endif

    func finish(transaction: PaymentTransaction) {
        Logger.info(
            message: L10n.Purchase.finishingTransaction(
                transaction.transactionIdentifier ?? "",
                transaction.productIdentifier
            )
        )

        paymentQueue.finishTransaction(transaction.skTransaction)
    }

    var transactions: [PaymentTransaction] {
        paymentQueue.transactions.map(PaymentTransaction.init(_:))
    }
}
