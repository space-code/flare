//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// swiftlint:disable:next type_name
public struct SubscriptionStoreControlStyleConfiguration {
    // MARK: Types

    /// A view for the label.
    public struct Label: View {
        public var body: AnyView

        init(_ view: some View) {
            body = view.eraseToAnyView()
        }
    }

    /// A view for the description.
    public struct Description: View {
        public var body: AnyView

        init(_ view: some View) {
            body = view.eraseToAnyView()
        }
    }

    /// A view for the price.
    public struct Price: View {
        public var body: AnyView

        init(_ view: some View) {
            body = view.eraseToAnyView()
        }
    }

    // MARK: Properties

    /// The label view.
    public let label: Label
    /// The description view.
    public let description: Description
    /// The price view.
    public let price: Price
    /// A Boolean value indicating whether the subscription is selected.
    public let isSelected: Bool
    /// A Boolean value indicating whether the subscription is active.
    public let isActive: Bool

    let action: () -> Void

    /// Triggers the action associated with the subscription.
    public func trigger() {
        action()
    }
}
