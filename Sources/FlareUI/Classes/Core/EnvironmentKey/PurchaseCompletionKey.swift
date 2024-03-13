//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

public typealias PurchaseCompletionHandler = (StoreProduct, Result<StoreTransaction, Error>) -> Void

// MARK: - PurchaseCompletionKey

private struct PurchaseCompletionKey: EnvironmentKey {
    static var defaultValue: PurchaseCompletionHandler?
}

extension EnvironmentValues {
    var purchaseCompletion: PurchaseCompletionHandler? {
        get { self[PurchaseCompletionKey.self] }
        set { self[PurchaseCompletionKey.self] = newValue }
    }
}
