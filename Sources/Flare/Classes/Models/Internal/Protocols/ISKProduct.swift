//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Protocol representing a Store Kit product.
protocol ISKProduct {
    /// A localized description of the product.
    var localizedDescription: String { get }

    /// A localized title or name of the product.
    var localizedTitle: String { get }

    /// The currency code for the product's price.
    var currencyCode: String? { get }

    /// The price of the product in decimal format.
    var price: Decimal { get }

    /// A localized string representing the price of the product.
    var localizedPriceString: String? { get }

    /// The unique identifier for the product.
    var productIdentifier: String { get }

    /// The type of product (e.g., consumable, non-consumable).
    var productType: ProductType? { get }

    /// The category to which the product belongs.
    var productCategory: ProductCategory? { get }

    /// The subscription period for the product, if applicable.
    var subscriptionPeriod: SubscriptionPeriod? { get }

    /// <#Description#>
    var introductoryDiscount: StoreProductDiscount? { get }

    /// <#Description#>
    var discounts: [StoreProductDiscount] { get }

    var subscriptionGroupIdentifier: String? { get }
}
