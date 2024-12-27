//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionPickerItemBackgroundKey

private struct SubscriptionPickerItemBackgroundKey: EnvironmentKey {
    static let defaultValue: Color = Palette.systemGray5
}

extension EnvironmentValues {
    var subscriptionPickerItemBackground: Color {
        get { self[SubscriptionPickerItemBackgroundKey.self] }
        set { self[SubscriptionPickerItemBackgroundKey.self] = newValue }
    }
}
