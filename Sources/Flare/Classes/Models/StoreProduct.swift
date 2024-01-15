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
    private let product: ISKProduct

    /// <#Description#>
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
    var localizedDescription: String {
        product.localizedDescription
    }

    var localizedTitle: String {
        product.localizedTitle
    }

    var currencyCode: String? {
        product.currencyCode
    }

    var price: Decimal {
        product.price
    }

    var localizedPriceString: String? {
        product.localizedPriceString
    }

    var productIdentifier: String {
        product.productIdentifier
    }

    var productType: ProductType? {
        product.productType
    }

    var productCategory: ProductCategory? {
        product.productCategory
    }

    var subscriptionPeriod: SubscriptionPeriod? {
        product.subscriptionPeriod
    }

    var introductoryDiscount: StoreProductDiscount? {
        product.introductoryDiscount
    }

    var discounts: [StoreProductDiscount] {
        product.discounts
    }
}
