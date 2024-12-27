//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - StoreButtonViewModel

struct StoreButtonViewModel: IModel, @unchecked Sendable {
    struct ViewModel: Equatable {
        let title: String
    }

    enum State: Equatable {
        case restore(viewModel: ViewModel)

        var title: String {
            switch self {
            case let .restore(viewModel):
                return viewModel.title
            }
        }
    }

    let state: State
    let presenter: IStoreButtonPresenter
}

extension StoreButtonViewModel {
    func setState(_ state: State) -> StoreButtonViewModel {
        StoreButtonViewModel(state: state, presenter: presenter)
    }
}
