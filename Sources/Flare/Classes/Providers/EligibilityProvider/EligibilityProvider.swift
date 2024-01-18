//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - EligibilityProvider

/// A class that provides eligibility checking functionality.
final class EligibilityProvider {}

// MARK: IEligibilityProvider

extension EligibilityProvider: IEligibilityProvider {
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func checkEligibility(products: [StoreProduct]) async throws -> [String: SubscriptionEligibility] {
        let underlyingProducts = products.compactMap { $0.underlyingProduct as? SK2StoreProduct }

        var result: [String: SubscriptionEligibility] = [:]

        for product in underlyingProducts {
            if let subscription = product.product.subscription, subscription.introductoryOffer != nil {
                let isEligible = await subscription.isEligibleForIntroOffer
                result[product.productIdentifier] = isEligible ? .eligible : .nonEligible
            } else {
                result[product.productIdentifier] = .noOffer
            }
        }

        return result
    }
}
