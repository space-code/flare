//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionTermsOfServiceDestinationKey

private struct SubscriptionTermsOfServiceDestinationKey: EnvironmentKey {
    static var defaultValue: AnyView?
}

extension EnvironmentValues {
    var subscriptionTermsOfServiceDestination: AnyView? {
        get { self[SubscriptionTermsOfServiceDestinationKey] }
        set { self[SubscriptionTermsOfServiceDestinationKey] = newValue }
    }
}
