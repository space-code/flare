//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ISubscriptionsPresenter

protocol ISubscriptionsPresenter {
    func viewDidLoad()
}

// MARK: - SubscriptionsPresenter

final class SubscriptionsPresenter: IPresenter {
    // MARK: Properties

    private let iap: IFlare
    private let ids: any Collection<String>

    weak var viewModel: ViewModel<SubscriptionsViewModel>?

    // MARK: Initialization

    init(iap: IFlare, ids: some Collection<String>) {
        self.iap = iap
        self.ids = ids
    }
}

// MARK: ISubscriptionsPresenter

extension SubscriptionsPresenter: ISubscriptionsPresenter {
    func viewDidLoad() {
        Task { @MainActor in
            do {
                let products = try await iap.fetch(productIDs: ids)
                    .filter { $0.productCategory == .subscription }

                if products.isEmpty {
                    update(state: .error(.storeProductNotAvailable))
                }

                update(state: .products(products))
            } catch {
                update(state: .error(error.iap))
            }
        }
    }
}
