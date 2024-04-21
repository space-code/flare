//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - IProductsViewAssembly

protocol IProductsViewAssembly {
    func assemble(ids: some Collection<String>) -> AnyView
}

// MARK: - ProductsViewAssembly

final class ProductsViewAssembly: IProductsViewAssembly {
    // MARK: Properties

    private let storeButtonsAssembly: IStoreButtonsAssembly
    private let productAssembly: IProductViewAssembly
    private let iap: IFlare

    // MARK: Initialization

    init(productAssembly: IProductViewAssembly, storeButtonsAssembly: IStoreButtonsAssembly, iap: IFlare) {
        self.productAssembly = productAssembly
        self.storeButtonsAssembly = storeButtonsAssembly
        self.iap = iap
    }

    // MARK: IProductsViewAssembly

    func assemble(ids: some Collection<String>) -> AnyView {
        let presenter = ProductsPresenter(
            ids: ids,
            iap: iap
        )
        let viewModel = WrapperViewModel<ProductsViewModel>(
            model: ProductsViewModel(
                state: .loading(ids.count),
                presenter: presenter
            )
        )
        presenter.viewModel = viewModel

        return ViewWrapper<ProductsViewModel, ProductsWrapperView>(viewModel: viewModel)
            .environment(\.productViewAssembly, productAssembly)
            .environment(\.storeButtonsAssembly, storeButtonsAssembly)
            .eraseToAnyView()
    }
}
