//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import FlareMock
@testable import FlareUI
import XCTest

final class ProductStrategyTests: XCTestCase {
    // MARK: Properties

    private var iapMock: FlareMock!

    private var sut: ProductStrategy!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        iapMock = FlareMock()
    }

    override func tearDown() {
        iapMock = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_strategyReturnsProduct() async throws {
        // given
        let productFake = StoreProduct.fake()
        let sut = prepareSut(type: .product(productFake))

        // when
        let product = try await sut.product()

        // then
        XCTAssertEqual(product, productFake)
        XCTAssertEqual(iapMock.invokedFetchCount, 0)
    }

    func test_strategyFetchesProduct() async throws {
        // given
        let productFake = StoreProduct.fake()
        iapMock.stubbedInvokedFetch = [productFake]

        let sut = prepareSut(type: .productID(productFake.productIdentifier))

        // when
        let product = try await sut.product()

        // then
        XCTAssertEqual(product, productFake)
        XCTAssertEqual(iapMock.invokedFetchCount, 1)
    }

    // MARK: Private

    private func prepareSut(type: ProductViewType) -> ProductStrategy {
        ProductStrategy(type: type, iap: iapMock)
    }
}
