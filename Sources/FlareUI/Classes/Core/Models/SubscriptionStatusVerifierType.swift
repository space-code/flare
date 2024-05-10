//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Enum representing different types of subscription status verifiers.
public enum SubscriptionStatusVerifierType {
    /// Verifier that automatically checks the subscription status.
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    case automatic

    /// Custom verifier implementing `ISubscriptionStatusVerifier` protocol.
    case custom(ISubscriptionStatusVerifier)
}
