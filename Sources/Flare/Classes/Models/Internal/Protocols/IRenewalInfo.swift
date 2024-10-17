//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - IRenewalInfo

public protocol IRenewalInfo {
    /// The JSON representation of the renewal information.
    var jsonRepresentation: Data { get }

    /// The original transaction identifier for the subscription group.
    var originalTransactionID: UInt64 { get }

    /// The currently active product identifier, or the most recently active product identifier if the
    /// subscription is expired.
    var currentProductID: String { get }

    /// Whether the subscription will auto renew at the end of the current billing period.
    var willAutoRenew: Bool { get }

    /// The product identifier the subscription will auto renew to at the end of the current billing period.
    ///
    /// If the user disabled auto renewing, this property will be `nil`.
    var autoRenewPreference: String? { get }

    /// The reason the subscription expired.
    var expirationReason: ExpirationReason? { get }

    /// The status of a price increase for the user.
    var priceIncreaseStatus: PriceIncreaseStatus { get }

    /// The renewal price of the auto-renewable subscription that renews at the next billing period.
    var renewalPrice: Decimal? { get }

    /// The currency of the subscription's renewal price.
    var currency: String? { get }

    /// Whether the subscription is in a billing retry period.
    var isInBillingRetry: Bool { get }

    /// The date the billing grace period will expire.
    var gracePeriodExpirationDate: Date? { get }

    /// Identifies the offer that will be applied to the next billing period.
    ///
    /// If `offerType` is `promotional`, this will be the offer identifier. If `offerType` is
    /// `code`, this will be the offer code reference name. This will be `nil` for `introductory`
    /// offers and if there will be no offer applied for the next billing period.
    var offerID: String? { get }
}

/// Default implementation of the currency property for backward compatibility.
extension IRenewalInfo {
    var currency: String? {
        Locale.current.currencyCodeID
    }
}
