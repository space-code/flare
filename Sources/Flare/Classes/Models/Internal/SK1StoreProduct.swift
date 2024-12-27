//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - SK1StoreProduct

final class SK1StoreProduct {
    // MARK: Properties

    /// The store kit product.
    let product: SKProduct

    /// The price formatter.
    private let numberFormatter: NumberFormatter

    // MARK: Initialization

    init(_ product: SKProduct) {
        self.product = product
        self.numberFormatter = .numberFormatter(with: self.product.priceLocale)
    }
}

// MARK: ISKProduct

extension SK1StoreProduct: ISKProduct {
    var localizedDescription: String {
        product.localizedDescription
    }

    var localizedTitle: String {
        product.localizedTitle
    }

    var currencyCode: String? {
        product.priceLocale.currencyCodeID
    }

    var currencySymbol: String? {
        numberFormatter.currencySymbol
    }

    var locale: Locale {
        product.priceLocale
    }

    var price: Decimal {
        product.price as Decimal
    }

    var localizedPriceString: String? {
        numberFormatter.string(from: product.price)
    }

    var productIdentifier: String {
        product.productIdentifier
    }

    var productType: ProductType? {
        nil
    }

    var productCategory: ProductCategory? {
        subscriptionPeriod == nil ? .nonSubscription : .subscription
    }

    var subscriptionPeriod: SubscriptionPeriod? {
        guard let subscriptionPeriod = product.subscriptionPeriod, subscriptionPeriod.numberOfUnits > 0 else {
            return nil
        }
        return SubscriptionPeriod.from(subscriptionPeriod: subscriptionPeriod)
    }

    var introductoryDiscount: StoreProductDiscount? {
        product.introductoryPrice.flatMap { StoreProductDiscount(skProductDiscount: $0) }
    }

    var discounts: [StoreProductDiscount] {
        product.discounts.compactMap { StoreProductDiscount(skProductDiscount: $0) }
    }

    var subscriptionGroupIdentifier: String? {
        product.subscriptionGroupIdentifier
    }

    var subscription: SubscriptionInfo? {
        nil
    }
}
