//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductPresenter

protocol IProductPresenter {
    func viewDidLoad()
    func purchase(productID id: String) async
}

// MARK: - ProductPresenter

final class ProductPresenter {
    // MARK: Properties

    private let id: String
    private let iap: IFlare

    weak var viewModel: ViewModel<ProductViewModel>?

    // MARK: Initialization

    init(
        id: String,
        iap: IFlare
    ) {
        self.id = id
        self.iap = iap
    }

    // MARK: Private

    private func update(state: ProductViewModel.State) {
        guard let viewModel else { return }
        viewModel.model = viewModel.model.setState(state)
    }
}

// MARK: IProductPresenter

extension ProductPresenter: IProductPresenter {
    func viewDidLoad() {
        update(state: .loading)

        iap.fetch(productIDs: [id]) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(product):
                guard let viewModel = self.viewModel, let product = product.first else { return }

                viewModel.model = viewModel.model.setState(.product(product))
            case let .failure(error):
                break
            }
        }
    }

    @MainActor
    func purchase(productID _: String) async {
        guard case let .product(product) = viewModel?.model.state else {
            // Throw an error
            return
        }

        do {
            let transaction = try await iap.purchase(product: product)
            await iap.finish(transaction: transaction)
        } catch {
            print(error.localizedDescription)
        }
    }
}
