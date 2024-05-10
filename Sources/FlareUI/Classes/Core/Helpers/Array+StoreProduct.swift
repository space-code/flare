//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

// MARK: - Extensions

extension Array where Element: StoreProduct {
    func by(id: String) -> StoreProduct? {
        first(where: { $0.productIdentifier == id })
    }
}
