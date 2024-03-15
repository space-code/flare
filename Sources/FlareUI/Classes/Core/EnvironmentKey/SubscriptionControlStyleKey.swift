//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionControlStyleKey

private struct SubscriptionControlStyleKey: EnvironmentKey {
    static var defaultValue: SubscriptionControlStyle = .picker
}

extension EnvironmentValues {
    var subscriptionControlStyle: SubscriptionControlStyle {
        get { self[SubscriptionControlStyleKey.self] }
        set { self[SubscriptionControlStyleKey.self] = newValue }
    }
}
