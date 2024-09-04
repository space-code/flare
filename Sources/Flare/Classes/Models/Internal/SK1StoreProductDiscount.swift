//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

/// The details of an introductory offer or a promotional offer for an auto-renewable subscription.
struct SK1StoreProductDiscount: IStoreProductDiscount {
    // MARK: Properties

    private let productDiscount: SKProductDiscount

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

    /// Creates a `SK1StoreProductDiscount` instance.
    ///
    /// - Parameter productDiscount: The details of an introductory offer or a promotional
    ///                              offer for an auto-renewable subscription.
    init?(productDiscount: SKProductDiscount) {
        guard let paymentMode = PaymentMode.from(productDiscount: productDiscount),
              let discountType = DiscountType.from(productDiscount: productDiscount),
              let subscriptionPeriod = SubscriptionPeriod.from(subscriptionPeriod: productDiscount.subscriptionPeriod)
        else {
            return nil
        }

        self.productDiscount = productDiscount

        offerIdentifier = productDiscount.identifier
        currencyCode = productDiscount.priceLocale.currencyCodeID
        price = productDiscount.price as Decimal
        self.paymentMode = paymentMode
        self.subscriptionPeriod = subscriptionPeriod
        numberOfPeriods = productDiscount.numberOfPeriods
        type = discountType

        /// The price formatter.
        let numberFormatter: NumberFormatter = .numberFormatter(with: self.productDiscount.priceLocale)
        localizedPriceString = numberFormatter.string(from: self.productDiscount.price)
    }
}
