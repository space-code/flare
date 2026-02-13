//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionTermsOfServiceDestinationKey

private struct SubscriptionTermsOfServiceDestinationKey: EnvironmentKey {
    static var defaultValue: AnyView? {
        nil
    }
}

extension EnvironmentValues {
    var subscriptionTermsOfServiceDestination: AnyView? {
        get { self[SubscriptionTermsOfServiceDestinationKey.self] }
        set { self[SubscriptionTermsOfServiceDestinationKey.self] = newValue }
    }
}
