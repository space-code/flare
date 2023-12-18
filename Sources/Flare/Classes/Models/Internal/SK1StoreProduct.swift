//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - SK1StoreProduct

final class SK1StoreProduct {
    // MARK: Properties

    /// The store kit product.
    let product: SKProduct

    /// The price formatter.
    private lazy var numberFormatter: NumberFormatter = .numberFormatter(with: self.product.priceLocale)

    // MARK: Initialization

    init(_ product: SKProduct) {
        self.product = product
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
        guard #available(iOS 11.2, macOS 10.13.2, tvOS 11.2, watchOS 6.2, *) else {
            return .nonSubscription
        }
        return subscriptionPeriod == nil ? .nonSubscription : .subscription
    }

    @available(iOS 11.2, macOS 10.13.2, tvOS 11.2, watchOS 6.2, *)
    var subscriptionPeriod: SubscriptionPeriod? {
        guard let subscriptionPeriod = product.subscriptionPeriod, subscriptionPeriod.numberOfUnits > 0 else {
            return nil
        }
        return SubscriptionPeriod.from(subscriptionPeriod: subscriptionPeriod)
    }
}
