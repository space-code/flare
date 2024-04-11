//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionsWrapperViewStyleKey

private struct SubscriptionsWrapperViewStyleKey: EnvironmentKey {
    static var defaultValue = AnySubscriptionsWrapperViewStyle(style: AutomaticSubscriptionsWrapperViewStyle())
}

extension EnvironmentValues {
    var subscriptionsWrapperViewStyle: AnySubscriptionsWrapperViewStyle {
        get { self[SubscriptionsWrapperViewStyleKey.self] }
        set { self[SubscriptionsWrapperViewStyleKey.self] = newValue }
    }
}
