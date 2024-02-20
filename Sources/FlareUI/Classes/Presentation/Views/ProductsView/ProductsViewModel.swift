//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

struct ProductsViewModel {
    let isLoading: Bool
    let products: [ProductView.ViewModel]
    let presenter: IProductsPresenter
}
