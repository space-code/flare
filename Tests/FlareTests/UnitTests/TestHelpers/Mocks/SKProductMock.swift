//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

final class SKProductMock: SKProduct {
    var invokedProductIdentifier = false
    var invokedProductIdentifierCount = 0
    var stubbedProductIdentifier: String = "product_id"

    override var productIdentifier: String {
        invokedProductIdentifier = true
        invokedProductIdentifierCount += 1
        return stubbedProductIdentifier
    }

    var stubbedPriceLocale: Locale!

    override var priceLocale: Locale {
        stubbedPriceLocale
    }

    var stubbedPrice: NSDecimalNumber!

    override var price: NSDecimalNumber {
        stubbedPrice
    }
}
