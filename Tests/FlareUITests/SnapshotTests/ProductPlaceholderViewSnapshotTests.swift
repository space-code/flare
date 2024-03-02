//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import Foundation

// MARK: - ProductPlaceholderViewSnapshotTests

@available(watchOS, unavailable)
final class ProductPlaceholderViewSnapshotTests: SnapshotTestCase {
    func test_productPlaceholderView() {
        assertSnapshots(
            of: ProductPlaceholderView(),
            size: .size
        )
    }
}

// MARK: - Constants

private extension CGSize {
    static let size = CGSize(width: 375.0, height: 76.0)
}
