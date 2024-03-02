//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import SwiftUI
import XCTest

// MARK: - ProductViewSnapshotTests

@available(watchOS, unavailable)
final class ProductViewSnapshotTests: SnapshotTestCase {
    func test_productView_loading() {
        assertSnapshots(
            of: ProductView(
                viewModel: .init(state: .loading, presenter: ProductPresenterMock())
            ),
            size: .size
        )
    }

    func test_productView_product() {
        assertSnapshots(
            of: ProductView(
                viewModel: .init(state: .product(.fake()), presenter: ProductPresenterMock())
            ),
            size: .size
        )
    }

    func test_productView_error() {
        assertSnapshots(
            of: ProductView(
                viewModel: .init(state: .error(.unknown), presenter: ProductPresenterMock())
            ),
            size: .size
        )
    }

    func test_productView_customStyle_product() {
        assertSnapshots(
            of: ProductView(
                viewModel: .init(state: .product(.fake()), presenter: ProductPresenterMock())
            ).productViewStyle(CustomProductStyle()),
            size: .size
        )
    }
}

// MARK: ProductViewSnapshotTests.CustomProductStyle

private extension ProductViewSnapshotTests {
    struct CustomProductStyle: IProductStyle {
        @ViewBuilder
        func makeBody(configuration: ProductStyleConfiguration) -> some View {
            switch configuration.state {
            case .loading:
                Text("Loading")
            case let .product(item):
                VStack {
                    item.localizedPriceString.map { Text($0.debugDescription) }
                    Text(item.localizedTitle)
                    Text(item.localizedDescription)
                }
            case let .error(error):
                Text(error.localizedDescription)
            }
        }
    }
}

// MARK: - Constants

private extension CGSize {
    static let size = CGSize(width: 375.0, height: 812.0)
}
