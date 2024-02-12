//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

final class PaymentTransactionMock: SKPaymentTransaction {
    var invokedTransactionState = false
    var invokedTransactionStateCount = 0
    var stubbedTransactionState: SKPaymentTransactionState!

    override var transactionState: SKPaymentTransactionState {
        stubbedTransactionState
    }

    var invokedTransactionIndentifier = false
    var invokedTransactionIndentifierCount = 0
    var stubbedTransactionIndentifier: String?

    override var transactionIdentifier: String? {
        invokedTransactionIndentifier = true
        invokedTransactionStateCount += 1
        return stubbedTransactionIndentifier
    }

    var invokedPayment = false
    var invokedPaymentCount = 0
    var stubbedPayment: SKPayment!

    override var payment: SKPayment {
        invokedPayment = true
        invokedPaymentCount += 1
        return stubbedPayment
    }

    var stubbedOriginal: SKPaymentTransaction?
    override var original: SKPaymentTransaction? {
        stubbedOriginal
    }

    var stubbedError: Error?
    override var error: Error? {
        stubbedError
    }
}
