//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Atomic
import Concurrency
import StoreKit

// MARK: - ProductProvider

/// A class is responsible for fetching StoreKit products.
///
/// This implementation supports two ways of fetching products using the old way API and the new StoreKit2 API.
///
/// Example:
///
/// ```
/// let productProvider = ProductProvider()
/// productProvider.fetch(productIDs: ["productID"], requestID: UUID().uuidString) { result in
///     switch result {
///     case let .success(products):
///         // The `products` array contains all fetched products with the given IDs.
///     case let .failure(error):
///         // An error occurred; you can handle it here.
///     }
/// }
/// ```
final class ProductProvider: NSObject, IProductProvider {
    // MARK: Lifecycle

    /// Creates a new `ProductProvider` instance.
    ///
    /// - Parameter dispatchQueueFactory: The dispatch queue factory.
    init(dispatchQueueFactory: IDispatchQueueFactory = DispatchQueueFactory()) {
        self.dispatchQueueFactory = dispatchQueueFactory
    }

    // MARK: Internal

    func fetch(productIDs ids: some Collection<String>, requestID: String, completion: @escaping ProductsHandler) {
        let request = makeRequest(ids: ids, requestID: requestID)
        fetch(request: request, completion: completion)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func fetch(productIDs ids: some Collection<String>) async throws -> [StoreProduct] {
        try await StoreKit.Product.products(for: ids).map { StoreProduct(product: $0) }
    }

    // MARK: Private

    /// Dictionary to store request handlers with their corresponding request IDs.
    private var handlers: [ProductsRequest: ProductsHandler] = [:]
    /// The dispatch queue factory for handling concurrent tasks.
    private let dispatchQueueFactory: IDispatchQueueFactory

    /// Lazy-initialized private dispatch queue for handling tasks related to product fetching.
    private lazy var dispatchQueue: IDispatchQueue = dispatchQueueFactory.privateQueue(label: String(describing: self))

    /// Creates a StoreKit product request with the specified product IDs and request ID.
    ///
    /// - Parameters:
    ///   - ids: The set of product IDs to include in the request.
    ///   - requestID: The identifier for the request.
    /// - Returns: An instance of `SKProductsRequest`.
    private func makeRequest(ids: some Collection<String>, requestID: String) -> SKProductsRequest {
        let request = SKProductsRequest(productIdentifiers: Set(ids))
        request.id = requestID
        request.delegate = self
        return request
    }

    /// Initiates the product fetch request and handles the associated completion closure.
    ///
    /// - Parameters:
    ///   - request: The `SKProductsRequest` to be initiated.
    ///   - completion: A closure to be called upon completion with the fetched products.
    private func fetch(request: SKProductsRequest, completion: @escaping ProductsHandler) {
        dispatchQueue.async {
            self.handlers[request.request] = completion
            self.dispatchQueueFactory.main().async {
                request.start()
            }
        }
    }

    private func handleFetchResult(
        result: Result<[some ISKProduct], some Error>,
        _ completion: @escaping (Result<[StoreProduct], IAPError>) -> Void
    ) {
        switch result {
        case let .success(products):
            completion(.success(products.map { StoreProduct($0) }))
        case let .failure(error):
            if let iapError = error as? IAPError {
                completion(.failure(iapError))
            } else {
                completion(.failure(IAPError(error: error)))
            }
        }
    }
}

// MARK: SKProductsRequestDelegate

extension ProductProvider: SKProductsRequestDelegate {
    func request(_ request: SKRequest, didFailWithError error: Error) {
        dispatchQueue.async {
            let handler = self.handlers.removeValue(forKey: request.request)

            self.dispatchQueueFactory.main().async {
                handler?(.failure(IAPError(error: error)))
            }
        }
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        dispatchQueue.async {
            let handler = self.handlers.removeValue(forKey: request.request)

            guard response.invalidProductIdentifiers.isEmpty else {
                self.dispatchQueueFactory.main().async {
                    handler?(.failure(.invalid(productIDs: response.invalidProductIdentifiers)))
                    Logger.error(message: L10n.Products.requestedProductsNotFound(response.invalidProductIdentifiers))
                }
                return
            }

            Logger.debug(message: L10n.Products.requestedProductsReceived(response.products.map(\.productIdentifier)))

            self.dispatchQueueFactory.main().async {
                handler?(.success(response.products.map { StoreProduct(skProduct: $0) }))
            }
        }
    }
}

// MARK: @unchecked Sendable

/// @unchecked because:
/// - It has mutable state, but it's made thread-safe through `queue`.
extension ProductProvider: @unchecked Sendable {}

// MARK: - Helpers

private extension SKRequest {
    var request: ProductsRequest {
        ProductsRequest(self)
    }
}

#if swift(>=5.8)
    #if hasFeature(RetroactiveAttribute)
        extension SKRequest: @unchecked @retroactive Sendable {}
        extension SKProductsRequest: @unchecked @retroactive Sendable {}
    #endif
#endif
