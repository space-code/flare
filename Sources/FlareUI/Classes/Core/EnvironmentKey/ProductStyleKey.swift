//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductStyleKey

private struct ProductStyleKey: EnvironmentKey {
    static var defaultValue = AnyProductStyle(style: CompactProductStyle())
}

extension EnvironmentValues {
    var productViewStyle: AnyProductStyle {
        get { self[ProductStyleKey.self] }
        set { self[ProductStyleKey.self] = newValue }
    }
}
