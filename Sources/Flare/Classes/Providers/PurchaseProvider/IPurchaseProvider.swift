//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

// typealias public PurchaseCompletionHandler = @MainActor @Sendable (
//    StoreTransaction,
//    Void
// )

protocol IPurchaseProvider {
    func purchase(product: StoreProduct, completion: @escaping () -> Void)
}
