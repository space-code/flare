//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ProductsViewModel

struct ProductsViewModel: IModel {
    enum State {
        case products([StoreProduct])
        case error(Error)
    }

    let state: State
    let presenter: IProductsPresenter
    let productAssembly: IProductViewAssembly
}

extension ProductsViewModel {
    func setState(_ state: State) -> ProductsViewModel {
        ProductsViewModel(state: state, presenter: presenter, productAssembly: productAssembly)
    }
}