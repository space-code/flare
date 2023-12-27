//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import StoreKitTest
import XCTest

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
            paymentProvider: paymentProviderMock
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

//    #if os(iOS)
//    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
//    func test_thatPurchaseProviderReturnsPaymentTransaction_whenSK2ProductExist() async throws {
//        guard #available(iOS 17.0, *) else {
//            throw XCTSkip("This test is currently working only on iOS 17")
//        }
//
//        // given
    ////        let url = Bundle.module.url(forResource: "Flare", withExtension: "storekit")!
//        let session = try SKTestSession(configurationFileNamed: "Flare")
//        session.disableDialogs = true
//        session.clearTransactions()
//
    ////        try await session.buyProduct(productIdentifier: ProductProviderHelper.all[0].id)
//
//        let expectation = XCTestExpectation(description: "Purchase a product")
//        let productMock = StoreProduct(product: try await ProductProviderHelper.all[0])
//
//        // when
//        sut.purchase(product: productMock) { result in
//            switch result {
//            case let .success(transaction):
//                XCTAssertEqual(transaction.productIdentifier, productMock.productIdentifier)
//                expectation.fulfill()
//            case let .failure(error):
//                print(error)
//            }
//        }
//
//        wait(for: [expectation], timeout: 2.0)
//    }
//    #endif

    func test_thatPurchaseProviderFinishesTransaction() {
        // given
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)

        // when
        sut.finish(transaction: PaymentTransaction(transaction))

        // then
        XCTAssertTrue(paymentProviderMock.invokedFinishTransaction)
    }

    func test_thatPurchaseProviderAddsTransactionObserver_when() {
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
