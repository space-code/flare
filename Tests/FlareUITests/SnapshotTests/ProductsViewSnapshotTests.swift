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
                    productAssembly: ProductViewAssemblyMock()
                )
            ),
            size: .size
        )
    }

    func test_productsView_products() {
        let iapMock = FlareMock()
        iapMock.stubbedInvokedFetch = [.fake(), .fake(), .fake()]

        assertSnapshots(
            of: ProductsView(
                viewModel: ProductsViewModel(
                    state: .products(iapMock.stubbedInvokedFetch),
                    presenter: ProductsPresenterMock(),
                    productAssembly: ProductViewAssembly(iap: iapMock)
                )
            ),
            size: .size
        )
    }
}

// MARK: - Constants

private extension CGSize {
    static let size = CGSize(width: 375.0, height: 812.0)
}
