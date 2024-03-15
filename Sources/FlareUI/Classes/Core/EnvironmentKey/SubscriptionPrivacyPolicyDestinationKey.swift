//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionPrivacyPolicyDestinationKey

private struct SubscriptionPrivacyPolicyDestinationKey: EnvironmentKey {
    static var defaultValue: AnyView?
}

extension EnvironmentValues {
    var subscriptionPrivacyPolicyDestination: AnyView? {
        get { self[SubscriptionPrivacyPolicyDestinationKey] }
        set { self[SubscriptionPrivacyPolicyDestinationKey] = newValue }
    }
}
