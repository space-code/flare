//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func storeButton(_ visibility: StoreButtonVisibility, type: StoreButtonType) -> some View {
        transformEnvironment(\.storeButton) { values in
            if visibility == .hidden {
                values = values.filter { $0 != type }
            } else {
                values += [type]
            }
        }
    }
}
