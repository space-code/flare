//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import XCTest

private extension String {
    static let productId = "product_identifier"
}

private extension Set where Element == String {
    static let productIds: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}

// MARK: - IAPProviderTests

class IAPProviderTests: XCTestCase {
    // MARK: - Properties

    private var paymentQueueMock: PaymentQueueMock!
    private var productProviderMock: ProductProviderMock!
    private var paymentProviderMock: PaymentProviderMock!
    private var receiptRefreshProviderMock: ReceiptRefreshProviderMock!
    private var iapProvider: IIAPProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        paymentQueueMock = PaymentQueueMock()
        productProviderMock = ProductProviderMock()
        paymentProviderMock = PaymentProviderMock()
        receiptRefreshProviderMock = ReceiptRefreshProviderMock()
        iapProvider = IAPProvider(
            paymentQueue: paymentQueueMock,
            productProvider: productProviderMock,
            paymentProvider: paymentProviderMock,
            receiptRefreshProvider: receiptRefreshProviderMock
        )
    }

    override func tearDown() {
        paymentQueueMock = nil
        productProviderMock = nil
        paymentProviderMock = nil
        receiptRefreshProviderMock = nil
        iapProvider = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testThatIAPProviderCanMakePayments() {
        // given
        paymentQueueMock.stubbedCanMakePayments = true

        // then
        XCTAssertTrue(iapProvider.canMakePayments)
    }

    func testThatIAPProviderFetchProducts() throws {
        // given

        // when
        iapProvider.fetch(productsIds: .productIds, completion: { _ in })

        // then
        let parameters = try XCTUnwrap(productProviderMock.invokedFetchParameters)
        XCTAssertEqual(parameters.productIds, .productIds)
        XCTAssertTrue(!parameters.requestId.isEmpty)
    }

    func testThatIAPProviderPurchaseProduct() throws {
        // given

        // when
        iapProvider.purchase(productId: .productId, completion: { _ in })

        // then
        XCTAssertTrue(productProviderMock.invokedFetch)
    }

    func testThatIAPProviderRefreshReceipt() {
        // when
        iapProvider.refreshReceipt(completion: { _ in })

        // then
        XCTAssertTrue(receiptRefreshProviderMock.invokedRefresh)
    }

    func testThatIAPProviderFinishTransaction() {
        // given
        let transaction = PurchaseManagerTestHelper.makePaymentTransaction(state: .purchased)

        // when
        iapProvider.finish(transaction: PaymentTransaction(transaction))

        // then
        XCTAssertTrue(paymentProviderMock.invokedFinishTransaction)
    }

    func testThatIAPProviderAddTransactionObserver() {
        // when
        iapProvider.addTransactionObserver(fallbackHandler: { _ in })

        // then
        XCTAssertTrue(paymentProviderMock.invokedFallbackHandler)
        XCTAssertTrue(paymentProviderMock.invokedAddTransactionObserver)
    }

    func testThatIAPProviderRemoveTransactionObserver() {
        // when
        iapProvider.removeTransactionObserver()

        // then
        XCTAssertTrue(paymentProviderMock.invokedRemoveTransactionObserver)
    }
}
