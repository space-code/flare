//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import Foundation

// MARK: - ProductPlaceholderViewSnapshotTests

@available(watchOS, unavailable)
final class ProductPlaceholderViewSnapshotTests: SnapshotTestCase {
    func test_productPlaceholderView_compactStyle_whenIconIsHidden() {
        assertSnapshots(
            of: ProductPlaceholderView(isIconHidden: true, style: .compact),
            size: .size
        )
    }

    func test_productPlaceholderView_compactStyle_whenIconIsVisible() {
        assertSnapshots(
            of: ProductPlaceholderView(isIconHidden: false, style: .compact),
            size: .size
        )
    }

    #if os(iOS)
        func test_productPlaceholderView_largeStyle_whenIconIsHidden() {
            assertSnapshots(
                of: ProductPlaceholderView(isIconHidden: true, style: .large),
                size: .largeSize
            )
        }

        func test_productPlaceholderView_largeStyle_whenIconIsVisible() {
            assertSnapshots(
                of: ProductPlaceholderView(isIconHidden: false, style: .large),
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
