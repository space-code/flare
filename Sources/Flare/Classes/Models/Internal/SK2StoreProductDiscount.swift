//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

/// The details of an introductory offer or a promotional offer for an auto-renewable subscription.
@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
struct SK2StoreProductDiscount: IStoreProductDiscount, Sendable {
    // MARK: Properties

    private let subscriptionOffer: StoreKit.Product.SubscriptionOffer

    /// A unique identifier for the discount offer.
    let offerIdentifier: String?

    /// The currency code for the discount amount.
    let currencyCode: String?

    /// The discounted price in the specified currency.
    let price: Decimal

    /// A localized string representing the price of the product.
    let localizedPriceString: String?

    /// The payment mode associated with the discount (e.g., freeTrial, payUpFront, payAsYouGo).
    let paymentMode: PaymentMode

    /// The period for which the discount is applicable in a subscription.
    let subscriptionPeriod: SubscriptionPeriod

    /// The number of subscription periods for which the discount is applied.
    let numberOfPeriods: Int

    /// The type of discount (e.g., introductory, promotional).
    let type: DiscountType

    // MARK: Initialization

    /// Creates a `SK2StoreProductDiscount` instance.
    ///
    /// - Parameters:
    ///   - subscriptionOffer: Information about a subscription offer that you configure in App Store Connect.
    ///   - currencyCode: The currency code for the discount amount.
    init?(subscriptionOffer: StoreKit.Product.SubscriptionOffer, currencyCode: String?) {
        guard let paymentMode = PaymentMode.from(discount: subscriptionOffer),
              let discountType = DiscountType.from(discount: subscriptionOffer),
              let subscriptionPeriod = SubscriptionPeriod.from(subscriptionPeriod: subscriptionOffer.period)
        else {
            return nil
        }

        self.subscriptionOffer = subscriptionOffer

        offerIdentifier = subscriptionOffer.id
        self.currencyCode = currencyCode
        price = subscriptionOffer.price
        self.paymentMode = paymentMode
        self.subscriptionPeriod = subscriptionPeriod
        numberOfPeriods = subscriptionOffer.periodCount
        type = discountType
        localizedPriceString = subscriptionOffer.displayPrice
    }
}
