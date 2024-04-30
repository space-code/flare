//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Protocol for resolving an object that can verify subscription status based on a given type.
protocol ISubscriptionStatusVerifierTypeResolver {
    /// Resolves an object that can verify subscription status based on the given type.
    ///
    /// - Parameter type: The type of subscription status verifier to resolve.
    /// - Returns: An object that can verify subscription status, or `nil` if not found.
    func resolve(_ type: SubscriptionStatusVerifierType) -> ISubscriptionStatusVerifier?
}
