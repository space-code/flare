//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ProductsViewModel

/// A view model for managing products.
struct ProductsViewModel: IModel {
    /// The state of the view model.
    enum State: Equatable {
        /// Loading state with progress.
        case loading(Int)
        /// Loaded products.
        case products([StoreProduct])
        /// Error state.
        case error(IAPError)
    }

    /// The current state of the view model.
    let state: State
    /// The presenter for the products.
    let presenter: IProductsPresenter
}

extension ProductsViewModel {
    /// Sets the state of the view model and returns a new instance with the updated state.
    ///
    /// - Parameter state: The new state of the view model.
    /// - Returns: A new `ProductsViewModel` instance with the updated state.
    func setState(_ state: State) -> ProductsViewModel {
        ProductsViewModel(
            state: state,
            presenter: presenter
        )
    }
}
