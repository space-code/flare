//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// swiftlint:disable:next type_name
public struct SubscriptionStoreControlStyleConfiguration {
    struct Label: View {
        var body: AnyView

        init<Content: View>(_ view: Content) {
            body = view.eraseToAnyView()
        }
    }

    struct Description: View {
        var body: AnyView

        init<Content: View>(_ view: Content) {
            body = view.eraseToAnyView()
        }
    }

    struct Price: View {
        var body: AnyView

        init<Content: View>(_ view: Content) {
            body = view.eraseToAnyView()
        }
    }

    let label: Label
    let description: Description
    let price: Price
    let isSelected: Bool
    let subscriptionPickerItemBackground: Color
    let subscriptionViewTint: Color
    let action: () -> Void

    func trigger() {
        action()
    }
}
