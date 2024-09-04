//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit

public final class ProductMock: ISKProduct {
    public init() {}

    public var invokedLocalizedDescriptionGetter = false
    public var invokedLocalizedDescriptionGetterCount = 0
    public var stubbedLocalizedDescription: String! = ""

    public var localizedDescription: String {
        invokedLocalizedDescriptionGetter = true
        invokedLocalizedDescriptionGetterCount += 1
        return stubbedLocalizedDescription
    }

    public var invokedLocalizedTitleGetter = false
    public var invokedLocalizedTitleGetterCount = 0
    public var stubbedLocalizedTitle: String! = ""

    public var localizedTitle: String {
        invokedLocalizedTitleGetter = true
        invokedLocalizedTitleGetterCount += 1
        return stubbedLocalizedTitle
    }

    public var invokedCurrencyCodeGetter = false
    public var invokedCurrencyCodeGetterCount = 0
    public var stubbedCurrencyCode: String!

    public var currencyCode: String? {
        invokedCurrencyCodeGetter = true
        invokedCurrencyCodeGetterCount += 1
        return stubbedCurrencyCode
    }

    public var invokedCurrencySymbolGetter = false
    public var invokedCurrencySymbolGetterCount = 0
    public var stubbedCurrencySymbol: String!

    public var currencySymbol: String? {
        invokedCurrencySymbolGetter = true
        invokedCurrencySymbolGetterCount += 1
        return stubbedCurrencySymbol
    }

    public var invokedPriceGetter = false
    public var invokedPriceGetterCount = 0
    public var stubbedPrice: Decimal!

    public var price: Decimal {
        invokedPriceGetter = true
        invokedPriceGetterCount += 1
        return stubbedPrice
    }

    public var invokedLocalizedPriceStringGetter = false
    public var invokedLocalizedPriceStringGetterCount = 0
    public var stubbedLocalizedPriceString: String!

    public var localizedPriceString: String? {
        invokedLocalizedPriceStringGetter = true
        invokedLocalizedPriceStringGetterCount += 1
        return stubbedLocalizedPriceString
    }

    public var invokedProductIdentifierGetter = false
    public var invokedProductIdentifierGetterCount = 0
    public var stubbedProductIdentifier: String! = ""

    public var productIdentifier: String {
        invokedProductIdentifierGetter = true
        invokedProductIdentifierGetterCount += 1
        return stubbedProductIdentifier
    }

    public var invokedProductTypeGetter = false
    public var invokedProductTypeGetterCount = 0
    public var stubbedProductType: ProductType!

    public var productType: ProductType? {
        invokedProductTypeGetter = true
        invokedProductTypeGetterCount += 1
        return stubbedProductType
    }

    public var invokedProductCategoryGetter = false
    public var invokedProductCategoryGetterCount = 0
    public var stubbedProductCategory: ProductCategory!

    public var productCategory: ProductCategory? {
        invokedProductCategoryGetter = true
        invokedProductCategoryGetterCount += 1
        return stubbedProductCategory
    }

    public var invokedSubscriptionPeriodGetter = false
    public var invokedSubscriptionPeriodGetterCount = 0
    public var stubbedSubscriptionPeriod: SubscriptionPeriod!

    public var subscriptionPeriod: SubscriptionPeriod? {
        invokedSubscriptionPeriodGetter = true
        invokedSubscriptionPeriodGetterCount += 1
        return stubbedSubscriptionPeriod
    }

    public var invokedIntroductoryDiscountGetter = false
    public var invokedIntroductoryDiscountGetterCount = 0
    public var stubbedIntroductoryDiscount: StoreProductDiscount!

    public var introductoryDiscount: StoreProductDiscount? {
        invokedIntroductoryDiscountGetter = true
        invokedIntroductoryDiscountGetterCount += 1
        return stubbedIntroductoryDiscount
    }

    public var invokedDiscountsGetter = false
    public var invokedDiscountsGetterCount = 0
    public var stubbedDiscounts: [StoreProductDiscount]! = []

    public var discounts: [StoreProductDiscount] {
        invokedDiscountsGetter = true
        invokedDiscountsGetterCount += 1
        return stubbedDiscounts
    }

    // swiftlint:disable identifier_name
    public var invokedSubscriptionGroupIdentifierGetter = false
    public var invokedSubscriptionGroupIdentifierGetterCount = 0
    public var stubbedSubscriptionGroupIdentifier: String!

    public var subscriptionGroupIdentifier: String? {
        invokedSubscriptionGroupIdentifierGetter = true
        invokedSubscriptionGroupIdentifierGetterCount += 1
        return stubbedSubscriptionGroupIdentifier
    }

    // swiftlint:enable identifier_name

    public var subscription: SubscriptionInfo? {
        nil
    }
}
