//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import FlareMock
@testable import FlareUI
import XCTest

final class ProductViewModelFactoryTests: XCTestCase {
    // MARK: Properties

    private var sut: ProductViewModelFactory!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = ProductViewModelFactory()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatFactoryMakesAProduct() {
        // given
        let product: StoreProduct = .fake()

        // when
        let viewModel = sut.make(product)

        // then
        XCTAssertEqual(viewModel.id, product.productIdentifier)
        XCTAssertEqual(viewModel.title, product.localizedTitle)
        XCTAssertEqual(viewModel.description, product.localizedDescription)
        XCTAssertEqual(viewModel.price, product.localizedPriceString)
    }
}
