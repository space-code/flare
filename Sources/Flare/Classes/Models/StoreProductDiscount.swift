//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - StoreProductDiscount

/// The details of an introductory offer or a promotional offer for an auto-renewable subscription.
public final class StoreProductDiscount {
    // MARK: Properties

    /// The details of an introductory offer or a promotional offer for an auto-renewable subscription.
    private let discount: IStoreProductDiscount

    // MARK: Initialization

    /// Creates a `StoreProductDiscount` instance.
    ///
    /// - Parameter discount: The details of an introductory offer or a promotional offer for an auto-renewable subscription.
    init(discount: IStoreProductDiscount) {
        self.discount = discount
    }
}

// MARK: - Convenience Initializators

public extension StoreProductDiscount {
    /// Creates a new `StoreProductDiscount` instance.
    ///
    /// - Parameter skProductDiscount: The details of an introductory offer or a promotional
    ///                                offer for an auto-renewable subscription.
    convenience init?(skProductDiscount: SKProductDiscount) {
        guard let discount = SK1StoreProductDiscount(productDiscount: skProductDiscount) else { return nil }
        self.init(discount: discount)
    }

    /// Creates a new `StoreProductDiscount` instance.
    ///
    /// - Parameters:
    ///   - subscriptionOffer: Information about a subscription offer that you configure in App Store Connect.
    ///   - currencyCode: The currency code for the discount amount.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    convenience init?(discount: StoreKit.Product.SubscriptionOffer, currencyCode: String?) {
        guard let discount = SK2StoreProductDiscount(subscriptionOffer: discount, currencyCode: currencyCode) else { return nil }
        self.init(discount: discount)
    }
}

// MARK: IStoreProductDiscount

extension StoreProductDiscount: IStoreProductDiscount {
    public var offerIdentifier: String? {
        discount.offerIdentifier
    }

    public var currencyCode: String? {
        discount.currencyCode
    }

    public var price: Decimal {
        discount.price
    }

    public var localizedPriceString: String? {
        discount.localizedPriceString
    }

    public var paymentMode: PaymentMode {
        discount.paymentMode
    }

    public var subscriptionPeriod: SubscriptionPeriod {
        discount.subscriptionPeriod
    }

    public var numberOfPeriods: Int {
        discount.numberOfPeriods
    }

    public var type: DiscountType {
        discount.type
    }
}
