//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import XCTest

class FlareTests: XCTestCase {
    // MARK: - Properties

    private var iapProviderMock: IAPProviderMock!
    private var flare: Flare!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        iapProviderMock = IAPProviderMock()
        flare = Flare(iapProvider: iapProviderMock)
    }

    override func tearDown() {
        iapProviderMock = nil
        flare = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testThatPurchaseManagerFetchProducts() {
        // given
        let ids = Set<String>(arrayLiteral: "1", "2", "3")

        // when
        flare.fetch(ids: ids, completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedFetch)
    }

    func testThatPurchaseManagerBuyProductWhenCanMakePayments() {
        // given
        let productId = "product_identifier"
        iapProviderMock.stubbedCanMakePayments = true

        // when
        flare.buy(id: productId, completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedPurchase)
        XCTAssertEqual(iapProviderMock.invokedPurchaseParameters?.productId, productId)
    }

    func testThatPurchaseManagerDontBuyProductWhenCannotMakePayments() {
        // given
        let productId = "product_identifier"
        iapProviderMock.stubbedCanMakePayments = false

        // when
        flare.buy(id: productId, completion: { _ in })

        // then
        XCTAssertFalse(iapProviderMock.invokedPurchase)
    }

    func testThatPurchaseManagerFetchReceipt() {
        // when
        flare.receipt(completion: { _ in })

        // then
        XCTAssertTrue(iapProviderMock.invokedRefreshReceipt)
    }

    func testThatPurchaseManagerRemoveTransactionObserver() {
        // when
        flare.removeTransactionObserver()

        // then
        XCTAssertTrue(iapProviderMock.invokedRemoveTransactionObserver)
    }
}
