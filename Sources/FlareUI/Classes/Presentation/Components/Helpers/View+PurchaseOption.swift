//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI

public extension View {
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func inAppPurchaseOptions(_ options: ((StoreProduct) -> Set<Product.PurchaseOption>)?) -> some View {
        environment(\.purchaseOptions) { PurchaseOptions(options: options?($0) ?? []) }
    }
}
