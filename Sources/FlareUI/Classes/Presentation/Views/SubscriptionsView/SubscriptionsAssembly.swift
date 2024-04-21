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
    private let storeButtonsAssembly: IStoreButtonsAssembly
    private let subscriptionStatusVerifierProvider: ISubscriptionStatusVerifierProvider

    // MARK: Initialization

    init(
        iap: IFlare,
        storeButtonsAssembly: IStoreButtonsAssembly,
        subscriptionStatusVerifierProvider: ISubscriptionStatusVerifierProvider
    ) {
        self.iap = iap
        self.storeButtonsAssembly = storeButtonsAssembly
        self.subscriptionStatusVerifierProvider = subscriptionStatusVerifierProvider
    }

    // MARK: ISubscriptionAssembly

    func assemble(ids: some Collection<String>) -> AnyView {
        let viewModelFactory = SubscriptionsViewModelViewFactory(
            subscriptionStatusVerifier: subscriptionStatusVerifierProvider.subscriptionStatusVerifier
        )
        let presenter = SubscriptionsPresenter(iap: iap, ids: ids, viewModelFactory: viewModelFactory)
        let viewModel = WrapperViewModel(
            model: SubscriptionsViewModel(
                state: .loading,
                selectedProductID: ids.first,
                presenter: presenter
            )
        )
        presenter.viewModel = viewModel
        return ViewWrapper<SubscriptionsViewModel, SubscriptionsWrapperView>(viewModel: viewModel)
            .environment(\.storeButtonsAssembly, storeButtonsAssembly)
            .eraseToAnyView()
    }
}
