//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - SortingProductsProviderDecorator

final class SortingProductsProviderDecorator {
    // MARK: Properties

    private let productProvider: IProductProvider

    // MARK: Initialization

    init(productProvider: IProductProvider) {
        self.productProvider = productProvider
    }

    // MARK: Private

    private func sort(productIDs: some Collection<String>, products: [StoreProduct]) -> [StoreProduct] {
        var sortedProducts: [StoreProduct] = []
        var set = Set(productIDs)

        for productID in productIDs {
            if set.contains(productID), let product = products.by(id: productID) {
                sortedProducts.append(product)
                set.remove(productID)
            }
        }

        return sortedProducts
    }
}

// MARK: ISortingProductsProviderDecorator

extension SortingProductsProviderDecorator: ISortingProductsProviderDecorator {
    func fetch(
        productIDs: some Collection<String>,
        requestID: String,
        completion: @escaping ProductsHandler
    ) {
        let productIDs = Array(productIDs)

        productProvider.fetch(productIDs: productIDs, requestID: requestID) { [weak self] result in
            guard let self else { return }

            switch result {
            case let .success(products):
                let sortedProducts = self.sort(productIDs: productIDs, products: products)
                completion(.success(sortedProducts))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func fetch(productIDs: some Collection<String>) async throws -> [StoreProduct] {
        let products = try await productProvider.fetch(productIDs: productIDs)
        return sort(productIDs: productIDs, products: products)
    }
}

// MARK: Private

private extension Array where Element: StoreProduct {
    func by(id: String) -> StoreProduct? {
        first(where: { $0.productIdentifier == id })
    }
}

// MARK: - SortingProductsProviderDecorator + @unchecked Sendable

extension SortingProductsProviderDecorator: @unchecked Sendable {}
