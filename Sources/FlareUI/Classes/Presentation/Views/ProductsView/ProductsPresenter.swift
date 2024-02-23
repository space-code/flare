//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductsPresenter

protocol IProductsPresenter {
    func viewDidLoad()
}

// MARK: - ProductsPresenter

final class ProductsPresenter {
    // MARK: Properties

    private let ids: Set<String>

    weak var viewModel: ViewModel<ProductsViewModel>?

    // MARK: Initialization

    init(
        ids: Set<String>
    ) {
        self.ids = ids
    }

    // MARK: Private

    private func update(state: ProductsViewModel.State) {
        guard let viewModel else { return }
        viewModel.model = viewModel.model.setState(state)
    }
}

// MARK: IProductsPresenter

extension ProductsPresenter: IProductsPresenter {
    func viewDidLoad() {
        update(state: .productIDs(ids: ids))
    }
}
