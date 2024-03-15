//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit

final class ProductProviderMock: IProductProvider {
    var invokedFetch = false
    var invokedFetchCount = 0
    var invokedFetchParameters: (productIDs: Any, requestID: String, completion: ProductsHandler)?
    var invokedFetchParamtersList = [(productIDs: Any, requestID: String, completion: ProductsHandler)]()
    var stubbedFetchResult: Result<[StoreProduct], IAPError>?

    func fetch(productIDs: some Collection<String>, requestID: String, completion: @escaping ProductsHandler) {
        invokedFetch = true
        invokedFetchCount += 1
        invokedFetchParameters = (productIDs, requestID, completion)
        invokedFetchParamtersList.append((productIDs, requestID, completion))

        if let result = stubbedFetchResult {
            completion(result)
        }
    }

    var invokedAsyncFetch = false
    var invokedAsyncFetchCount = 0
    var invokedAsyncFetchParameters: (productIDs: Any, Void)?
    var invokedAsyncFetchParamtersList = [(productIDs: Any, Void)]()
    var stubbedAsyncFetchResult: Result<[StoreProduct], Error>?

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func fetch(productIDs: some Collection<String>) async throws -> [StoreProduct] {
        invokedAsyncFetch = true
        invokedAsyncFetchCount += 1
        invokedAsyncFetchParameters = (productIDs, ())
        invokedAsyncFetchParamtersList.append((productIDs, ()))

        switch stubbedAsyncFetchResult {
        case let .success(products):
            return products
        case let .failure(error):
            throw error
        default:
            return []
        }
    }
}
