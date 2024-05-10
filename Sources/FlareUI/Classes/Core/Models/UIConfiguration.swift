//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Struct representing configuration settings for the UI.
public struct UIConfiguration {
    // MARK: Properties

    /// The subscription status verifier type to use.
    public let subscriptionVerifier: SubscriptionStatusVerifierType

    // MARK: Initialization

    /// Initializes the UI configuration with the given subscription status verifier type.
    ///
    /// - Parameter subscriptionVerifier: The subscription status verifier type to use.
    public init(subscriptionVerifier: SubscriptionStatusVerifierType) {
        self.subscriptionVerifier = subscriptionVerifier
    }
}
