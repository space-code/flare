//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - SubscriptionsViewModel

struct SubscriptionsViewModel: IModel {
    enum State: Equatable {
        case loading
        case products([SubscriptionView.ViewModel])
        case error(IAPError)
    }

    var numberOfProducts: Int {
        if case let .products(array) = state {
            return array.count
        }
        return .zero
    }

    let state: State
    let selectedProductID: String?
    let presenter: ISubscriptionsPresenter
}

extension SubscriptionsViewModel {
    func setState(_ state: State) -> SubscriptionsViewModel {
        SubscriptionsViewModel(
            state: state,
            selectedProductID: selectedProductID,
            presenter: presenter
        )
    }

    func setSelectedProductID(_ selectedProductID: String?) -> SubscriptionsViewModel {
        SubscriptionsViewModel(
            state: state,
            selectedProductID: selectedProductID,
            presenter: presenter
        )
    }
}
