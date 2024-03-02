//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import FlareMock
import StoreKit

enum PurchaseManagerTestHelper {
    static func makeRequest(with identifier: String) -> SKProductsRequest {
        let request = ProductsRequestMock()
        request.id = identifier
        return request
    }

    static func makePaymentTransaction(identifier: String? = nil, state: SKPaymentTransactionState) -> SKPaymentTransaction {
        let payment = makePayment(with: identifier ?? "")
        let paymentTransaction = PaymentTransactionMock()
        paymentTransaction.stubbedPayment = payment
        paymentTransaction.stubbedTransactionIndentifier = identifier
        paymentTransaction.stubbedTransactionState = state
        return paymentTransaction
    }

    static func makeProduct(with productIdentifier: String) -> SKProduct {
        let product = ProductMock()
        product.stubbedProductIdentifier = productIdentifier
        return product
    }

    static func makePayment(with productIdentifier: String) -> SKPayment {
        let product = makeProduct(with: productIdentifier)
        return SKPayment(product: product)
    }
}
