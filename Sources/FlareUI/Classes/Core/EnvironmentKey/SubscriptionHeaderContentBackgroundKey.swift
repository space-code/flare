//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionHeaderContentBackgroundKey

private struct SubscriptionHeaderContentBackgroundKey: EnvironmentKey {
    static var defaultValue: Color = .clear
}

extension EnvironmentValues {
    var subscriptionHeaderContentBackground: Color {
        get { self[SubscriptionHeaderContentBackgroundKey.self] }
        set { self[SubscriptionHeaderContentBackgroundKey.self] = newValue }
    }
}
