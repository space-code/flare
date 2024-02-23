//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - IProductsViewAssembly

protocol IProductsViewAssembly {
    func assemble(ids: Set<String>) -> ViewWrapper<ProductsViewModel, ProductsView>
}

// MARK: - ProductsViewAssembly

final class ProductsViewAssembly: IProductsViewAssembly {
    // MARK: Properties

    private let productAssembly: IProductViewAssembly

    // MARK: Initializaiton

    init(productAssembly: IProductViewAssembly) {
        self.productAssembly = productAssembly
    }

    // MARK: IProductsViewAssembly

    func assemble(ids: Set<String>) -> ViewWrapper<ProductsViewModel, ProductsView> {
        let presenter = ProductsPresenter(
            ids: ids
        )
        let viewModel = ViewModel<ProductsViewModel>(
            model: ProductsViewModel(
                state: .productIDs(ids: ids),
                presenter: presenter,
                productAssembly: productAssembly
            )
        )
        presenter.viewModel = viewModel

        return ViewWrapper<ProductsViewModel, ProductsView>(
            viewModel: viewModel
        )
    }
}
