//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductStyleKey

struct ProductStyleKey: EnvironmentKey {
    static var defaultValue = AnyProductStyle(style: DefaultProductStyle())
}

extension EnvironmentValues {
    var productViewStyle: AnyProductStyle {
        get { self[ProductStyleKey.self] }
        set { self[ProductStyleKey.self] = newValue }
    }
}
