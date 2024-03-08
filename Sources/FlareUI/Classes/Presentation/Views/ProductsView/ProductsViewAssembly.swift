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

    private let storeButtonAssembly: IStoreButtonAssembly
    private let productAssembly: IProductViewAssembly
    private let iap: IFlare

    // MARK: Initialization

    init(productAssembly: IProductViewAssembly, storeButtonAssembly: IStoreButtonAssembly, iap: IFlare) {
        self.productAssembly = productAssembly
        self.storeButtonAssembly = storeButtonAssembly
        self.iap = iap
    }

    // MARK: IProductsViewAssembly

    func assemble(ids: Set<String>) -> ViewWrapper<ProductsViewModel, ProductsView> {
        let presenter = ProductsPresenter(
            ids: ids,
            iap: iap
        )
        let viewModel = ViewModel<ProductsViewModel>(
            model: ProductsViewModel(
                state: .products([]),
                presenter: presenter,
                productAssembly: productAssembly,
                storeButtonAssembly: storeButtonAssembly
            )
        )
        presenter.viewModel = viewModel

        return ViewWrapper<ProductsViewModel, ProductsView>(
            viewModel: viewModel
        )
    }
}
