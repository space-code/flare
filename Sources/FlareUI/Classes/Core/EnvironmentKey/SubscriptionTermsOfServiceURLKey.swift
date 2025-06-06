//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionTermsOfServiceURLKey

private struct SubscriptionTermsOfServiceURLKey: EnvironmentKey {
    static let defaultValue: URL? = nil
}

extension EnvironmentValues {
    var subscriptionTermsOfServiceURL: URL? {
        get { self[SubscriptionTermsOfServiceURLKey.self] }
        set { self[SubscriptionTermsOfServiceURLKey.self] = newValue }
    }
}
