//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import Foundation

// MARK: - ProductsViewSnapshotTests

final class ProductsViewSnapshotTests: SnapshotTestCase {
    func test_productsView_error() {
        assertSnapshots(
            of: ProductsView(
                viewModel: ProductsViewModel(
                    state: .error(.storeProductNotAvailable),
                    presenter: ProductsPresenterMock(),
                    productAssembly: ProductViewAssemblyMock(),
                    storeButtonAssembly: StoreButtonAssemblyMock()
                )
            ),
            size: .size
        )
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func test_productsView_products_withRestoreButtons() {
        let iapMock = FlareMock()
        iapMock.stubbedInvokedFetch = [.fake(), .fake(), .fake()]

        assertSnapshots(
            of: ProductsView(
                viewModel: ProductsViewModel(
                    state: .products(iapMock.stubbedInvokedFetch),
                    presenter: ProductsPresenterMock(),
                    productAssembly: ProductViewAssembly(iap: iapMock),
                    storeButtonAssembly: StoreButtonAssembly(iap: FlareMock())
                )
            )
            .storeButton(.visible, types: .restore, .restore),
            size: .size
        )
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func test_productsView_products() {
        let iapMock = FlareMock()
        iapMock.stubbedInvokedFetch = [.fake(), .fake(), .fake()]

        assertSnapshots(
            of: ProductsView(
                viewModel: ProductsViewModel(
                    state: .products(iapMock.stubbedInvokedFetch),
                    presenter: ProductsPresenterMock(),
                    productAssembly: ProductViewAssembly(iap: iapMock),
                    storeButtonAssembly: StoreButtonAssembly(iap: FlareMock())
                )
            ),
            size: .size
        )
    }
}

// MARK: - Constants

private extension CGSize {
    static let size = value(
        default: CGSize(width: 375.0, height: 812.0),
        tvOS: CGSize(width: 1920, height: 1080),
        macOS: CGSize(width: 1920, height: 1080)
    )
}
