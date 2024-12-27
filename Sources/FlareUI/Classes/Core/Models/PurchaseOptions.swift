//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

/// Struct representing purchase options for a product.
struct PurchaseOptions: @unchecked Sendable {
    // MARK: Properties

    /// Internal storage for purchase options.
    private var _options: Any?

    /// Purchase options as a set of `Product.PurchaseOption`.
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    var options: Set<Product.PurchaseOption>? {
        _options as? Set<Product.PurchaseOption>
    }

    // MARK: Initialization

    /// Initializes the purchase options with the given set of options.
    ///
    /// - Parameter options: The set of purchase options to store.
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(options: Set<Product.PurchaseOption>) {
        self._options = options
    }
}
