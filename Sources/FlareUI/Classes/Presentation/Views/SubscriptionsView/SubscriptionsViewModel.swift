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
        case products([StoreProduct])
        case error(IAPError)
    }

    let state: State
    let presenter: ISubscriptionsPresenter
}

extension SubscriptionsViewModel {
    func setState(_ state: State) -> SubscriptionsViewModel {
        SubscriptionsViewModel(state: state, presenter: presenter)
    }
}
