//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

// MARK: - IProductFetcherStrategy

protocol IProductFetcherStrategy {
    func product() async throws -> StoreProduct
}

// MARK: - ProductStrategy

final class ProductStrategy: IProductFetcherStrategy {
    // MARK: Properties

    private let iap: IFlare
    private let type: ProductViewType

    // MARK: Initialization

    init(type: ProductViewType, iap: IFlare) {
        self.type = type
        self.iap = iap
    }

    // MARK: IProductStrategy

    func product() async throws -> StoreProduct {
        switch type {
        case let .productID(id):
            let product = try await iap.fetch(productIDs: [id]).first

            guard let product else { throw IAPError.storeProductNotAvailable }

            return product
        case let .product(product):
            return product
        }
    }
}
