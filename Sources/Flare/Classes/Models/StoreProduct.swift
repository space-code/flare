//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - StoreProduct

/// An object represents a StoreKit product.
public final class StoreProduct: NSObject {
    // MARK: Properties

    /// Protocol representing a Store Kit product.
    let product: ISKProduct

    /// The store kit product.
    var underlyingProduct: ISKProduct { product }

    // MARK: Initialization

    /// Creates a new `StoreProduct` instance.
    ///
    /// - Parameter product: The StoreKit product.
    init(_ product: ISKProduct) {
        self.product = product
    }
}

// MARK: - Convenience Initializators

public extension StoreProduct {
    /// Creates a new `StoreProduct` instance.
    ///
    /// - Parameter skProduct: The StoreKit product.
    convenience init(skProduct: SKProduct) {
        self.init(SK1StoreProduct(skProduct))
    }

    /// Creates a new `StoreProduct` instance.
    ///
    /// - Parameter product: The StoreKit product.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    convenience init(product: StoreKit.Product) {
        self.init(SK2StoreProduct(product))
    }
}

// MARK: ISKProduct

extension StoreProduct: ISKProduct {
    public var localizedDescription: String {
        product.localizedDescription
    }

    public var localizedTitle: String {
        product.localizedTitle
    }

    public var currencyCode: String? {
        product.currencyCode
    }

    public var currencySymbol: String? {
        product.currencySymbol
    }

    public var locale: Locale {
        product.locale
    }

    public var price: Decimal {
        product.price
    }

    public var localizedPriceString: String? {
        product.localizedPriceString
    }

    public var productIdentifier: String {
        product.productIdentifier
    }

    public var productType: ProductType? {
        product.productType
    }

    public var productCategory: ProductCategory? {
        product.productCategory
    }

    public var subscriptionPeriod: SubscriptionPeriod? {
        product.subscriptionPeriod
    }

    public var introductoryDiscount: StoreProductDiscount? {
        product.introductoryDiscount
    }

    public var discounts: [StoreProductDiscount] {
        product.discounts
    }

    public var subscriptionGroupIdentifier: String? {
        product.subscriptionGroupIdentifier
    }

    public var subscription: SubscriptionInfo? {
        product.subscription
    }
}
