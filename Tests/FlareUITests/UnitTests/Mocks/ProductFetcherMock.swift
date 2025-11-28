//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
@testable import FlareUI
import Foundation

final class ProductFetcherMock: IProductFetcherStrategy {
    var invokedProduct = false
    var invokedProductCount = 0
    var stubbedThrowProduct: Error?
    var stubbedProduct: StoreProduct!

    func product() async throws -> StoreProduct {
        invokedProduct = true
        invokedProductCount += 1
        if let stubbedThrowProduct {
            throw stubbedThrowProduct
        }
        return stubbedProduct
    }
}
