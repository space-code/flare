//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

// MARK: - SK2SubscriptionInfoStatus

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
struct SK2SubscriptionInfoStatus {
    // MARK: Properties

    let underlyingStatus: Product.SubscriptionInfo.Status

    // MARK: Initialization

    init(underlyingStatus: Product.SubscriptionInfo.Status) {
        self.underlyingStatus = underlyingStatus
    }
}

// MARK: ISubscriptionInfoStatus

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension SK2SubscriptionInfoStatus: ISubscriptionInfoStatus {
    var renewalState: RenewalState {
        underlyingStatus.renewalState
    }

    var subscriptionRenewalInfo: VerificationResult<RenewalInfo> {
        underlyingStatus.subscriptionRenewalInfo
    }
}
