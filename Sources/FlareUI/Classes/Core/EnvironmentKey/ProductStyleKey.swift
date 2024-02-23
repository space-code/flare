//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductStyleKey

public struct ProductStyleKey: EnvironmentKey {
    public static var defaultValue = AnyProductStyle(style: DefaultProductStyle())
}

extension EnvironmentValues {
    var productViewStyle: AnyProductStyle {
        get { self[ProductStyleKey.self] }
        set { self[ProductStyleKey.self] = newValue }
    }
}
