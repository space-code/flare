//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

public enum RenewalState {
    case subscribed
    case expired
    case inBillingRetryPeriod
    case revoked
    case inGracePeriod
    case unknown

    // MARK: Initialization

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ state: Product.SubscriptionInfo.RenewalState) {
        switch state {
        case .subscribed:
            self = .subscribed
        case .expired:
            self = .expired
        case .inBillingRetryPeriod:
            self = .inBillingRetryPeriod
        case .revoked:
            self = .revoked
        case .inGracePeriod:
            self = .inGracePeriod
        default:
            self = .unknown
        }
    }
}
