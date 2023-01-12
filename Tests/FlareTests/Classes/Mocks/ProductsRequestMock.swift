//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

final class ProductsRequestMock: SKProductsRequest {
    var invokedStart = false
    var invokedStartCount = 0

    override func start() {
        invokedStart = true
        invokedStartCount += 1
    }
}
