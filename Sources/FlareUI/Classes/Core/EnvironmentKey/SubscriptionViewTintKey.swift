//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionViewTintKey

private struct SubscriptionViewTintKey: EnvironmentKey {
    static var defaultValue: Color = .blue
}

extension EnvironmentValues {
    var subscriptionViewTint: Color {
        get { self[SubscriptionViewTintKey.self] }
        set { self[SubscriptionViewTintKey.self] = newValue }
    }
}
