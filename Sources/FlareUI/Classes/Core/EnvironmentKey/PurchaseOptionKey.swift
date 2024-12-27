//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI

typealias PurchaseOptionHandler = @Sendable (StoreProduct) -> PurchaseOptions

// MARK: - PurchaseOptionKey

private struct PurchaseOptionKey: EnvironmentKey {
    static let defaultValue: PurchaseOptionHandler? = nil
}

extension EnvironmentValues {
    var purchaseOptions: PurchaseOptionHandler? {
        get { self[PurchaseOptionKey.self] }
        set { self[PurchaseOptionKey.self] = newValue }
    }
}
