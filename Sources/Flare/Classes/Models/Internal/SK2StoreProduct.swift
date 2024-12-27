//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - SK2StoreProduct

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
final class SK2StoreProduct {
    // MARK: Properties

    /// The store kit product.
    let product: StoreKit.Product

    /// The currency format.
    private var currencyFormat: Decimal.FormatStyle.Currency {
        product.priceFormatStyle
    }

    /// The price formatter.
    private let numberFormatter: NumberFormatter

    // MARK: Initialization

    init(_ product: StoreKit.Product) {
        self.product = product
        self.numberFormatter = .numberFormatter(with: product.priceFormatStyle.locale)
    }
}

// MARK: ISKProduct

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
extension SK2StoreProduct: ISKProduct {
    var localizedDescription: String {
        product.description
    }

    var localizedTitle: String {
        product.displayName
    }

    var currencyCode: String? {
        currencyFormat.currencyCode
    }

    var currencySymbol: String? {
        numberFormatter.currencySymbol
    }

    var locale: Locale {
        currencyFormat.locale
    }

    var price: Decimal {
        product.price
    }

    var localizedPriceString: String? {
        product.displayPrice
    }

    var productIdentifier: String {
        product.id
    }

    var productType: ProductType? {
        ProductType(product.type)
    }

    var productCategory: ProductCategory? {
        productType?.productCategory
    }

    var subscriptionPeriod: SubscriptionPeriod? {
        guard let subscriptionPeriod = product.subscription?.subscriptionPeriod else {
            return nil
        }
        return SubscriptionPeriod.from(subscriptionPeriod: subscriptionPeriod)
    }

    var introductoryDiscount: StoreProductDiscount? {
        product.subscription?.introductoryOffer.flatMap {
            StoreProductDiscount(discount: $0, currencyCode: self.currencyCode)
        }
    }

    var discounts: [StoreProductDiscount] {
        product.subscription?.promotionalOffers.compactMap {
            StoreProductDiscount(discount: $0, currencyCode: self.currencyCode)
        } ?? []
    }

    var subscriptionGroupIdentifier: String? {
        product.subscription?.subscriptionGroupID
    }

    var subscription: SubscriptionInfo? {
        guard let subscription = product.subscription else {
            return nil
        }
        return SubscriptionInfo(subscriptionInfo: subscription)
    }
}
