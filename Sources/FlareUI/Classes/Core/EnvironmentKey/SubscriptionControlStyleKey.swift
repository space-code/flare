//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionControlStyleKey

@available(watchOS, unavailable)
private struct SubscriptionControlStyleKey: EnvironmentKey {
    static var defaultValue: AnySubscriptionControlStyle { .init(style: .automatic) }
}

@available(watchOS, unavailable)
extension EnvironmentValues {
    var subscriptionControlStyle: AnySubscriptionControlStyle {
        get { self[SubscriptionControlStyleKey.self] }
        set { self[SubscriptionControlStyleKey.self] = newValue }
    }
}
