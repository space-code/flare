//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
@testable import FlareUI

final class ProductPurchaseServiceMock: IProductPurchaseService {
    var invokedPurchase = false
    var invokedPurchaseCount = 0
    var invokedPurchaseParameters: (product: StoreProduct, options: PurchaseOptions?)?
    var invokedPurchaseParametersList = [(product: StoreProduct, options: PurchaseOptions?)]()
    var stubbedPurchaseError: Error?
    var stubbedPurchase: StoreTransaction = .fake()

    func purchase(product: StoreProduct, options: PurchaseOptions?) async throws -> StoreTransaction {
        invokedPurchase = true
        invokedPurchaseCount += 1
        invokedPurchaseParameters = (product, options)
        invokedPurchaseParametersList.append((product, options))
        if let stubbedPurchaseError {
            throw stubbedPurchaseError
        }
        return stubbedPurchase
    }
}
