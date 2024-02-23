//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductViewModelFactory

protocol IProductViewModelFactory {
    func make(_ product: StoreProduct) -> ProductInfoView.ViewModel
}

// MARK: - ProductViewModelFactory

final class ProductViewModelFactory: IProductViewModelFactory {
    func make(_ product: StoreProduct) -> ProductInfoView.ViewModel {
        ProductInfoView.ViewModel(
            id: product.productIdentifier,
            title: product.localizedTitle,
            description: product.localizedDescription,
            price: product.localizedPriceString ?? ""
        )
    }
}
