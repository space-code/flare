//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(watchOS, unavailable)
// swiftlint:disable:next type_name
struct SubscriptionsWrapperViewStyleConfiguration: Sendable {
    // MARK: Types

    struct Toolbar: View {
        let body: AnyView

        init(_ content: some View) {
            self.body = content.eraseToAnyView()
        }
    }

    // MARK: Properties

    let items: [SubscriptionView.ViewModel]
    let selectedID: String?
    let action: @Sendable (SubscriptionView.ViewModel) -> Void
}
