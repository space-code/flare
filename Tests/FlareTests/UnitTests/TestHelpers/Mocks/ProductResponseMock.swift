//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

final class ProductResponseMock: SKProductsResponse, @unchecked Sendable {
    var invokedInvalidProductsIdentifiers = false
    var invokedInvalidProductsIdentifiersCount = 0
    var stubbedInvokedInvalidProductsIdentifiers: [String] = []

    override var invalidProductIdentifiers: [String] {
        invokedInvalidProductsIdentifiers = true
        invokedInvalidProductsIdentifiersCount += 1
        return stubbedInvokedInvalidProductsIdentifiers
    }
}
