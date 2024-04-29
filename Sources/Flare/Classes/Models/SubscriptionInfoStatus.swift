//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - SubscriptionInfoStatus

public struct SubscriptionInfoStatus {
    // MARK: Properties

    let underlyingStatus: ISubscriptionInfoStatus

    // MARK: Initialization

    init(underlyingStatus: ISubscriptionInfoStatus) {
        self.underlyingStatus = underlyingStatus
    }
}

// MARK: ISubscriptionInfoStatus

extension SubscriptionInfoStatus: ISubscriptionInfoStatus {
    public var renewalState: RenewalState {
        self.underlyingStatus.renewalState
    }

    public var subscriptionRenewalInfo: VerificationResult<RenewalInfo> {
        self.underlyingStatus.subscriptionRenewalInfo
    }
}
