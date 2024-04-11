//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// swiftlint:disable:next type_name
struct SubscriptionsWrapperViewStyleConfiguration {
    // MARK: Types

    struct Toolbar: View {
        let body: AnyView

        init<Content: View>(_ content: Content) {
            self.body = content.eraseToAnyView()
        }
    }

    // MARK: Properties

    let items: [SubscriptionView.ViewModel]
    let selectedID: String?
    let action: (SubscriptionView.ViewModel) -> Void
}
