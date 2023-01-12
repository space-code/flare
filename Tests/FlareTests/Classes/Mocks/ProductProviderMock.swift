//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare

final class ProductProviderMock: IProductProvider {
    var invokedFetch = false
    var invokedFetchCount = 0
    var invokedFetchParameters: (productIds: Set<String>, requestId: String, completion: ProductsHandler)?
    var invokedFetchParamtersList = [(productIds: Set<String>, requestId: String, completion: ProductsHandler)]()

    func fetch(productIds: Set<String>, requestId: String, completion: @escaping ProductsHandler) {
        invokedFetch = true
        invokedFetchCount += 1
        invokedFetchParameters = (productIds, requestId, completion)
        invokedFetchParamtersList.append((productIds, requestId, completion))
    }
}
