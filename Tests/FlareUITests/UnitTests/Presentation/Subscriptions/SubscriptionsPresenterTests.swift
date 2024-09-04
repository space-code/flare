//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
@testable import FlareUI
import FlareUIMock
import XCTest

// MARK: - SubscriptionsPresenterTests

@available(watchOS, unavailable)
final class SubscriptionsPresenterTests: XCTestCase {
    // MARK: Properties

    private var sut: SubscriptionsPresenter!

    private var viewModelMock: WrapperViewModel<SubscriptionsViewModel>!
    private var iapMock: FlareMock!
    private var viewModelFactoryMock: SubscriptionsViewModelViewFactoryMock!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()

        iapMock = FlareMock()
        viewModelFactoryMock = SubscriptionsViewModelViewFactoryMock()

        sut = SubscriptionsPresenter(
            iap: iapMock,
            ids: Array.ids,
            viewModelFactory: viewModelFactoryMock
        )

        viewModelMock = WrapperViewModel(
            model: SubscriptionsViewModel(
                state: .loading,
                selectedProductID: nil,
                presenter: sut
            )
        )

        sut.viewModel = viewModelMock
    }

    override func tearDown() {
        iapMock = nil
        viewModelFactoryMock = nil

        super.tearDown()
    }

    // MARK: Tests

    func test_thatPresenterShowsProducts_whenViewDidLoad() throws {
        // given
        let autoRenewableProduct = StoreProduct.fake(productType: .autoRenewableSubscription)

        iapMock.stubbedInvokedFetch = [
            autoRenewableProduct,
            .fake(productType: .consumable),
            .fake(productType: .nonConsumable),
            .fake(productType: .nonRenewableSubscription),
        ]
        viewModelFactoryMock.stubbedMake = [.fake(), .fake(), .fake()]

        // when
        sut.viewDidLoad()

        // then
        wait(self.viewModelMock.model.numberOfProducts == 3)

        XCTAssertEqual(viewModelFactoryMock.invokedMakeParameters?.products, [autoRenewableProduct])

        let ids = try XCTUnwrap(iapMock.invokedFetchParameters?.productIDs as? [String])
        XCTAssertEqual(ids, Array.ids)
    }

    func test_thatPresenterReturnsProduct() {
        // given
        let autoRenewableProduct = StoreProduct.fake(productType: .autoRenewableSubscription)

        iapMock.stubbedInvokedFetch = [
            autoRenewableProduct,
            .fake(productType: .consumable),
            .fake(productType: .nonConsumable),
            .fake(productType: .nonRenewableSubscription),
        ]
        viewModelFactoryMock.stubbedMake = [.fake(), .fake(), .fake()]

        // when
        sut.viewDidLoad()

        // then
        wait(self.sut.product(withID: autoRenewableProduct.productIdentifier) == autoRenewableProduct)
    }

    func test_thatPresenterSubscribesToAProduct() async throws {
        // given
        let autoRenewableProduct = StoreProduct.fake(productType: .autoRenewableSubscription)
        let fakeTransaction = StoreTransaction.fake()

        iapMock.stubbedPurchase = fakeTransaction

        iapMock.stubbedInvokedFetch = [
            autoRenewableProduct,
            .fake(productType: .consumable),
            .fake(productType: .nonConsumable),
            .fake(productType: .nonRenewableSubscription),
        ]
        viewModelFactoryMock.stubbedMake = [.fake(), .fake(), .fake()]

        // when
        sut.viewDidLoad()
        sut.selectProduct(with: autoRenewableProduct.productIdentifier)

        wait(self.viewModelMock.model.selectedProductID != nil)

        let transaction = try await self.sut.subscribe(optionsHandler: nil)

        // then
        XCTAssertEqual(transaction, fakeTransaction)
    }
}

// MARK: - Extensions

private extension Array where Element == String {
    static let ids = ["subscription"]
}
