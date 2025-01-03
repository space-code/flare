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

// swiftlint:disable file_types_order

// MARK: - SubscriptionsAssembly

#if swift(>=6.0)
    @available(watchOS, unavailable)
    final class SubscriptionsAssembly: @preconcurrency ISubscriptionsAssembly {
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

        @MainActor
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
#else
    @available(watchOS, unavailable)
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

        @MainActor
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
#endif

// swiftlint:enable file_types_order
