//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - IStoreProductDiscount Protocol

/// A protocol representing a discount information for a store product.
protocol IStoreProductDiscount: Sendable {
    /// A unique identifier for the discount offer.
    var offerIdentifier: String? { get }

    /// The currency code for the discount amount.
    var currencyCode: String? { get }

    /// The discounted price in the specified currency.
    var price: Decimal { get }

    /// A localized string representing the price of the product.
    var localizedPriceString: String? { get }

    /// The payment mode associated with the discount (e.g., freeTrial, payUpFront, payAsYouGo).
    var paymentMode: PaymentMode { get }

    /// The period for which the discount is applicable in a subscription.
    var subscriptionPeriod: SubscriptionPeriod { get }

    /// The number of subscription periods for which the discount is applied.
    var numberOfPeriods: Int { get }

    /// The type of discount (e.g., introductory, promotional).
    var type: DiscountType { get }
}
