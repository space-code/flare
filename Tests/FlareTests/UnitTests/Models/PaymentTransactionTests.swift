//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import FlareMock
import struct StoreKit.SKError
import class StoreKit.SKPaymentTransaction
import enum StoreKit.SKPaymentTransactionState
import XCTest

final class PaymentTransactionTests: XCTestCase {
    func test_thatTransactionHasTransactionIdentifierEqualsToSKPaymentTransactionIdentifier() {
        // given
        let skPaymentTransaction = SKPaymentTransaction()
        let paymentTransaction = PaymentTransaction(skPaymentTransaction)

        // when
        let identifier = paymentTransaction.transactionIdentifier

        // then
        XCTAssertEqual(identifier, skPaymentTransaction.transactionIdentifier)
    }

    func test_thatTransactionHasOriginalTransactionIdentifierEqualsToSKPaymentOriginalTransactionIdentifier() {
        // given
        let skPaymentTransaction = SKPaymentTransaction()
        let paymentTransaction = PaymentTransaction(skPaymentTransaction)

        // when
        let identifier = paymentTransaction.originalTransactionIdentifier

        // then
        XCTAssertEqual(identifier, skPaymentTransaction.original?.transactionIdentifier)
    }

    func test_thatTransactionHasProductIdentifierEqualsToSKPaymentProductIdentifier() {
        // given
        let skPaymentTransaction = SKPaymentTransaction()
        let paymentTransaction = PaymentTransaction(skPaymentTransaction)

        // when
        let identifier = paymentTransaction.productIdentifier

        // then
        XCTAssertEqual(identifier, skPaymentTransaction.payment.productIdentifier)
    }

    func test_thatTransactionHasTransactionStateEqualsToDeffered() {
        test_transactionState(stubbedState: .deferred, expectedState: .deferred)
    }

    func test_thatTransactionHasTransactionStateEqualsToFailed() {
        test_transactionState(stubbedState: .failed, expectedState: .failed)
    }

    func test_thatTransactionHasTransactionStateEqualsToPurchased() {
        test_transactionState(stubbedState: .purchased, expectedState: .purchased)
    }

    func test_thatTransactionHasTransactionStateEqualsToPurchasing() {
        test_transactionState(stubbedState: .purchasing, expectedState: .purchasing)
    }

    func test_thatTransactionHasTransactionStateEqualsToRestored() {
        test_transactionState(stubbedState: .restored, expectedState: .restored)
    }

    func test_thatTransactionHasOriginalTransactionEqualsToSKPaymentTransaction() {
        // given
        let originalTransactionMock = PaymentTransactionMock()
        let skPaymentTransaction = PaymentTransactionMock()
        skPaymentTransaction.stubbedOriginal = originalTransactionMock

        let paymentTransaction = PaymentTransaction(skPaymentTransaction)

        // when
        let originalTransaction = paymentTransaction.original

        // then
        XCTAssertTrue(originalTransaction?.skTransaction === originalTransactionMock)
    }

    func test_thatTransactionHasErrorEqualsToSKPaymentTransactionError() {
        // given
        let skPaymentTransaction = PaymentTransactionMock()
        skPaymentTransaction.stubbedError = IAPError.unknown
        let paymentTransaction = PaymentTransaction(skPaymentTransaction)

        // when
        let error = paymentTransaction.error

        // then
        XCTAssertEqual(error as? NSError, IAPError.unknown as NSError)
    }

    func test_thatTransactionWrappsErrorIntoIAPError_whenErrorIsSKError() {
        // given
        let errorMock = SKError(SKError.clientInvalid)
        let skPaymentTransaction = PaymentTransactionMock()
        skPaymentTransaction.stubbedError = errorMock
        let paymentTransaction = PaymentTransaction(skPaymentTransaction)

        // when
        let error = paymentTransaction.error as? IAPError

        // then
        if let error = error, case let IAPError.with(error) = error {
            XCTAssertEqual(error as? SKError, errorMock)
        } else {
            XCTFail("Errors must be equal.")
        }
    }

    func test_thatTransactionMarksAsCancelled_whenOriginalPaymentTransactionIsCancelled() {
        // given
        let skPaymentTransaction = PaymentTransactionMock()
        skPaymentTransaction.stubbedError = SKError(SKError.Code.paymentCancelled)

        let paymentTransaction = PaymentTransaction(skPaymentTransaction)

        // when
        let isCancelled = paymentTransaction.isCancelled

        // then
        XCTAssertTrue(isCancelled)
    }

    // MARK: Private

    private func test_transactionState(stubbedState: SKPaymentTransactionState, expectedState: PaymentTransaction.State) {
        // given
        let skPaymentTransaction = PaymentTransactionMock()
        skPaymentTransaction.stubbedTransactionState = stubbedState

        let paymentTransaction = PaymentTransaction(skPaymentTransaction)

        // when
        let state = paymentTransaction.state

        // then
        XCTAssertEqual(state, expectedState)
    }
}
