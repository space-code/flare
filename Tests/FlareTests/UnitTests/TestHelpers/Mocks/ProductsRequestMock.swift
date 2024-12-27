//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

final class ProductsRequestMock: SKProductsRequest, @unchecked Sendable {
    var invokedStart = false
    var invokedStartCount = 0

    override func start() {
        invokedStart = true
        invokedStartCount += 1
    }
}
