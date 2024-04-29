//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionStoreButtonLabelKey

private struct SubscriptionStoreButtonLabelKey: EnvironmentKey {
    static var defaultValue: SubscriptionStoreButtonLabel = .action
}

extension EnvironmentValues {
    var subscriptionStoreButtonLabel: SubscriptionStoreButtonLabel {
        get { self[SubscriptionStoreButtonLabelKey.self] }
        set { self[SubscriptionStoreButtonLabelKey.self] = newValue }
    }
}
