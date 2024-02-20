//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Enumeration defining the eligibility status for a subscription
public enum SubscriptionEligibility: Int, Sendable {
    /// Represents that the subscription is eligible for an offer
    case eligible

    /// Represents that the subscription is not eligible for an offer
    case nonEligible

    /// Represents that there is no offer available for the subscription
    case noOffer
}
