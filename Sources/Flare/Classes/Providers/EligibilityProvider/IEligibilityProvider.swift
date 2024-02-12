//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Type that provides eligibility checking functionality.
protocol IEligibilityProvider {
    /// Checks whether products are eligible for promotional offers
    ///
    /// - Parameter products: The products to be checked.
    ///
    /// - Returns: An array that contains information about the eligibility of products.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func checkEligibility(products: [StoreProduct]) async throws -> [String: SubscriptionEligibility]
}
