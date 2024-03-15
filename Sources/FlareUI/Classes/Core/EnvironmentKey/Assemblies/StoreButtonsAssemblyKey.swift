//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - StoreButtonsAssemblyKey

private struct StoreButtonsAssemblyKey: EnvironmentKey {
    static var defaultValue: IStoreButtonsAssembly?
}

extension EnvironmentValues {
    var storeButtonsAssembly: IStoreButtonsAssembly? {
        get { self[StoreButtonsAssemblyKey.self] }
        set { self[StoreButtonsAssemblyKey.self] = newValue }
    }
}
