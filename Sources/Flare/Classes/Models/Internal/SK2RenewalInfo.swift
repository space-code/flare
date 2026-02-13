//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

// MARK: - SK2RenewalInfo

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
struct SK2RenewalInfo {
    // MARK: Properties

    let underlyingRenewalInfo: Product.SubscriptionInfo.RenewalInfo
}

// MARK: IRenewalInfo

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension SK2RenewalInfo: IRenewalInfo {
    var jsonRepresentation: Data {
        underlyingRenewalInfo.jsonRepresentation
    }

    var originalTransactionID: UInt64 {
        underlyingRenewalInfo.originalTransactionID
    }

    var willAutoRenew: Bool {
        underlyingRenewalInfo.willAutoRenew
    }

    var autoRenewPreference: String? {
        underlyingRenewalInfo.autoRenewPreference
    }

    var isInBillingRetry: Bool {
        underlyingRenewalInfo.isInBillingRetry
    }

    var gracePeriodExpirationDate: Date? {
        underlyingRenewalInfo.gracePeriodExpirationDate
    }

    var offerID: String? {
        underlyingRenewalInfo.offerID
    }

    var currentProductID: String {
        underlyingRenewalInfo.currentProductID
    }

    var expirationReason: ExpirationReason? {
        guard let expirationReason = self.underlyingRenewalInfo.expirationReason else {
            return nil
        }
        return ExpirationReason(expirationReason: expirationReason)
    }

    var priceIncreaseStatus: PriceIncreaseStatus {
        PriceIncreaseStatus(underlyingRenewalInfo.priceIncreaseStatus)
    }

    var renewalPrice: Decimal? {
        #if swift(>=6.0)
            underlyingRenewalInfo.renewalPrice
        #else
            nil
        #endif
    }

    var currency: String? {
        #if swift(>=6.0)
            if #available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *) {
                underlyingRenewalInfo.currency?.identifier
            } else {
                underlyingRenewalInfo.currencyCode
            }
        #else
            nil
        #endif
    }
}
