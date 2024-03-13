//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ProductsViewModel

struct ProductsViewModel: IModel {
    enum State: Equatable {
        case loading(Int)
        case products([StoreProduct])
        case error(IAPError)
    }

    let state: State
    let presenter: IProductsPresenter
}

extension ProductsViewModel {
    func setState(_ state: State) -> ProductsViewModel {
        ProductsViewModel(
            state: state,
            presenter: presenter
        )
    }
}
