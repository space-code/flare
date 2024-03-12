//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - StoreButtonAssemblyKey

struct StoreButtonAssemblyKey: EnvironmentKey {
    static var defaultValue: IStoreButtonAssembly?
}

extension EnvironmentValues {
    var storeButtonAssembly: IStoreButtonAssembly? {
        get { self[StoreButtonAssemblyKey.self] }
        set { self[StoreButtonAssemblyKey.self] = newValue }
    }
}
