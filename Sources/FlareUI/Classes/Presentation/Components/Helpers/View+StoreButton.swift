//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func storeButton(_ visibility: StoreButtonVisibility, type: StoreButtonType) -> some View {
        @Environment(\.storeButton) var values

        let filteredValues = {
            if visibility == .hidden {
                return values.filter { $0 != type }
            }
            return values
        }()

        return environment(\.storeButton, filteredValues)
    }
}
