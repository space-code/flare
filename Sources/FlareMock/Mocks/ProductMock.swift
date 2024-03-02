//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

public final class ProductMock: SKProduct {
    override public init() {}

    public var invokedProductIdentifier = false
    public var invokedProductIdentifierCount = 0
    public var stubbedProductIdentifier: String = "product_id"

    override public var productIdentifier: String {
        invokedProductIdentifier = true
        invokedProductIdentifierCount += 1
        return stubbedProductIdentifier
    }

    public var invokedLocalizedTitle = false
    public var invokedLocalizedTitleCount = 0
    public var stubbedLocalizedTitle: String = "Localized Title"

    override public var localizedTitle: String {
        invokedLocalizedTitle = true
        invokedLocalizedTitleCount += 1
        return stubbedLocalizedTitle
    }

    public var invokedLocalizedDescription = false
    public var invokedLocalizedDescriptionCount = 0
    public var stubbedLocalizedDescription: String = "Localized Description"

    override public var localizedDescription: String {
        invokedLocalizedDescription = true
        invokedLocalizedDescriptionCount += 1
        return stubbedLocalizedDescription
    }

    public var stubbedPriceLocale: Locale = .current

    override public var priceLocale: Locale { stubbedPriceLocale }

    public var stubbedPrice: NSDecimalNumber = .zero

    override public var price: NSDecimalNumber { stubbedPrice
    }
}
