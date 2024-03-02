//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import FlareMock
@testable import FlareUI
import XCTest

final class ProductPresenterTests: XCTestCase {
    // MARK: Properties

    private var flareMock: FlareMock!
    private var productFetcherMock: ProductFetcherMock!
    private var viewModelMock: ViewModel<ProductViewModel>!

    private var sut: ProductPresenter!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        flareMock = FlareMock()
        productFetcherMock = ProductFetcherMock()
        sut = ProductPresenter(
            iap: flareMock,
            productFetcher: productFetcherMock
        )
        viewModelMock = ViewModel(model: ProductViewModel(state: .loading, presenter: sut))
        sut.viewModel = viewModelMock
    }

    override func tearDown() {
        sut = nil
        productFetcherMock = nil
        flareMock = nil
        viewModelMock = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatPresenterFetchesProduct_whenViewDidLoad() async {
        // given
        let productFake = StoreProduct.fake()
        productFetcherMock.stubbedProduct = productFake

        // when
        sut.viewDidLoad()

        // then
        wait(self.viewModelMock.model.state == .product(productFake))
    }

    func test_thatPresenterDisplaysAnError_whenViewDidLoad() async {
        // given
        productFetcherMock.stubbedThrowProduct = IAPError.unknown

        // when
        sut.viewDidLoad()

        // then
        wait(self.viewModelMock.model.state == .error(.unknown))
    }

    func test_thatPresenterThrowsAnErrorIfProductIsMissing_whenPurchase() async throws {
        // when
        let error: Error? = await error(for: { try await sut.purchase() })

        // then
        let iapError = try XCTUnwrap(error as? IAPError)
        XCTAssertEqual(iapError, .unknown)
    }

    func test_thatPresenterFinishesTransaction_whenPurchase() async throws {
        // given
        viewModelMock.model = .init(state: .product(.fake()), presenter: sut)
        flareMock.stubbedPurchase = .fake()

        // when
        _ = try await sut.purchase()

        // then
        XCTAssertEqual(flareMock.invokedPurchaseCount, 1)
        XCTAssertEqual(flareMock.invokedFinishCount, 1)
    }

    func test_thatPresenterDoesThrowAnErrorIfUserCancelsARequest_whenPurchase() async throws {
        // given
        viewModelMock.model = .init(state: .product(.fake()), presenter: sut)
        flareMock.stubbedPurchaseError = IAPError.paymentCancelled

        // when
        _ = try await sut.purchase()

        // then
        XCTAssertEqual(flareMock.invokedPurchaseCount, 1)
        XCTAssertEqual(flareMock.invokedFinishCount, 0)
    }
}
