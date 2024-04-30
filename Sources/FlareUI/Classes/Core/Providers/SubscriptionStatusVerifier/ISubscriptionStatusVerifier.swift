//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

/// Protocol for verifying the subscription status of a store product.
public protocol ISubscriptionStatusVerifier {
    /// Asynchronously validates the subscription status of the given store product.
    ///
    /// - Parameters:
    ///   - storeProduct: The store product to validate.
    /// - Returns: A boolean value indicating whether the subscription is valid.
    /// - Throws: An error if the validation fails.
    func validate(_ storeProduct: StoreProduct) async throws -> Bool
}
