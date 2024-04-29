//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import FlareUIMock
import SwiftUI
import XCTest

// MARK: - SubscriptionsViewSnapshotTests

@available(watchOS, unavailable)
final class SubscriptionsViewSnapshotTests: SnapshotTestCase {
    // MARK: Properties

    // MARK: Tests

    func test_subscriptionsView_defaultStyle() {
        assertSnapshots(
            of: makeView(),
            size: .size
        )
    }

    func test_subscriptionsView_customStyle() {
        assertSnapshots(
            of: makeView()
                .subscriptionMarketingContent(view: { Text("Header View") })
            #if os(iOS)
                .subscriptionBackground(Color.gray)
                .subscriptionHeaderContentBackground(Color.blue)
                .subscriptionButtonLabel(.multiline)
            #endif
                .storeButton(.visible, types: .policies)
                .tintColor(.green)
                .subscriptionControlStyle(.button),

            size: .size
        )
    }

    // MARK: Private

    private func makeView() -> SubscriptionsWrapperView {
        SubscriptionsWrapperView(
            viewModel: SubscriptionsViewModel(
                state: .products(
                    [
                        .init(id: "1", title: "Subscription", price: "5,99 $", description: "Description", isActive: true),
                        .init(id: "2", title: "Subscription", price: "5,99 $", description: "Description", isActive: false),
                        .init(id: "3", title: "Subscription", price: "5,99 $", description: "Description", isActive: false),
                    ]
                ),
                selectedProductID: "1",
                presenter: SubscriptionsPresenterMock()
            )
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
