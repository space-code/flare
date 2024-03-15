//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import FlareMock
@testable import FlareUI
import FlareUIMock
import Foundation

// MARK: - ProductsViewSnapshotTests

@available(watchOS, unavailable)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
final class ProductsViewSnapshotTests: SnapshotTestCase {
    func test_productsView_error() {
        assertSnapshots(
            of: ProductsWrapperView(
                viewModel: ProductsViewModel(
                    state: .error(.storeProductNotAvailable),
                    presenter: ProductsPresenterMock()
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
            of: ProductsWrapperView(
                viewModel: ProductsViewModel(
                    state: .products(iapMock.stubbedInvokedFetch),
                    presenter: ProductsPresenterMock()
                )
            )
            .environment(\.productViewAssembly, ProductViewAssembly(iap: iapMock))
            .environment(
                \.storeButtonsAssembly,
                StoreButtonsAssembly(
                    storeButtonAssembly: StoreButtonAssembly(iap: FlareMock()),
                    policiesButtonAssembly: PoliciesButtonAssembly()
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
            of: ProductsWrapperView(
                viewModel: ProductsViewModel(
                    state: .products(iapMock.stubbedInvokedFetch),
                    presenter: ProductsPresenterMock()
                )
            )
            .environment(\.productViewAssembly, ProductViewAssembly(iap: iapMock))
            .environment(
                \.storeButtonsAssembly,
                StoreButtonsAssembly(
                    storeButtonAssembly: StoreButtonAssembly(iap: FlareMock()),
                    policiesButtonAssembly: PoliciesButtonAssembly()
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
