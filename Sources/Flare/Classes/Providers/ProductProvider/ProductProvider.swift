//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Concurrency
import StoreKit

// MARK: - ProductProvider

final class ProductProvider: NSObject, IProductProvider {
    // MARK: Lifecycle

    init(dispatchQueueFactory: IDispatchQueueFactory = DispatchQueueFactory()) {
        self.dispatchQueueFactory = dispatchQueueFactory
    }

    // MARK: Internal

    func fetch(productIDs ids: Set<String>, requestID: String, completion: @escaping ProductsHandler) {
        let request = makeRequest(ids: ids, requestID: requestID)
        fetch(request: request, completion: completion)
    }

    // MARK: Private

    private var handlers: [String: ProductsHandler] = [:]
    private let dispatchQueueFactory: IDispatchQueueFactory

    private lazy var dispatchQueue: IDispatchQueue = dispatchQueueFactory.privateQueue(label: String(describing: self))

    private func makeRequest(ids: Set<String>, requestID: String) -> SKProductsRequest {
        let request = SKProductsRequest(productIdentifiers: ids)
        request.id = requestID
        request.delegate = self
        return request
    }

    private func fetch(request: SKProductsRequest, completion: @escaping ProductsHandler) {
        dispatchQueue.async {
            self.handlers[request.id] = completion
            self.dispatchQueueFactory.main().async {
                request.start()
            }
        }
    }
}

// MARK: SKProductsRequestDelegate

extension ProductProvider: SKProductsRequestDelegate {
    func request(_ request: SKRequest, didFailWithError error: Error) {
        dispatchQueue.async {
            let handler = self.handlers.removeValue(forKey: request.id)
            self.dispatchQueueFactory.main().async {
                handler?(.failure(IAPError(error: error)))
            }
        }
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        dispatchQueue.async {
            let handler = self.handlers.removeValue(forKey: request.id)

            guard response.invalidProductIdentifiers.isEmpty else {
                self.dispatchQueueFactory.main().async {
                    handler?(.failure(.invalid(productIds: response.invalidProductIdentifiers)))
                }
                return
            }

            self.dispatchQueueFactory.main().async {
                handler?(.success(response.products))
            }
        }
    }
}
