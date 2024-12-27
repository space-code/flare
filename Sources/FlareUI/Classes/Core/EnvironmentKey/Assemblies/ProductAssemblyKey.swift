//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductAssemblyKey

private struct ProductAssemblyKey: EnvironmentKey {
    static let defaultValue: IProductViewAssembly? = nil
}

extension EnvironmentValues {
    var productViewAssembly: IProductViewAssembly? {
        get { self[ProductAssemblyKey.self] }
        set { self[ProductAssemblyKey.self] = newValue }
    }
}
