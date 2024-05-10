//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

/// Extension for handling in-app purchase completions within a view.
public extension View {
    /// Sets a completion handler for in-app purchase transactions.
    ///
    /// - Parameter completion: The completion handler to execute when an in-app purchase transaction completes.
    ///
    /// - Returns: A modified view with the specified completion handler.
    func onInAppPurchaseCompletion(completion: ((StoreProduct, Result<StoreTransaction, Error>) -> Void)?) -> some View {
        environment(\.purchaseCompletion, completion)
    }
}
