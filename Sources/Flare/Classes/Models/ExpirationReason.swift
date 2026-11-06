//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - ExpirationReason

public enum ExpirationReason {
    case autoRenewDisabled
    case billingError
    case didNotConsentToPriceIncrease
    case productUnavailable
    case unknown
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension ExpirationReason {
    init(expirationReason: Product.SubscriptionInfo.RenewalInfo.ExpirationReason) {
        switch expirationReason {
        case .autoRenewDisabled:
            self = .autoRenewDisabled
        case .billingError:
            self = .billingError
        case .didNotConsentToPriceIncrease:
            self = .didNotConsentToPriceIncrease
        case .productUnavailable:
            self = .productUnavailable
        case .unknown:
            self = .unknown
        default:
            self = .unknown
        }
    }
}
