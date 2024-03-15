//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionTermsOfServiceURLKey

private struct SubscriptionTermsOfServiceURLKey: EnvironmentKey {
    static var defaultValue: URL?
}

extension EnvironmentValues {
    var subscriptionTermsOfServiceURL: URL? {
        get { self[SubscriptionTermsOfServiceURLKey] }
        set { self[SubscriptionTermsOfServiceURLKey] = newValue }
    }
}
