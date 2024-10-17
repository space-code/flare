//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
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

    func test_thatPaymentProviderCanMakePayments() {
        // given
        paymentQueueMock.stubbedCanMakePayments = true

        // then
        XCTAssertTrue(paymentProvider.canMakePayments)
    }

    func test_thatPaymentProviderAddsTransactionObserver() throws {
        // when
        paymentProvider.addTransactionObserver()

        // then
        let observer = try XCTUnwrap(paymentQueueMock.invokedAddParametersList.first)
        XCTAssertTrue(observer.0 === paymentProvider)
    }

    func test_thatPaymentProviderRemovesTransactionObserver() throws {
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

    func test_thatPaymentProviderRestoresCompletedTransactions() {
        // given
        let restoreHandler: RestoreHandler = { _, _ in }

        // when
        paymentProvider.restoreCompletedTransactions(handler: restoreHandler)

        // then
        XCTAssertTrue(paymentQueueMock.invokedRestoreCompletedTransactions)
        XCTAssertEqual(paymentQueueMock.invokedRestoreCompletedTransactionsCount, 1)
    }

    func test_thatPaymentProviderAddsPaymentToQueueWithTransactions() {
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

    func test_thatPaymentProviderAddsPaymentToQueueWithoutTransactions() {
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

    func test_thatPaymentProviderAddsPaymentHandler() {
        // given
        var handledPaymentQueue: PaymentQueue?
        let paymentQueue = SKPaymentQueue()
        let paymentHandler: PaymentHandler = { payment, _ in handledPaymentQueue = payment }
        let paymentTransactions = transactionsStates
            .map { PurchaseManagerTestHelper.makePaymentTransaction(identifier: .productId, state: $0) }

        // when
        paymentProvider.addPaymentHandler(productID: .productId, handler: paymentHandler)
        paymentProvider.paymentQueue(paymentQueue, updatedTransactions: paymentTransactions)

        // then
        XCTAssertTrue(handledPaymentQueue === paymentQueue)
    }

    func test_thatPaymentProviderCallsFinishTransaction() {
        // given
        let transactions = transactionsStates.map { PurchaseManagerTestHelper.makePaymentTransaction(state: $0) }

        // when
        paymentProvider.paymentQueue(paymentQueueMock, updatedTransactions: transactions)

        // then
        XCTAssertTrue(paymentQueueMock.invokedFinishTransaction)
        XCTAssertEqual(paymentQueueMock.invokedFinishTransactionCount, 2)
    }

    func test_thatPaymentProviderCallsFallbackHandler_whenPaymentHandlersDoNotExist() {
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

    #if os(iOS) || os(tvOS) || os(macOS)
        func test_thatPaymentProviderAddsAppStoreHandler() {
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
    #endif

    func test_thatPaymentQueueFinishesTransaction() {
        // given
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)

        // when
        paymentProvider.finish(transaction: PaymentTransaction(transaction))

        // then
        XCTAssertEqual(paymentQueueMock.invokedFinishTransactionParametersList.first?.0, transaction)
    }

    func test_thatPaymentQueueRestoresCompletedTransactions() {
        // when
        paymentProvider.restoreCompletedTransactions(handler: { _, _ in })

        // then
        XCTAssertTrue(paymentQueueMock.invokedRestoreCompletedTransactions)
    }

    func test_thatPaymentQueueRestoresCompletedTransactions_whenTransactionFinished() {
        // when
        var queueResult: SKPaymentQueue?
        var errorResult: Error?
        let restoreHandler: RestoreHandler = { queue, error in
            queueResult = queue
            errorResult = error
        }

        paymentProvider.restoreCompletedTransactions(handler: restoreHandler)
        paymentProvider.paymentQueueRestoreCompletedTransactionsFinished(paymentQueueMock)

        // then
        XCTAssertEqual(queueResult, paymentQueueMock)
        XCTAssertNil(errorResult)
    }

    func test_thatPaymentQueueDoesNotRestoreCompletedTransactions_whenRequestFailDueToTransactionError() {
        // given
        let errorMock = IAPError.paymentNotAllowed

        // when
        var queueResult: SKPaymentQueue?
        var errorResult: Error?
        let restoreHandler: RestoreHandler = { queue, error in
            queueResult = queue
            errorResult = error
        }

        paymentProvider.restoreCompletedTransactions(handler: restoreHandler)
        paymentProvider.paymentQueue(paymentQueueMock, restoreCompletedTransactionsFailedWithError: errorMock)

        // then
        XCTAssertEqual(queueResult, paymentQueueMock)
        XCTAssertEqual(errorResult as? NSError, IAPError(error: errorMock) as NSError)
    }

    func test_thatPaymentQueueHandlesTransactions_whenPendingTransactionsExist() {
        // given
        let transactionMocks = [SKPaymentTransaction(), SKPaymentTransaction(), SKPaymentTransaction()]
        paymentQueueMock.stubbedTransactions = transactionMocks

        // when
        let transactions = paymentProvider.transactions

        // then
        XCTAssertEqual(transactions, transactionMocks.map(PaymentTransaction.init))
    }
}
