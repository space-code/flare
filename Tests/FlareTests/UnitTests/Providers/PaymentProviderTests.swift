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

    func test_thatPaymentProviderAddsPaymentToQueueWithTransactions() async throws {
        // given
        let product = SKProduct()
        let payment = SKPayment(product: product)
        let paymentQueue = SKPaymentQueue()
        let paymentTransactions = transactionsStates.map { PurchaseManagerTestHelper.makePaymentTransaction(state: $0) }

        // when
        let handledPaymentQueue: PaymentQueue? = try await withCheckedThrowingContinuation { continuation in
            paymentProvider.add(payment: payment) { payment, _ in
                continuation.resume(returning: payment)
            }

            paymentProvider.paymentQueue(paymentQueue, updatedTransactions: paymentTransactions)
        }

        // then
        XCTAssertTrue(paymentQueueMock.invokedAddPayment)
        XCTAssertEqual(paymentQueueMock.invokedAddPaymentCount, 1)
        XCTAssertTrue(handledPaymentQueue === paymentQueue)
    }

    func test_thatPaymentProviderAddsPaymentHandler() async throws {
        // given
        let paymentQueue = SKPaymentQueue()
        let paymentTransactions = transactionsStates
            .map { PurchaseManagerTestHelper.makePaymentTransaction(identifier: .productId, state: $0) }

        // when
        let handledPaymentQueue: PaymentQueue? = try await withCheckedThrowingContinuation { continuation in
            paymentProvider.addPaymentHandler(productID: .productId) { payment, _ in
                continuation.resume(returning: payment)
            }

            paymentProvider.paymentQueue(paymentQueue, updatedTransactions: paymentTransactions)
        }

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

    func test_thatPaymentProviderCallsFallbackHandler_whenPaymentHandlersDoNotExist() async throws {
        // given
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)

        // when
        let handledPaymentQueue: PaymentQueue? = try await withCheckedThrowingContinuation { continuation in
            paymentProvider.set { payment, _ in
                continuation.resume(returning: payment)
            }

            paymentProvider.paymentQueue(paymentQueueMock, updatedTransactions: [transaction])
        }

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

    func test_thatPaymentQueueRestoresCompletedTransactions_whenTransactionFinished() async throws {
        // when
        let result: Result<SKPaymentQueue, Error>? = try await withCheckedThrowingContinuation { continuation in
            paymentProvider.restoreCompletedTransactions { queue, error in
                if let error {
                    continuation.resume(returning: .failure(error))
                } else {
                    continuation.resume(returning: .success(queue))
                }
            }

            paymentProvider.paymentQueueRestoreCompletedTransactionsFinished(paymentQueueMock)
        }

        // then
        XCTAssertEqual(result?.success, paymentQueueMock)
        XCTAssertNil(result?.error)
    }

    func test_thatPaymentQueueDoesNotRestoreCompletedTransactions_whenRequestFailDueToTransactionError() async throws {
        // given
        let errorMock = IAPError.paymentNotAllowed

        // when
        let result: (SKPaymentQueue?, Error?) = try await withCheckedThrowingContinuation { continuation in
            paymentProvider.restoreCompletedTransactions { queue, error in
                continuation.resume(returning: (queue, error))
            }

            paymentProvider.paymentQueue(paymentQueueMock, restoreCompletedTransactionsFailedWithError: errorMock)
        }

        // then
        XCTAssertEqual(result.0, paymentQueueMock)
        XCTAssertEqual(result.1 as? NSError, IAPError(error: errorMock) as NSError)
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
