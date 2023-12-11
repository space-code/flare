//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - StoreProduct

public final class StoreProduct: NSObject {
    // MARK: Properties

    private let product: ISKProduct

    // MARK: Initialization

    private init(_ product: ISKProduct) {
        self.product = product
    }
}

// MARK: - Convinience Initializators

public extension StoreProduct {
    convenience init(skProduct: SKProduct) {
        self.init(SK1StoreProduct(skProduct))
    }

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
}
