//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - StoreButtonKey

private struct StoreButtonKey: EnvironmentKey {
    static var defaultValue: [StoreButtonType] = []
}

extension EnvironmentValues {
    var storeButton: [StoreButtonType] {
        get { self[StoreButtonKey.self] }
        set { self[StoreButtonKey.self] = newValue }
    }
}
