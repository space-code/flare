//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// A protocol that defines the interface for retrieving subscription-related information.
protocol ISubscriptionInfo {
    /// An asynchronous computed property that returns an array of the user's current subscription statuses.
    ///
    /// - Returns: An array of `SubscriptionInfoStatus` objects representing various subscription states.
    ///
    /// - Throws: An error if fetching the subscription status fails.
    var subscriptionStatus: [SubscriptionInfoStatus] { get async throws }

    /// An asynchronous computed property indicating whether the user is eligible for an introductory offer.
    ///
    /// - Returns: A `SubscriptionEligibility` value representing the user's eligibility status.
    var isEligibleForIntroOffer: SubscriptionEligibility { get async }
}
