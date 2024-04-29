//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import struct StoreKit.Product

// MARK: - ISubscriptionInfoStatus

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension Product.SubscriptionInfo.Status: ISubscriptionInfoStatus {
    var renewalState: RenewalState {
        RenewalState(self.state)
    }

    var subscriptionRenewalInfo: VerificationResult<RenewalInfo> {
        switch self.renewalInfo {
        case let .verified(renewalInfo):
            return .verified(.init(renewalInfo: renewalInfo))
        case let .unverified(renewalInfo, error):
            return .unverified(.init(renewalInfo: renewalInfo), error)
        }
    }
}
