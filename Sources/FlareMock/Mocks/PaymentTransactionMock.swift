//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

public final class PaymentTransactionMock: SKPaymentTransaction, @unchecked Sendable {
    override public init() {}

    public var invokedTransactionState = false
    public var invokedTransactionStateCount = 0
    public var stubbedTransactionState: SKPaymentTransactionState!

    override public var transactionState: SKPaymentTransactionState {
        stubbedTransactionState
    }

    public var invokedTransactionIndentifier = false
    public var invokedTransactionIndentifierCount = 0
    public var stubbedTransactionIndentifier: String?

    override public var transactionIdentifier: String? {
        invokedTransactionIndentifier = true
        invokedTransactionStateCount += 1
        return stubbedTransactionIndentifier
    }

    public var invokedPayment = false
    public var invokedPaymentCount = 0
    public var stubbedPayment: SKPayment!

    override public var payment: SKPayment {
        invokedPayment = true
        invokedPaymentCount += 1
        return stubbedPayment
    }

    public var stubbedOriginal: SKPaymentTransaction?
    override public var original: SKPaymentTransaction? {
        stubbedOriginal
    }

    public var stubbedError: Error?
    override public var error: Error? {
        stubbedError
    }
}
