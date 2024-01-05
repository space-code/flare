//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import Foundation
import StoreKit

final class PaymentQueueMock: SKPaymentQueue {
    var invokedCanMakePayments = false
    var invokedCanMakePaymentsCount = 0
    var stubbedCanMakePayments = false

    override var canMakePayments: Bool {
        invokedCanMakePayments = true
        invokedCanMakePaymentsCount += 1
        return stubbedCanMakePayments
    }

    var invokedTransactions = false
    var invokedTransactionsCount = 0
    var stubbedTransactions: [SKPaymentTransaction] = []

    override var transactions: [SKPaymentTransaction] {
        invokedTransactions = true
        invokedTransactionsCount += 1
        return stubbedTransactions
    }

    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (SKPaymentTransactionObserver, Void)?
    var invokedAddParametersList = [(SKPaymentTransactionObserver, Void)]()

    override func add(_ observer: SKPaymentTransactionObserver) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (observer, ())
        invokedAddParametersList.append((observer, ()))
    }

    var invokedRemove = false
    var invokedRemoveCount = 0
    var invokedRemoveParameters: (SKPaymentTransactionObserver, Void)?
    var invokedRemoveParametersList = [(SKPaymentTransactionObserver, Void)]()

    override func remove(_ observer: SKPaymentTransactionObserver) {
        invokedRemove = true
        invokedRemoveCount += 1
        invokedRemoveParameters = (observer, ())
        invokedRemoveParametersList.append((observer, ()))
    }

    var invokedAddPayment = false
    var invokedAddPaymentCount = 0
    var invokedAddPaymentParameters: (SKPayment, Void)?
    var invokedAddPaymentParametersList = [(SKPayment, Void)]()

    override func add(_ payment: SKPayment) {
        invokedAddPayment = true
        invokedAddPaymentCount += 1
        invokedAddPaymentParameters = (payment, ())
        invokedAddPaymentParametersList.append((payment, ()))
    }

    var invokedRestoreCompletedTransactions = false
    var invokedRestoreCompletedTransactionsCount = 0

    override func restoreCompletedTransactions() {
        invokedRestoreCompletedTransactions = true
        invokedRestoreCompletedTransactionsCount += 1
    }

    var invokedFinishTransaction = false
    var invokedFinishTransactionCount = 0
    var invokedFinishTransactionParameters: (SKPaymentTransaction, Void)?
    var invokedFinishTransactionParametersList = [(SKPaymentTransaction, Void)]()

    override func finishTransaction(_ transaction: SKPaymentTransaction) {
        invokedFinishTransaction = true
        invokedFinishTransactionCount += 1
        invokedFinishTransactionParameters = (transaction, ())
        invokedFinishTransactionParametersList.append((transaction, ()))
    }
}
