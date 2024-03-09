//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

// MARK: - IProductPurchaseService

protocol IProductPurchaseService {
    func purchase(product: StoreProduct, options: PurchaseOptions?) async throws -> StoreTransaction
}

// MARK: - ProductPurchaseService

actor ProductPurchaseService: IProductPurchaseService {
    // MARK: Types

    enum Error: Swift.Error {
        case alreadyExecuted
    }

    // MARK: Properties

    private var iap: IFlare

    private var isExecuted = false

    // MARK: Initialization

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
