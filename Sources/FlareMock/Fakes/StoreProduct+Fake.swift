//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit

public extension StoreProduct {
    static func fake(skProduct: SKProduct = ProductMock()) -> StoreProduct {
        StoreProduct(skProduct: skProduct)
    }
}
