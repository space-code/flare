//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Protocol for providing an object that can verify subscription status.
protocol ISubscriptionStatusVerifierProvider {
    /// The subscription status verifier object.
    var subscriptionStatusVerifier: ISubscriptionStatusVerifier? { get }
}
