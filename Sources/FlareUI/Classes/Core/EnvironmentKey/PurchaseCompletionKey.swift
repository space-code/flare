//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - PurchaseCompletionKey

struct PurchaseCompletionKey: EnvironmentKey {
    static var defaultValue: ((StoreProduct, Result<StoreTransaction, Error>) -> Void)?
}

extension EnvironmentValues {
    var purchaseCompletion: ((StoreProduct, Result<StoreTransaction, Error>) -> Void)? {
        get { self[PurchaseCompletionKey.self] }
        set { self[PurchaseCompletionKey.self] = newValue }
    }
}
