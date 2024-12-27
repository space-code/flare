//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionMarketingContentKey

private struct SubscriptionMarketingContentKey: EnvironmentKey {
    static var defaultValue: AnyView? { nil }
}

extension EnvironmentValues {
    var subscriptionMarketingContent: AnyView? {
        get { self[SubscriptionMarketingContentKey.self] }
        set { self[SubscriptionMarketingContentKey.self] = newValue }
    }
}
