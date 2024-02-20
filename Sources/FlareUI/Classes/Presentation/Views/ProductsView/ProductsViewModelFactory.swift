//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductsViewModelFactory

protocol IProductsViewModelFactory {
    func make(_ products: [StoreProduct]) -> [ProductView.ViewModel]
}

// MARK: - ProductsViewModelFactory

final class ProductsViewModelFactory: IProductsViewModelFactory {
    func make(_ products: [StoreProduct]) -> [ProductView.ViewModel] {
        products.map { product in
            ProductView.ViewModel(
                id: product.productIdentifier,
                title: product.localizedTitle,
                description: product.localizedDescription,
                price: product.localizedPriceString ?? ""
            )
        }
    }
}
