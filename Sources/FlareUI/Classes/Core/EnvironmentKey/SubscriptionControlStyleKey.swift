//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionControlStyleKey

private struct SubscriptionControlStyleKey: EnvironmentKey {
    static var defaultValue: AnySubscriptionControlStyle = .init(style: .automatic)
}

extension EnvironmentValues {
    var subscriptionControlStyle: AnySubscriptionControlStyle {
        get { self[SubscriptionControlStyleKey.self] }
        set { self[SubscriptionControlStyleKey.self] = newValue }
    }
}
