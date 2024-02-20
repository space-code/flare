//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - IProductsViewAssembly

protocol IProductsViewAssembly {
    func assemble(ids: Set<String>) -> ViewWrapper<ProductsViewModel, ProductsView>
}

// MARK: - ProductsViewAssembly

final class ProductsViewAssembly: IProductsViewAssembly {
    // MARK: Properties

    private let iap: IFlare

    // MARK: Initialization

    init(iap: IFlare) {
        self.iap = iap
    }

    // MARK: IProductsViewAssembly

    func assemble(ids: Set<String>) -> ViewWrapper<ProductsViewModel, ProductsView> {
        let presenter = ProductsPresenter(
            ids: ids,
            iap: iap,
            viewModelFactory: ProductsViewModelFactory()
        )
        let viewModel = ViewModel<ProductsViewModel>(
            model: ProductsViewModel(isLoading: false, products: [], presenter: presenter)
        )
        presenter.viewModel = viewModel

        return ViewWrapper<ProductsViewModel, ProductsView>(
            viewModel: viewModel
        )
    }
}
