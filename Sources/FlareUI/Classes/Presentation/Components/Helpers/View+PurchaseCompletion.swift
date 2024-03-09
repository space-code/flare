//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

public extension View {
    func onInAppPurchaseCompletion(completion: ((StoreProduct, Result<StoreTransaction, Error>) -> Void)?) -> some View {
        environment(\.purchaseCompletion, completion)
    }
}
