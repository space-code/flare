//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import SwiftUI
import XCTest

// MARK: - ProductInfoViewSnapshotTests

@available(watchOS, unavailable)
final class ProductInfoViewSnapshotTests: SnapshotTestCase {
    func test_productInfoView_compactStyle_whenIconIsNil() {
        assertSnapshots(
            of: ProductInfoView(
                viewModel: .viewModel,
                icon: nil,
                style: .compact,
                action: {}
            ),
            size: .size
        )
    }

    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 12.0, *)
    func test_productInfoView_compactStyle_whenIconIsNotNil() {
        assertSnapshots(
            of: ProductInfoView(
                viewModel: .viewModel,
                icon: .init(content: Image(systemName: "crown")),
                style: .compact,
                action: {}
            ),
            size: .size
        )
    }

    #if os(iOS)
        func test_productInfoView_largeStyle_whenIconIsNil() {
            assertSnapshots(
                of: ProductInfoView(
                    viewModel: .viewModel,
                    icon: nil,
                    style: .large,
                    action: {}
                ),
                size: .largeSize
            )
        }

        func test_productInfoView_largeStyle_whenIconIsNotNil() {
            assertSnapshots(
                of: ProductInfoView(
                    viewModel: .viewModel,
                    icon: .init(content: Image(systemName: "crown")),
                    style: .large,
                    action: {}
                ),
                size: .largeSize
            )
        }
    #endif
}

// MARK: - Constants

private extension CGSize {
    static let size = value(default: CGSize(width: 375.0, height: 76.0), tvOS: CGSize(width: 1920, height: 1080))
    static let largeSize = value(default: CGSize(width: 375.0, height: 400.0), tvOS: CGSize(width: 1920, height: 1080))
}

private extension ProductInfoView.ViewModel {
    static let viewModel = ProductInfoView.ViewModel(
        id: UUID().uuidString,
        title: "My App Lifetime",
        description: "Lifetime access to additional content",
        price: "$19.99",
        priceDescription: nil
    )
}
