//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ProductViewModel

struct ProductViewModel: IModel {
    enum State: Equatable {
        case loading
        case product(StoreProduct)
        case error(IAPError)
    }

    let state: State
    let presenter: IProductPresenter
}

extension ProductViewModel {
    func setState(_ state: State) -> ProductViewModel {
        ProductViewModel(state: state, presenter: presenter)
    }
}
