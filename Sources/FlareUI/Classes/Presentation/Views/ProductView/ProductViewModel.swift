//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ProductViewModel

struct ProductViewModel {
    enum State {
        case loading
        case product(StoreProduct)
    }

    let state: State
    let presenter: IProductPresenter
}

extension ProductViewModel {
    func setState(_ state: State) -> ProductViewModel {
        ProductViewModel(state: state, presenter: presenter)
    }
}
