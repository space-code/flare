//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit

final class PaymentProviderMock: IPaymentProvider {
    var invokedCanMakePayments = false
    var invokedCanMakePaymentsCount = 0
    var stubbedCanMakePayments: Bool = false

    var canMakePayments: Bool {
        invokedCanMakePayments = true
        invokedCanMakePaymentsCount += 1
        return stubbedCanMakePayments
    }

    var invokedTransactions = false
    var invokedTransactionsCount = 0
    var stubbedTransactions: [PaymentTransaction] = []

    var transactions: [PaymentTransaction] {
        invokedTransactions = true
        invokedTransactionsCount += 1
        return stubbedTransactions
    }

    var invokedAddTransactionObserver = false
    var invokedAddTransactionObserverCount = 0

    func addTransactionObserver() {
        invokedAddTransactionObserver = true
        invokedAddTransactionObserverCount += 1
    }

    var invokedRemoveTransactionObserver = false
    var invokedRemoveTransactionObserverCount = 0

    func removeTransactionObserver() {
        invokedRemoveTransactionObserver = true
        invokedRemoveTransactionObserverCount += 1
    }

    var invokedRestoreCompletedTransactions = false
    var invokedRestoreCompletedTransactionsCount = 0
    var invokedRestoreCompletedTransactionsParameters: (RestoreHandler, Void)?
    var invokedRestoreCompletedTransactionsParametersList = [(RestoreHandler, Void)]()

    func restoreCompletedTransactions(handler: @escaping RestoreHandler) {
        invokedRestoreCompletedTransactions = true
        invokedRestoreCompletedTransactionsCount += 1
        invokedRestoreCompletedTransactionsParameters = (handler, ())
        invokedRestoreCompletedTransactionsParametersList.append((handler, ()))
    }

    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (payment: SKPayment, handler: PaymentHandler)?
    var invokedAddParametersList = [(payment: SKPayment, handler: PaymentHandler)]()

    func add(payment: SKPayment, handler: @escaping PaymentHandler) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (payment, handler)
        invokedAddParametersList.append((payment, handler))
    }

    var invokedAddPaymentHandler = false
    var invokedAddPaymentHandlerCount = 0
    var invokedAddPaymentHandlerParameters: (productIdentifier: String, handler: PaymentHandler)?
    var invokedAddPaymentHandlerParametersList = [(productIdentifier: String, handler: PaymentHandler)]()

    func addPaymentHandler(withProductIdentifier: String, handler: @escaping PaymentHandler) {
        invokedAddPaymentHandler = true
        invokedAddPaymentHandlerCount += 1
        invokedAddPaymentHandlerParameters = (withProductIdentifier, handler)
        invokedAddPaymentHandlerParametersList.append((withProductIdentifier, handler))
    }

    var invokedSetAddStorePaymentHandler = false
    var invokedSetAddStorePaymentHandlerCount = 0
    var invokedSetAddStorePaymentHandlerParameters: (ShouldAddStorePaymentHandler, Void)?
    var invokedSetAddStorePaymentHandlerParametersList = [(ShouldAddStorePaymentHandler, Void)]()

    func set(shouldAddStorePaymentHandler: @escaping ShouldAddStorePaymentHandler) {
        invokedSetAddStorePaymentHandler = true
        invokedSetAddStorePaymentHandlerCount += 1
        invokedSetAddStorePaymentHandlerParameters = (shouldAddStorePaymentHandler, ())
        invokedSetAddStorePaymentHandlerParametersList.append((shouldAddStorePaymentHandler, ()))
    }

    var invokedFallbackHandler = false
    var invokedFallbackHandlerCount = 0
    var invokedFallbackHandlerParameters: (PaymentHandler, Void)?
    var invokedFallbackHandlerParametersList = [(PaymentHandler, Void)]()

    func set(fallbackHandler: @escaping PaymentHandler) {
        invokedFallbackHandler = true
        invokedFallbackHandlerCount += 1
        invokedFallbackHandlerParameters = (fallbackHandler, ())
        invokedFallbackHandlerParametersList.append((fallbackHandler, ()))
    }

    var invokedFinishTransaction = false
    var invokedFinishTransactionCount = 0
    var invokedFinishTransactionParameters: (PaymentTransaction, Void)?
    var invokedFinishTransactionParanetersList = [(PaymentTransaction, Void)]()

    func finish(transaction: PaymentTransaction) {
        invokedFinishTransaction = true
        invokedFinishTransactionCount += 1
        invokedFinishTransactionParameters = (transaction, ())
        invokedFinishTransactionParanetersList.append((transaction, ()))
    }
}
