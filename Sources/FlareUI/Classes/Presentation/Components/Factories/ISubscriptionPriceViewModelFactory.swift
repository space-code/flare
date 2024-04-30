//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

// MARK: - ISubscriptionPriceViewModelFactory

/// Protocol for creating view models representing subscription prices.
protocol ISubscriptionPriceViewModelFactory {
    /// Creates a string representing the price of a subscription product.
    ///
    /// - Parameters:
    ///   - product: The subscription product.
    ///   - format: The format in which to display the price.
    /// - Returns: A string representing the price.
    func make(_ product: StoreProduct, format: PriceDisplayFormat) -> String

    /// Retrieves the period of a subscription product.
    ///
    /// - Parameter product: The subscription product.
    /// - Returns: A string representing the subscription period.
    func period(from product: StoreProduct) -> String?
}
