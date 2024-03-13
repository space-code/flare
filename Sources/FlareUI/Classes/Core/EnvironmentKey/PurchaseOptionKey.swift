//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI

// MARK: - PurchaseOptionKey

private struct PurchaseOptionKey: EnvironmentKey {
    static var defaultValue: ((StoreProduct) -> PurchaseOptions)?
}

extension EnvironmentValues {
    var purchaseOptions: ((StoreProduct) -> PurchaseOptions)? {
        get { self[PurchaseOptionKey.self] }
        set { self[PurchaseOptionKey.self] = newValue }
    }
}
