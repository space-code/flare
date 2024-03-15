//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - ISubscriptionsAssembly

protocol ISubscriptionsAssembly {
    func assemble(ids: some Collection<String>) -> AnyView
}

// MARK: - SubscriptionsAssembly

final class SubscriptionsAssembly: ISubscriptionsAssembly {
    // MARK: Properties

    private let iap: IFlare
    private let storeButtonAssembly: IStoreButtonAssembly

    // MARK: Initialization

    init(iap: IFlare, storeButtonAssembly: IStoreButtonAssembly) {
        self.iap = iap
        self.storeButtonAssembly = storeButtonAssembly
    }

    // MARK: ISubscriptionAssembly

    func assemble(ids: some Collection<String>) -> AnyView {
        let presenter = SubscriptionsPresenter(iap: iap, ids: ids, viewModelFactory: SubscriptionsViewModelViewFactory())
        let viewModel = ViewModel(
            model: SubscriptionsViewModel(
                state: .loading,
                selectedProductID: ids.first,
                presenter: presenter
            )
        )
        presenter.viewModel = viewModel
        return ViewWrapper<SubscriptionsViewModel, SubscriptionsWrapperView>(viewModel: viewModel)
            .environment(\.storeButtonAssembly, storeButtonAssembly)
            .eraseToAnyView()
    }
}
