//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import FlareMock
@testable import FlareUI
import XCTest

// MARK: - SubscriptionPriceViewModelFactoryTests

final class SubscriptionPriceViewModelFactoryTests: XCTestCase {
    // MARK: Properties

    private var dateComponentsFormatterMock: DateComponentsFormatterMock!
    private var subscriptionDateComponentsFactoryMock: SubscriptionDateComponentsFactoryMock!

    private var sut: SubscriptionPriceViewModelFactory!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        dateComponentsFormatterMock = DateComponentsFormatterMock()
        subscriptionDateComponentsFactoryMock = SubscriptionDateComponentsFactoryMock()
        sut = SubscriptionPriceViewModelFactory(
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
        let viewModel = sut.make(product, format: .short)

        // then
        XCTAssertEqual(viewModel, product.localizedPriceString)
    }

    func test_thatFactoryMakesProductWithCompactStyle_whenProductTypeIsRenewableSubscription() {
        // given
        subscriptionDateComponentsFactoryMock.stubbedDateComponentsResult = DateComponents(day: 1)
        dateComponentsFormatterMock.stubbedStringResult = "1 month"

        let product: StoreProduct = .fake(
            localizedPriceString: .price,
            productType: .autoRenewableSubscription,
            subscriptionPeriod: .init(value: 1, unit: .day)
        )

        // when
        let viewModel = sut.make(product, format: .short)

        // then
        XCTAssertEqual(viewModel, "10 $")
    }

    func test_thatFactoryMakesProductWithLargeStyle_whenProductTypeIsRenewableSubscription() {
        // given
        subscriptionDateComponentsFactoryMock.stubbedDateComponentsResult = DateComponents(day: 1)
        dateComponentsFormatterMock.stubbedStringResult = "1 month"

        let product: StoreProduct = .fake(
            localizedPriceString: .price,
            productType: .autoRenewableSubscription,
            subscriptionPeriod: .init(value: 1, unit: .day)
        )

        // when
        let viewModel = sut.make(product, format: .full)

        // then
        XCTAssertEqual(viewModel, "10 $/month")
    }
}

// MARK: - Constants

private extension String {
    static let price = "10 $"
}
