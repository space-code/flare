//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

public typealias PurchaseCompletionHandler = @Sendable (StoreProduct, Result<StoreTransaction, Error>) -> Void

// MARK: - PurchaseCompletionKey

private struct PurchaseCompletionKey: EnvironmentKey {
    static let defaultValue: PurchaseCompletionHandler? = nil
}

extension EnvironmentValues {
    var purchaseCompletion: PurchaseCompletionHandler? {
        get { self[PurchaseCompletionKey.self] }
        set { self[PurchaseCompletionKey.self] = newValue }
    }
}
