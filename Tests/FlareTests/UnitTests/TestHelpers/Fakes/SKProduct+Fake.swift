//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import FlareMock
import Foundation
import StoreKit

extension SKProduct {
    static func fake(id: String) -> SKProduct {
        let product = ProductMock()
        product.stubbedProductIdentifier = id
        return product
    }
}
