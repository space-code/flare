//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

// MARK: - SK2SubscriptionInfo

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
struct SK2SubscriptionInfo {
    // MARK: Properties

    private let underlyingInfo: Product.SubscriptionInfo

    // MARK: Initialization

    init(underlyingInfo: Product.SubscriptionInfo) {
        self.underlyingInfo = underlyingInfo
    }
}

// MARK: ISubscriptionInfo

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
extension SK2SubscriptionInfo: ISubscriptionInfo {
    var subscriptionStatus: [SubscriptionInfoStatus] {
        get async throws {
            try await self.underlyingInfo.status.map { SubscriptionInfoStatus(underlyingStatus: $0) }
        }
    }

    var isEligibleForIntroOffer: SubscriptionEligibility {
        get async {
            guard self.underlyingInfo.introductoryOffer != nil else { return .noOffer }

            let value = await self.underlyingInfo.isEligibleForIntroOffer
            return value ? .eligible : .nonEligible
        }
    }
}
