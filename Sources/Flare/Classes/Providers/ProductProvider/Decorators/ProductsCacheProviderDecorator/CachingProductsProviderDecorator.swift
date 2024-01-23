//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Atomic
import Foundation

// MARK: - CachingProductsProviderDecorator

/// `CachingProductsProviderDecorator` is a decorator class that adds caching functionality to an `IProductProvider`.
final class CachingProductsProviderDecorator {
    // MARK: Properties

    /// Atomic property for thread-safe access to the cache dictionary.
    @Atomic
    private var cache: [String: StoreProduct] = [:]

    /// The product provider.
    private let productProvider: IProductProvider

    // MARK: Initialization

    /// Creates a `CachingProductsProviderDecorator`instance.
    ///
    /// - Parameter productProvider: The product provider.
    init(productProvider: IProductProvider) {
        self.productProvider = productProvider
    }

    // MARK: Private

    /// Caches the provided array of products.
    ///
    /// - Parameter products: The array of products to be cached.
    private func cache(products: [StoreProduct]) {
        products.forEach { _cache.wrappedValue[$0.productIdentifier] = $0 }
    }

    /// Retrieves cached products for the given set of product IDs.
    ///
    /// - Parameter ids: The set of product IDs to retrieve cached products for.
    ///
    /// - Returns: A dictionary containing cached products for the specified IDs.
    private func cachedProducts(ids: Set<String>) -> [String: StoreProduct] {
        let cachedProducts = _cache.wrappedValue.filter { ids.contains($0.key) }
        return cachedProducts
    }

    /// Checks the cache for specified product IDs and fetches missing products from the product provider.
    ///
    /// - Parameters:
    ///   - productIDs: The set of product IDs to check the cache for.
    ///   - fetcher: A closure to fetch missing products from the product provider.
    ///   - completion: A closure to be called with the fetched products or an error.
    private func checkCache(
        for productIDs: Set<String>,
        fetcher: (Set<String>, @escaping (Result<[StoreProduct], IAPError>) -> Void) -> Void,
        completion: @escaping ProductsHandler
    ) {
        let cachedProducts = cachedProducts(ids: productIDs)
        let missingProducts = productIDs.subtracting(cachedProducts.keys)

        if missingProducts.isEmpty {
            completion(.success(Array(cachedProducts.values)))
        } else {
            fetcher(missingProducts) { [weak self] result in
                switch result {
                case let .success(products):
                    self?.cache(products: products)
                    completion(.success(products))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}

// MARK: ICachingProductsProviderDecorator

extension CachingProductsProviderDecorator: ICachingProductsProviderDecorator {
    func fetch(productIDs: Set<String>, requestID: String, completion: @escaping ProductsHandler) {
        checkCache(
            for: productIDs,
            fetcher: { [weak self] ids, completion in
                self?.productProvider.fetch(productIDs: ids, requestID: requestID, completion: completion)
            }, completion: completion
        )
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func fetch(productIDs: Set<String>) async throws -> [StoreProduct] {
        try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else {
                continuation.resume(throwing: IAPError.unknown)
                return
            }

            self.checkCache(
                for: productIDs,
                fetcher: { _, completion in
                    AsyncHandler.call(
                        completion: { result in
                            switch result {
                            case let .success(products):
                                completion(.success(products))
                            case let .failure(error):
                                completion(.failure(IAPError.with(error: error)))
                            }
                        },
                        asyncMethod: {
                            try await self.productProvider.fetch(productIDs: productIDs)
                        }
                    )
                },
                completion: { result in
                    continuation.resume(with: result)
                }
            )
        }
    }
}
