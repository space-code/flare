//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import StoreKitTest
import XCTest

// MARK: - PurchaseProviderTests

final class PurchaseProviderTests: XCTestCase {
    // MARK: Properties

    private var paymentQueueMock: PaymentQueueMock!
    private var paymentProviderMock: PaymentProviderMock!

    private var sut: PurchaseProvider!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        paymentQueueMock = PaymentQueueMock()
        paymentProviderMock = PaymentProviderMock()
        sut = PurchaseProvider(
            paymentProvider: paymentProviderMock,
            configurationProvider: ConfigurationProviderMock()
        )
    }

    override func tearDown() {
        paymentQueueMock = nil
        paymentProviderMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatPurchaseProviderReturnsPaymentTransaction_whenSK1ProductExist() {
        // given
        let productMock = StoreProduct(skProduct: ProductMock())

        paymentProviderMock.stubbedAddResult = (paymentQueueMock, .success(SKPaymentTransaction()))

        // when
        sut.purchase(product: productMock) { result in
            if case let .success(transaction) = result {
                XCTAssertEqual(transaction.productIdentifier, productMock.productIdentifier)
            } else {
                XCTFail("The products' ids must be equal")
            }
        }
    }

    func test_thatPurchaseProviderFinishesTransaction() {
        // given
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)

        // when
        sut.finish(transaction: StoreTransaction(paymentTransaction: PaymentTransaction(transaction)), completion: nil)

        // then
        XCTAssertTrue(paymentProviderMock.invokedFinishTransaction)
    }

    func test_thatPurchaseProviderAddsTransactionObserver_whenPaymentDidSuccess() {
        // given
        let paymentTransactionMock = SKPaymentTransaction()
        paymentProviderMock.stubbedFallbackHandlerResult = (paymentQueueMock, .success(paymentTransactionMock))

        // when
        sut.addTransactionObserver(fallbackHandler: { result in
            if case let .success(transaction) = result {
                XCTAssertTrue(transaction.productIdentifier.isEmpty)
            } else {
                XCTFail("The products' ids must be equal")
            }
        })
    }

    func test_thatPurchaseProviderThrowsAnError_whenTransactionObserverDidFail() {
        // given
        paymentProviderMock.stubbedFallbackHandlerResult = (paymentQueueMock, .failure(IAPError.unknown))

        // when
        sut.addTransactionObserver(fallbackHandler: { result in
            if case let .failure(error) = result {
                XCTAssertEqual(error, .unknown)
            } else {
                XCTFail("The errors' types must be equal")
            }
        })
    }

    func test_thatIAPProviderRemovesTransactionObserver() {
        // when
        sut.removeTransactionObserver()

        // then
        XCTAssertTrue(paymentProviderMock.invokedRemoveTransactionObserver)
    }
}
