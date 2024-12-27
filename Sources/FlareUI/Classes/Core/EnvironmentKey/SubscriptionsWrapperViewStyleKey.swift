//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - SubscriptionsWrapperViewStyleKey

@available(watchOS, unavailable)
private struct SubscriptionsWrapperViewStyleKey: EnvironmentKey {
    static var defaultValue: AnySubscriptionsWrapperViewStyle {
        AnySubscriptionsWrapperViewStyle(style: AutomaticSubscriptionsWrapperViewStyle())
    }
}

@available(watchOS, unavailable)
extension EnvironmentValues {
    var subscriptionsWrapperViewStyle: AnySubscriptionsWrapperViewStyle {
        get { self[SubscriptionsWrapperViewStyleKey.self] }
        set { self[SubscriptionsWrapperViewStyleKey.self] = newValue }
    }
}
