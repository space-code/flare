//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Concurrency
import StoreKit

// MARK: - PaymentProvider

final class PaymentProvider: NSObject {
    // MARK: Properties

    private let paymentQueue: PaymentQueue
    private var paymentHandlers: [String: [PaymentHandler]] = [:]
    private var restoreHandlers: [RestoreHandler] = []
    private var fallbackHandler: PaymentHandler?
    private var shouldAddStorePaymentHandler: ShouldAddStorePaymentHandler?
    private var dispatchQueueFactory: IDispatchQueueFactory

    private lazy var privateQueue: IDispatchQueue = dispatchQueueFactory.privateQueue(label: String(describing: self))

    // MARK: Initialization

    init(
        paymentQueue: PaymentQueue = SKPaymentQueue.default(),
        dispatchQueueFactory: IDispatchQueueFactory = DispatchQueueFactory()
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
        addPaymentHandler(withProductIdentifier: payment.productIdentifier, handler: handler)
        dispatchQueueFactory.main().async {
            self.paymentQueue.add(payment)
        }
    }

    func addPaymentHandler(withProductIdentifier productIdentifier: String, handler: @escaping PaymentHandler) {
        privateQueue.async {
            var handlers: [PaymentHandler] = self.paymentHandlers[productIdentifier] ?? []
            handlers.append(handler)
            self.paymentHandlers[productIdentifier] = handlers
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
                guard let self = self else {
                    return
                }

                if let handlers = self.paymentHandlers.removeValue(forKey: transaction.payment.productIdentifier), !handlers.isEmpty {
                    self.dispatchQueueFactory.main().async {
                        handlers.forEach { $0(queue, .success(transaction)) }
                    }
                } else {
                    let handler = self.fallbackHandler
                    self.dispatchQueueFactory.main().async {
                        handler?(queue, .success(transaction))
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

    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        shouldAddStorePaymentHandler?(queue, payment, product) ?? false
    }

    func finish(transaction: PaymentTransaction) {
        paymentQueue.finishTransaction(transaction.skTransaction)
    }

    var transactions: [PaymentTransaction] {
        paymentQueue.transactions.map(PaymentTransaction.init(_:))
    }
}
