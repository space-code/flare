//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ProductViewModel

/// A view model for managing a product.
struct ProductViewModel: IModel {
    /// The state of the view model.
    enum State: Equatable {
        /// Loading state.
        case loading
        /// Loaded product state.
        case product(StoreProduct)
        /// Error state.
        case error(IAPError)
    }

    /// The current state of the view model.
    let state: State
    /// The presenter for the product.
    let presenter: IProductPresenter
}

extension ProductViewModel {
    /// Sets the state of the view model and returns a new instance with the updated state.
    ///
    /// - Parameter state: The new state of the view model.
    /// - Returns: A new `ProductViewModel` instance with the updated state.
    func setState(_ state: State) -> ProductViewModel {
        ProductViewModel(state: state, presenter: presenter)
    }
}
