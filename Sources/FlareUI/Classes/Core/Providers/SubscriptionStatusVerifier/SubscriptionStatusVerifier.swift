//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

/// A class responsible for verifying the subscription status of a store product.
///
/// This class conforms to the `ISubscriptionStatusVerifier` protocol.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
final class SubscriptionStatusVerifier: ISubscriptionStatusVerifier {
    // MARK: ISubscriptionStatusVerifier

    /// Asynchronously validates the subscription status of the given store product.
    ///
    /// - Parameter storeProduct: The store product to validate.
    /// - Returns: A boolean value indicating whether the subscription is valid.
    /// - Throws: An error if the validation fails.
    func validate(_ storeProduct: StoreProduct) async throws -> Bool {
        guard let subscription = storeProduct.subscription else { return false }

        let statuses = try await subscription.subscriptionStatus

        for status in statuses {
            if case let .verified(subscription) = status.subscriptionRenewalInfo,
               subscription.currentProductID == storeProduct.productIdentifier
            {
                if status.renewalState == .subscribed {
                    return true
                }
            }
        }

        return false
    }
}
