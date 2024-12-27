//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - PoliciesButtonStyleKey

@available(watchOS, unavailable)
private struct PoliciesButtonStyleKey: EnvironmentKey {
    static var defaultValue: AnyPoliciesButtonStyle { .init(style: AutomaticPoliciesButtonStyle()) }
}

@available(watchOS, unavailable)
extension EnvironmentValues {
    var policiesButtonStyle: AnyPoliciesButtonStyle {
        get { self[PoliciesButtonStyleKey.self] }
        set { self[PoliciesButtonStyleKey.self] = newValue }
    }
}
