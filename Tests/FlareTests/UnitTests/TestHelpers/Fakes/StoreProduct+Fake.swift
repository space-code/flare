//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Flare
import StoreKit

extension StoreProduct {
    static func fake(skProduct: SKProduct = ProductMock()) -> StoreProduct {
        StoreProduct(skProduct: skProduct)
    }
}
