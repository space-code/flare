//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import FlareMock
@testable import FlareUI
import FlareUIMock
import XCTest

final class ProductPresenterTests: XCTestCase {
    // MARK: Properties

    private var purchaseServiceMock: ProductPurchaseServiceMock!
    private var productFetcherMock: ProductFetcherMock!
    private var viewModelMock: WrapperViewModel<ProductViewModel>!

    private var sut: ProductPresenter!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        purchaseServiceMock = ProductPurchaseServiceMock()
        productFetcherMock = ProductFetcherMock()
        sut = ProductPresenter(
            productFetcher: productFetcherMock,
            purchaseService: purchaseServiceMock
        )
        viewModelMock = WrapperViewModel(model: ProductViewModel(state: .loading, presenter: sut))
        sut.viewModel = viewModelMock
    }

    override func tearDown() {
        sut = nil
        productFetcherMock = nil
        purchaseServiceMock = nil
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
        let error: Error? = await error(for: { try await sut.purchase(options: nil) })

        // then
        let iapError = try XCTUnwrap(error as? IAPError)
        XCTAssertEqual(iapError, .unknown)
    }

    func test_thatPresenterFinishesTransaction_whenPurchase() async throws {
        // given
        viewModelMock.model = .init(state: .product(.fake()), presenter: sut)
        purchaseServiceMock.stubbedPurchase = .fake()

        // when
        _ = try await sut.purchase(options: nil)

        // then
        XCTAssertEqual(purchaseServiceMock.invokedPurchaseCount, 1)
    }
}
