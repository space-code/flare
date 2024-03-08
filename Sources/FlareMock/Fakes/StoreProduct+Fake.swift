//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit

public extension StoreProduct {
    static func fake(
        localizedTitle: String? = "My App Lifetime",
        localizedDescription: String? = "Lifetime access to additional content",
        price: Decimal? = 1.0,
        currencyCode: String? = "USD",
        localizedPriceString: String? = "$19.99",
        productIdentifier: String? = "com.flare.app.lifetime",
        productType: ProductType? = nil,
        productCategory: ProductCategory? = nil,
        subscriptionPeriod: SubscriptionPeriod? = nil,
        introductoryDiscount: StoreProductDiscount? = nil,
        discounts: [StoreProductDiscount] = [],
        subscriptionGroupIdentifier: String? = nil
    ) -> StoreProduct {
        let mock = ProductMock()
        mock.stubbedLocalizedTitle = localizedTitle
        mock.stubbedLocalizedDescription = localizedDescription
        mock.stubbedPrice = price
        mock.stubbedCurrencyCode = currencyCode
        mock.stubbedLocalizedPriceString = localizedPriceString
        mock.stubbedProductIdentifier = productIdentifier
        mock.stubbedProductType = productType
        mock.stubbedProductCategory = productCategory
        mock.stubbedSubscriptionPeriod = subscriptionPeriod
        mock.stubbedIntroductoryDiscount = introductoryDiscount
        mock.stubbedDiscounts = discounts
        mock.stubbedSubscriptionGroupIdentifier = subscriptionGroupIdentifier
        return StoreProduct(mock)
    }
}
