//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

// MARK: - RenewalInfo

public struct RenewalInfo {
    // MARK: Properties

    let underlyingRenewalInfo: IRenewalInfo
}

// MARK: - Initialization

extension RenewalInfo {
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(renewalInfo: Product.SubscriptionInfo.RenewalInfo) {
        self.init(underlyingRenewalInfo: SK2RenewalInfo(underlyingRenewalInfo: renewalInfo))
    }
}

// MARK: IRenewalInfo

extension RenewalInfo: IRenewalInfo {
    public var jsonRepresentation: Data {
        underlyingRenewalInfo.jsonRepresentation
    }

    public var originalTransactionID: UInt64 {
        underlyingRenewalInfo.originalTransactionID
    }

    public var willAutoRenew: Bool {
        underlyingRenewalInfo.willAutoRenew
    }

    public var autoRenewPreference: String? {
        underlyingRenewalInfo.autoRenewPreference
    }

    public var isInBillingRetry: Bool {
        underlyingRenewalInfo.isInBillingRetry
    }

    public var gracePeriodExpirationDate: Date? {
        underlyingRenewalInfo.gracePeriodExpirationDate
    }

    public var offerID: String? {
        underlyingRenewalInfo.offerID
    }

    public var currentProductID: String {
        underlyingRenewalInfo.currentProductID
    }

    public var expirationReason: ExpirationReason? {
        underlyingRenewalInfo.expirationReason
    }

    public var priceIncreaseStatus: PriceIncreaseStatus {
        underlyingRenewalInfo.priceIncreaseStatus
    }

    public var renewalPrice: Decimal? {
        underlyingRenewalInfo.renewalPrice
    }

    public var currency: String? {
        underlyingRenewalInfo.currency
    }
}
