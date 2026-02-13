//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

// MARK: - SubscriptionInfo

public struct SubscriptionInfo {
    // MARK: Properties

    let underlyingSubscriptionInfo: ISubscriptionInfo
}

// MARK: - Initializators

extension SubscriptionInfo {
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(subscriptionInfo: Product.SubscriptionInfo) {
        self.init(underlyingSubscriptionInfo: SK2SubscriptionInfo(underlyingInfo: subscriptionInfo))
    }
}

// MARK: ISubscriptionInfo

extension SubscriptionInfo: ISubscriptionInfo {
    public var subscriptionStatus: [SubscriptionInfoStatus] {
        get async throws {
            try await self.underlyingSubscriptionInfo.subscriptionStatus
        }
    }

    public var isEligibleForIntroOffer: SubscriptionEligibility {
        get async {
            await self.underlyingSubscriptionInfo.isEligibleForIntroOffer
        }
    }
}
