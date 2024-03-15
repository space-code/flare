//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import FlareMock
@testable import FlareUI
import FlareUIMock
import SwiftUI
import XCTest

// MARK: - ProductViewSnapshotTests

@available(watchOS, unavailable)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
final class ProductViewSnapshotTests: SnapshotTestCase {
    func test_productView_loading() {
        assertSnapshots(
            of: ProductWrapperView(
                viewModel: .init(state: .loading, presenter: ProductPresenterMock())
            ),
            size: .size
        )
    }

    func test_productView_product() {
        assertSnapshots(
            of: ProductWrapperView(
                viewModel: .init(state: .product(.fake()), presenter: ProductPresenterMock())
            ),
            size: .size
        )
    }

    func test_productView_error() {
        assertSnapshots(
            of: ProductWrapperView(
                viewModel: .init(state: .error(.unknown), presenter: ProductPresenterMock())
            ),
            size: .size
        )
    }

    func test_productView_customStyle_product() {
        assertSnapshots(
            of: ProductWrapperView(
                viewModel: .init(state: .product(.fake()), presenter: ProductPresenterMock())
            ).productViewStyle(CustomProductStyle()),
            size: .size
        )
    }
}

// MARK: ProductViewSnapshotTests.CustomProductStyle

@available(watchOS, unavailable)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
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
    static let size = value(default: CGSize(width: 375.0, height: 812.0), tvOS: CGSize(width: 1920, height: 1080))
}
