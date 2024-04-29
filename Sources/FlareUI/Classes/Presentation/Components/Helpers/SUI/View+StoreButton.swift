//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func storeButton(_ visibility: StoreButtonVisibility, types: StoreButtonType...) -> some View {
        transformEnvironment(\.storeButton) { values in
            if visibility == .hidden {
                values = values.filter { !types.contains($0) }
            } else {
                let types = types.removingDuplicates()
                let diff = types.filter { !values.contains($0) }
                values += diff
            }
        }
    }

    func storeButton(_ visibility: StoreButtonVisibility, types: [StoreButtonType]) -> some View {
        transformEnvironment(\.storeButton) { values in
            if visibility == .hidden {
                values = values.filter { !types.contains($0) }
            } else {
                let types = types.removingDuplicates()
                let diff = types.filter { !values.contains($0) }
                values += diff
            }
        }
    }
}
