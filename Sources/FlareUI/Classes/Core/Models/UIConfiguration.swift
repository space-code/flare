//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public struct UIConfiguration {
    // MARK: Properties

    public let subscriptionVerifier: SubscriptionStatusVerifierType

    // MARK: Initialization

    public init(subscriptionVerifier: SubscriptionStatusVerifierType) {
        self.subscriptionVerifier = subscriptionVerifier
    }
}
