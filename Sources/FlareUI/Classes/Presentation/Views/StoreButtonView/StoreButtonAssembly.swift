//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IStoreButtonAssembly

protocol IStoreButtonAssembly {
    func assemble(storeButtonType: StoreButtonType) -> ViewWrapper<StoreButtonViewModel, StoreButtonView>
}

// MARK: - StoreButtonAssembly

final class StoreButtonAssembly: IStoreButtonAssembly {
    // MARK: Properties

    private let iap: IFlare

    // MARK: Initialization

    init(iap: IFlare) {
        self.iap = iap
    }

    // MARK: IStoreButtonAssembly

    func assemble(storeButtonType: StoreButtonType) -> ViewWrapper<StoreButtonViewModel, StoreButtonView> {
        let presenter = StoreButtonPresenter(iap: iap)
        let viewModel = ViewModel<StoreButtonViewModel>(
            model: StoreButtonViewModel(
                state: map(storeButtonType: storeButtonType),
                presenter: presenter
            )
        )
        presenter.viewModel = viewModel

        return ViewWrapper<StoreButtonViewModel, StoreButtonView>(
            viewModel: viewModel
        )
    }

    // MARK: Private

    private func map(storeButtonType: StoreButtonType) -> StoreButtonViewModel.State {
        switch storeButtonType {
        case .restore:
            return .restore(viewModel: .init(title: "Restore Missing Purchases"))
        }
    }
}
