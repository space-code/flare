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

    // MARK: Initialization

    init(iap: IFlare) {
        self.iap = iap
    }

    // MARK: ISubscriptionAssembly

    func assemble(ids: some Collection<String>) -> AnyView {
        let presenter = SubscriptionsPresenter(iap: iap, ids: ids)
        let viewModel = ViewModel(model: SubscriptionsViewModel(state: .loading, presenter: presenter))
        presenter.viewModel = viewModel
        return ViewWrapper<SubscriptionsViewModel, SubscriptionsWrapperView>(viewModel: viewModel)
            .eraseToAnyView()
    }
}
