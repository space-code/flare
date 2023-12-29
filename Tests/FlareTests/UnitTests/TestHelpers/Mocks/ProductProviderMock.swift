//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit

final class ProductProviderMock: IProductProvider {
    var invokedFetch = false
    var invokedFetchCount = 0
    var invokedFetchParameters: (productIDs: Set<String>, requestID: String, completion: ProductsHandler)?
    var invokedFetchParamtersList = [(productIDs: Set<String>, requestID: String, completion: ProductsHandler)]()
    var stubbedFetchResult: Result<[SK1StoreProduct], IAPError>?

    func fetch(productIDs: Set<String>, requestID: String, completion: @escaping ProductsHandler) {
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
    var invokedAsyncFetchParameters: (productIDs: Set<String>, Void)?
    var invokedAsyncFetchParamtersList = [(productIDs: Set<String>, Void)]()
    var stubbedAsyncFetchResult: Result<[ISKProduct], Error>?

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func fetch(productIDs: Set<String>) async throws -> [SK2StoreProduct] {
        invokedAsyncFetch = true
        invokedAsyncFetchCount += 1
        invokedAsyncFetchParameters = (productIDs, ())
        invokedAsyncFetchParamtersList.append((productIDs, ()))

        switch stubbedAsyncFetchResult {
        case let .success(products):
            if let products = products as? [SK2StoreProduct] {
                return products
            } else {
                return []
            }
        case let .failure(error):
            throw error
        default:
            return []
        }
    }
}
