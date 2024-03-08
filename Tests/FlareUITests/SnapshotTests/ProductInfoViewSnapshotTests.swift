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
    func test_productInfoView_whenIconIsNil() {
        assertSnapshots(
            of: ProductInfoView(
                viewModel: .viewModel,
                icon: nil,
                action: {}
            ),
            size: .size
        )
    }

    func test_productInfoView_whenIconIsNotNil() {
        assertSnapshots(
            of: ProductInfoView(
                viewModel: .viewModel,
                icon: .init(content: Image(systemName: "crown")),
                action: {}
            ),
            size: .size
        )
    }
}

// MARK: - Constants

private extension CGSize {
    static let size = value(default: CGSize(width: 375.0, height: 76.0), tvOS: CGSize(width: 1920, height: 1080))
}

private extension ProductInfoView.ViewModel {
    static let viewModel = ProductInfoView.ViewModel(
        id: UUID().uuidString,
        title: "My App Lifetime",
        description: "Lifetime access to additional content",
        price: "$19.99"
    )
}
