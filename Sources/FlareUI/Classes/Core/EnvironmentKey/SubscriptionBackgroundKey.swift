//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionBackgroundKey

private struct SubscriptionBackgroundKey: EnvironmentKey {
    static let defaultValue: Color = Palette.systemBackground
}

extension EnvironmentValues {
    var subscriptionBackground: Color {
        get { self[SubscriptionBackgroundKey.self] }
        set { self[SubscriptionBackgroundKey.self] = newValue }
    }
}
