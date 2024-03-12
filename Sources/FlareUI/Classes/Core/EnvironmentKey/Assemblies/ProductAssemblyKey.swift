//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductAssemblyKey

struct ProductAssemblyKey: EnvironmentKey {
    static var defaultValue: IProductViewAssembly?
}

extension EnvironmentValues {
    var productViewAssembly: IProductViewAssembly? {
        get { self[ProductAssemblyKey.self] }
        set { self[ProductAssemblyKey.self] = newValue }
    }
}
