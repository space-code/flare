//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import TestConcurrency
import XCTest

private extension String {
    static let productId = "product_identifier"
}

// MARK: - PaymentProviderTests

class PaymentProviderTests: XCTestCase {
    // MARK: - Properties

    private var testDispatchQueue: TestDispatchQueue!
    private var dispatchQueueFactory: TestDispatchQueueFactory!
    private var paymentQueueMock: PaymentQueueMock!
    private var paymentProvider: PaymentProvider!

    private var transactionsStates: [SKPaymentTransactionState] {
        [.purchased, .deferred, .failed, .restored, .purchasing]
    }

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        testDispatchQueue = TestDispatchQueue()
        dispatchQueueFactory = TestDispatchQueueFactory(testQueue: testDispatchQueue)
        paymentQueueMock = PaymentQueueMock()
        paymentProvider = PaymentProvider(
            paymentQueue: paymentQueueMock,
            dispatchQueueFactory: dispatchQueueFactory
        )
    }

    override func tearDown() {
        paymentQueueMock = nil
        paymentProvider = nil
        testDispatchQueue = nil
        dispatchQueueFactory = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testThatPaymentProviderCanMakePayments() {
        // given
        paymentQueueMock.stubbedCanMakePayments = true

        // then
        XCTAssertTrue(paymentProvider.canMakePayments)
    }

    func testThatPaymentProviderAddTransactionObserver() throws {
        // when
        paymentProvider.addTransactionObserver()

        // then
        let observer = try XCTUnwrap(paymentQueueMock.invokedAddParametersList.first)
        XCTAssertTrue(observer.0 === paymentProvider)
    }

    func testThatPaymentProviderRemoveTransactionObserver() throws {
        // given
        paymentProvider.addTransactionObserver()

        // when
        paymentProvider.removeTransactionObserver()

        // then
        let observer = try XCTUnwrap(paymentQueueMock.invokedRemoveParametersList.first)
        XCTAssertTrue(paymentQueueMock.invokedRemove)
        XCTAssertEqual(paymentQueueMock.invokedRemoveCount, 1)
        XCTAssertTrue(observer.0 === paymentProvider)
    }

    func testThatPaymentProviderRestoreCompletedTransactions() {
        // given
        let restoreHandler: RestoreHandler = { _, _ in }

        // when
        paymentProvider.restoreCompletedTransactions(handler: restoreHandler)

        // then
        XCTAssertTrue(paymentQueueMock.invokedRestoreCompletedTransactions)
        XCTAssertEqual(paymentQueueMock.invokedRestoreCompletedTransactionsCount, 1)
    }

    func testThatPaymentProviderAddPaymentToQueueWithTransactions() {
        // given
        var handledPaymentQueue: PaymentQueue?
        let product = SKProduct()
        let payment = SKPayment(product: product)
        let paymentQueue = SKPaymentQueue()
        let paymentHandler: PaymentHandler = { payment, _ in handledPaymentQueue = payment }
        let paymentTransactions = transactionsStates.map { PurchaseManagerTestHelper.makePaymentTransaction(state: $0) }

        // when
        paymentProvider.add(payment: payment, handler: paymentHandler)
        paymentProvider.paymentQueue(paymentQueue, updatedTransactions: paymentTransactions)

        // then
        XCTAssertTrue(paymentQueueMock.invokedAddPayment)
        XCTAssertEqual(paymentQueueMock.invokedAddPaymentCount, 1)
        XCTAssertTrue(handledPaymentQueue === paymentQueue)
    }

    func testThatPaymentProviderAddPaymentToQueueWithoutTransactions() {
        // given
        var handledPaymentQueue: PaymentQueue?
        let product = SKProduct()
        let payment = SKPayment(product: product)
        let paymentQueue = SKPaymentQueue()
        let paymentHandler: PaymentHandler = { payment, _ in handledPaymentQueue = payment }

        // when
        paymentProvider.add(payment: payment, handler: paymentHandler)
        paymentProvider.paymentQueue(paymentQueue, updatedTransactions: [])

        // then
        XCTAssertTrue(paymentQueueMock.invokedAddPayment)
        XCTAssertEqual(paymentQueueMock.invokedAddPaymentCount, 1)
        XCTAssertNil(handledPaymentQueue)
    }

    func testThatPaymentProviderAddPaymentHandler() {
        // given
        var handledPaymentQueue: PaymentQueue?
        let paymentQueue = SKPaymentQueue()
        let paymentHandler: PaymentHandler = { payment, _ in handledPaymentQueue = payment }
        let paymentTransactions = transactionsStates
            .map { PurchaseManagerTestHelper.makePaymentTransaction(identifier: .productId, state: $0) }

        // when
        paymentProvider.addPaymentHandler(withProductIdentifier: .productId, handler: paymentHandler)
        paymentProvider.paymentQueue(paymentQueue, updatedTransactions: paymentTransactions)

        // then
        XCTAssertTrue(handledPaymentQueue === paymentQueue)
    }

    func testThatPaymentProviderCallFinishTransaction() {
        // given
        let transactions = transactionsStates.map { PurchaseManagerTestHelper.makePaymentTransaction(state: $0) }

        // when
        paymentProvider.paymentQueue(paymentQueueMock, updatedTransactions: transactions)

        // then
        XCTAssertTrue(paymentQueueMock.invokedFinishTransaction)
        XCTAssertEqual(paymentQueueMock.invokedFinishTransactionCount, 2)
    }

    func testThatPaymentProviderCallFallbackHandlerWhenPaymentHandlersDontExist() {
        // given
        var handledPaymentQueue: PaymentQueue?
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)
        let fallbackHandler: PaymentHandler = { paymentQueue, _ in handledPaymentQueue = paymentQueue }

        // when
        paymentProvider.set(fallbackHandler: fallbackHandler)
        paymentProvider.paymentQueue(paymentQueueMock, updatedTransactions: [transaction])

        // then
        XCTAssertTrue(handledPaymentQueue === paymentQueueMock)
    }

    func testThatPaymentProviderAddAppStoreHandler() {
        // given
        let payment = SKPayment()
        let product = SKProduct()

        var invokedQueue: PaymentQueue?
        var invokedPayment: SKPayment?
        var invokedProduct: SKProduct?

        let shouldAddStorePaymentHandler: ShouldAddStorePaymentHandler = { queue, payment, product in
            invokedQueue = queue
            invokedPayment = payment
            invokedProduct = product
            return true
        }

        // when
        paymentProvider.set(shouldAddStorePaymentHandler: shouldAddStorePaymentHandler)
        let result = paymentProvider.paymentQueue(paymentQueueMock, shouldAddStorePayment: payment, for: product)

        // then
        XCTAssertTrue(paymentQueueMock === invokedQueue)
        XCTAssertEqual(product, invokedProduct)
        XCTAssertEqual(payment, invokedPayment)
        XCTAssertTrue(result)
    }

    func testThatPaymentQueueFinishTransaction() {
        // given
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)

        // when
        paymentProvider.finish(transaction: PaymentTransaction(transaction))

        // then
        XCTAssertEqual(paymentQueueMock.invokedFinishTransactionParametersList.first?.0, transaction)
    }
}
