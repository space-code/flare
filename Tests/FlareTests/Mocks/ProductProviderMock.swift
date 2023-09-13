//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import class StoreKit.SKProduct

final class ProductProviderMock: IProductProvider {
    var invokedFetch = false
    var invokedFetchCount = 0
    var invokedFetchParameters: (productIDs: Set<String>, requestID: String, completion: ProductsHandler)?
    var invokedFetchParamtersList = [(productIDs: Set<String>, requestID: String, completion: ProductsHandler)]()
    var stubbedFetchResult: Result<[SKProduct], IAPError>?

    func fetch(productIDs: Set<String>, requestID: String, completion: @escaping ProductsHandler) {
        invokedFetch = true
        invokedFetchCount += 1
        invokedFetchParameters = (productIDs, requestID, completion)
        invokedFetchParamtersList.append((productIDs, requestID, completion))

        if let result = stubbedFetchResult {
            completion(result)
        }
    }
}
