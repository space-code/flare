//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import Foundation

// MARK: - ProductPlaceholderViewSnapshotTests

@available(watchOS, unavailable)
final class ProductPlaceholderViewSnapshotTests: SnapshotTestCase {
    func test_productPlaceholderView_whenIconIsHidden() {
        assertSnapshots(
            of: ProductPlaceholderView(isIconHidden: true),
            size: .size
        )
    }

    func test_productPlaceholderView_whenIconIsVisible() {
        assertSnapshots(
            of: ProductPlaceholderView(isIconHidden: false),
            size: .size
        )
    }
}

// MARK: - Constants

private extension CGSize {
    static let size = value(default: CGSize(width: 375.0, height: 76.0), tvOS: CGSize(width: 1920, height: 1080))
}
