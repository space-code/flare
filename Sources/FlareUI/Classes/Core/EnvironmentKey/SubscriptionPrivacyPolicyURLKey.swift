//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionPrivacyPolicyURLKey

private struct SubscriptionPrivacyPolicyURLKey: EnvironmentKey {
    static var defaultValue: URL?
}

extension EnvironmentValues {
    var subscriptionPrivacyPolicyURL: URL? {
        get { self[SubscriptionPrivacyPolicyURLKey] }
        set { self[SubscriptionPrivacyPolicyURLKey] = newValue }
    }
}
