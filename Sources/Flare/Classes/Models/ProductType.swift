//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// The type of product, equivalent to StoreKit's `Product.ProductType`.
public enum ProductType: Int {
    /// A consumable in-app purchase.
    case consumable

    /// A non-consumable in-app purchase.
    case nonConsumable

    /// A non-renewing subscription.
    case nonRenewableSubscription

    /// An auto-renewable subscription.
    case autoRenewableSubscription
}
