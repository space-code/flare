//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import FlareMock
@testable import FlareUI
import XCTest

final class ProductsPresenterTests: XCTestCase {
    // MARK: Properties

    private var iapMock: FlareMock!
    private var viewModelMock: ViewModel<ProductsViewModel>!

    private var sut: ProductsPresenter!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        iapMock = FlareMock()
        sut = ProductsPresenter(
            ids: [],
            iap: iapMock
        )
        viewModelMock = ViewModel(
            model: ProductsViewModel(
                state: .products([]),
                presenter: sut,
                productAssembly: ProductViewAssemblyMock()
            )
        )
        sut.viewModel = viewModelMock
    }

    override func tearDown() {
        viewModelMock = nil
        iapMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatPresenterFetchesProducts_whenViewDidLoad() {
        // given
        let product: StoreProduct = .fake()
        iapMock.stubbedInvokedFetch = [product]

        // when
        sut.viewDidLoad()

        // then
        wait(self.viewModelMock.model.state == .products([product]))
        XCTAssertEqual(iapMock.invokedFetchCount, 1)
    }

    func test_thatPresenterThrowsError_whenViewDidLoad() {
        // given
        iapMock.stubbedFetchError = IAPError.unknown

        // when
        sut.viewDidLoad()

        // then
        wait(self.viewModelMock.model.state == .error(.unknown))
    }
}
