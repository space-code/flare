//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import FlareMock
@testable import FlareUI
import XCTest

// MARK: - ProductViewModelFactoryTests

final class ProductViewModelFactoryTests: XCTestCase {
    // MARK: Properties

    private var subscriptionPriceViewModelFactoryMock: SubscriptionPriceViewModelFactoryMock!

    private var sut: ProductViewModelFactory!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        subscriptionPriceViewModelFactoryMock = SubscriptionPriceViewModelFactoryMock()
        sut = ProductViewModelFactory(
            subscriptionPriceViewModelFactory: subscriptionPriceViewModelFactoryMock
        )
    }

    override func tearDown() {
        subscriptionPriceViewModelFactoryMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatFactoryMakesAProduct_whenProductIsConsumable() {
        // given
        subscriptionPriceViewModelFactoryMock.stubbedMakeResult = .price

        let product: StoreProduct = .fake(localizedPriceString: .price, productType: .consumable)

        // when
        let viewModel = sut.make(product, style: .compact)

        // then
        XCTAssertEqual(viewModel.id, product.productIdentifier)
        XCTAssertEqual(viewModel.title, product.localizedTitle)
        XCTAssertEqual(viewModel.description, product.localizedDescription)
        XCTAssertEqual(viewModel.price, product.localizedPriceString)
    }

    func test_thatFactoryMakesProductWithCompactStyle_whenProductTypeIsRenewableSubscription() {
        // given
        subscriptionPriceViewModelFactoryMock.stubbedMakeResult = .price
        subscriptionPriceViewModelFactoryMock.stubbedPeriodResult = "Month"

        let product: StoreProduct = .fake(
            localizedPriceString: .price,
            productType: .autoRenewableSubscription,
            subscriptionPeriod: .init(value: 1, unit: .day)
        )

        // when
        let viewModel = sut.make(product, style: .compact)

        // then
        XCTAssertEqual(viewModel.id, product.productIdentifier)
        XCTAssertEqual(viewModel.title, product.localizedTitle)
        XCTAssertEqual(viewModel.description, product.localizedDescription)
        XCTAssertEqual(viewModel.price, .price)
        XCTAssertEqual(viewModel.priceDescription, "Every Month")
    }

    func test_thatFactoryMakesProductWithLargeStyle_whenProductTypeIsRenewableSubscription() {
        // given
        subscriptionPriceViewModelFactoryMock.stubbedMakeResult = .price
        subscriptionPriceViewModelFactoryMock.stubbedPeriodResult = "Month"

        let product: StoreProduct = .fake(
            localizedPriceString: .price,
            productType: .autoRenewableSubscription,
            subscriptionPeriod: .init(value: 1, unit: .day)
        )

        // when
        let viewModel = sut.make(product, style: .large)

        // then
        XCTAssertEqual(viewModel.id, product.productIdentifier)
        XCTAssertEqual(viewModel.title, product.localizedTitle)
        XCTAssertEqual(viewModel.description, product.localizedDescription)
        XCTAssertEqual(viewModel.price, .price)
        XCTAssertEqual(viewModel.priceDescription, "Every Month")
    }
}

// MARK: - Constants

private extension String {
    static let price = "10 $"
}
