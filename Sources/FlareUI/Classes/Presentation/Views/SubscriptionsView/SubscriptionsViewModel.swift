//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - SubscriptionsViewModel

/// A view model for managing subscriptions.
@available(watchOS, unavailable)
struct SubscriptionsViewModel: IModel, Sendable {
    /// The state of the view model.
    enum State: Equatable {
        /// Loading state.
        case loading
        /// Loaded products state.
        case products([SubscriptionView.ViewModel])
        /// Error state.
        case error(IAPError)
    }

    /// The current state of the view model.
    let state: State
    /// The selected product ID.
    let selectedProductID: String?
    /// The presenter for the subscriptions.
    let presenter: ISubscriptionsPresenter

    /// The number of products in the loaded state.
    var numberOfProducts: Int {
        if case let .products(array) = state {
            return array.count
        }
        return 0
    }
}

@available(watchOS, unavailable)
extension SubscriptionsViewModel {
    /// Sets the state of the view model and returns a new instance with the updated state.
    ///
    /// - Parameter state: The new state of the view model.
    /// - Returns: A new `SubscriptionsViewModel` instance with the updated state.
    func setState(_ state: State) -> SubscriptionsViewModel {
        SubscriptionsViewModel(
            state: state,
            selectedProductID: selectedProductID,
            presenter: presenter
        )
    }

    /// Sets the selected product ID and returns a new instance with the updated selected product ID.
    ///
    /// - Parameter selectedProductID: The selected product ID.
    /// - Returns: A new `SubscriptionsViewModel` instance with the updated selected product ID.
    func setSelectedProductID(_ selectedProductID: String?) -> SubscriptionsViewModel {
        SubscriptionsViewModel(
            state: state,
            selectedProductID: selectedProductID,
            presenter: presenter
        )
    }
}
