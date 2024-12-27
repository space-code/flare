//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

// MARK: - IProductPurchaseService

/// A protocol for handling product purchases.
protocol IProductPurchaseService {
    /// Purchases a product with optional purchase options asynchronously.
    ///
    /// - Parameters:
    ///   - product: The product to purchase.
    ///   - options: Optional purchase options.
    ///
    /// - Returns: A `StoreTransaction` representing the purchase transaction.
    func purchase(product: StoreProduct, options: PurchaseOptions?) async throws -> StoreTransaction
}

// MARK: - ProductPurchaseService

/// An actor for handling product purchases.
actor ProductPurchaseService: IProductPurchaseService {
    // MARK: Types

    enum Error: Swift.Error {
        case alreadyExecuted
    }

    // MARK: Properties

    /// The in-app purchase service.
    #if swift(>=6.0)
        private nonisolated(unsafe) var iap: IFlare
    #else
        private var iap: IFlare
    #endif

    private var isExecuted = false

    // MARK: Initialization

    /// Initializes the purchase service with the given dependencies.
    ///
    /// - Parameters:
    ///   - iap: The in-app purchase service.
    init(iap: IFlare) {
        self.iap = iap
    }

    // MARK: IPurchaseService

    func purchase(product: StoreProduct, options: PurchaseOptions?) async throws -> StoreTransaction {
        guard !isExecuted else { throw Error.alreadyExecuted }

        isExecuted = true
        defer { isExecuted = false }

        return try await _purchase(product: product, options: options)
    }

    // MARK: Private

    private func _purchase(product: StoreProduct, options: PurchaseOptions?) async throws -> StoreTransaction {
        if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *), let options = options?.options {
            return try await iap.purchase(product: product, options: options)
        } else {
            return try await iap.purchase(product: product)
        }
    }
}
