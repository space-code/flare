//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IStoreButtonAssembly

protocol IStoreButtonAssembly {
    @MainActor
    func assemble(storeButtonType: StoreButton) -> ViewWrapper<StoreButtonViewModel, StoreButtonView>
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

    @MainActor
    func assemble(storeButtonType: StoreButton) -> ViewWrapper<StoreButtonViewModel, StoreButtonView> {
        let presenter = StoreButtonPresenter(iap: iap)
        let viewModel = WrapperViewModel<StoreButtonViewModel>(
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

    private func map(storeButtonType: StoreButton) -> StoreButtonViewModel.State {
        switch storeButtonType {
        case .restore:
            .restore(viewModel: .init(title: L10n.StoreButton.restorePurchases))
        }
    }
}
