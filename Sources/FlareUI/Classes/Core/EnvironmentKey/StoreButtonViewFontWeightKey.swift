//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - StoreButtonViewFontWeightKey

private struct StoreButtonViewFontWeightKey: EnvironmentKey {
    static let defaultValue: Font.Weight = .regular
}

extension EnvironmentValues {
    var storeButtonViewFontWeight: Font.Weight {
        get { self[StoreButtonViewFontWeightKey.self] }
        set { self[StoreButtonViewFontWeightKey.self] = newValue }
    }
}
