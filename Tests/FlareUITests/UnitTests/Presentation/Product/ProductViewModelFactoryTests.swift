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

    private var dateComponentsFormatterMock: DateComponentsFormatterMock!
    private var subscriptionDateComponentsFactoryMock: SubscriptionDateComponentsFactoryMock!

    private var sut: ProductViewModelFactory!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        dateComponentsFormatterMock = DateComponentsFormatterMock()
        subscriptionDateComponentsFactoryMock = SubscriptionDateComponentsFactoryMock()
        sut = ProductViewModelFactory(
            dateFormatter: dateComponentsFormatterMock,
            subscriptionDateComponentsFactory: subscriptionDateComponentsFactoryMock
        )
    }

    override func tearDown() {
        dateComponentsFormatterMock = nil
        subscriptionDateComponentsFactoryMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatFactoryMakesAProduct_whenProductIsConsumable() {
        // given
        let product: StoreProduct = .fake(productType: .consumable)

        // when
        let viewModel = sut.make(product)

        // then
        XCTAssertEqual(viewModel.id, product.productIdentifier)
        XCTAssertEqual(viewModel.title, product.localizedTitle)
        XCTAssertEqual(viewModel.description, product.localizedDescription)
        XCTAssertEqual(viewModel.price, product.localizedPriceString)
    }

    func test_thatFactoryMakesAProduct_whenProductIsAutoRenewableSubscriptionWithADaySubscriptionPeriod() {
        // given
        subscriptionDateComponentsFactoryMock.stubbedDateComponentsResult = DateComponents(day: 1)
        dateComponentsFormatterMock.stubbedStringResult = "1 month"

        let product: StoreProduct = .fake(
            localizedPriceString: .price,
            productType: .autoRenewableSubscription,
            subscriptionPeriod: .init(value: 1, unit: .day)
        )

        // when
        let viewModel = sut.make(product)

        // then
        XCTAssertEqual(viewModel.id, product.productIdentifier)
        XCTAssertEqual(viewModel.title, product.localizedTitle)
        XCTAssertEqual(viewModel.description, product.localizedDescription)
        XCTAssertEqual(viewModel.price, "10 $/month")
        XCTAssertEqual(viewModel.priceDescription, "Every Month")
    }
}

// MARK: - Constants

private extension String {
    static let price = "10 $"
}
