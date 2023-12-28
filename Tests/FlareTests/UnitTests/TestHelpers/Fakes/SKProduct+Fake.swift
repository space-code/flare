//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

extension SKProduct {
    static func fake(id: String) -> SKProduct {
        let product = ProductMock()
        product.stubbedProductIdentifier = id
        return product
    }
}
