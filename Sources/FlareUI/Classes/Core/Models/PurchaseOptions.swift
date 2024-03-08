//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

struct PurchaseOptions {
    // MARK: Properties

    private var _options: Any?

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    var options: Set<Product.PurchaseOption>? {
        _options as? Set<Product.PurchaseOption>
    }

    // MARK: Initialization

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(options: Set<Product.PurchaseOption>) {
        self._options = options
    }
}
