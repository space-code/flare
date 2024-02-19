//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - IProductsViewAssembly

protocol IProductsViewAssembly {
    func assemble(ids: Set<String>) -> ProductsView
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

    func assemble(ids: Set<String>) -> ProductsView {
        let presenter = ProductsPresenter(
            ids: ids,
            iap: iap,
            viewModel: ViewModel(model: ProductsViewModel.initial)
        )
        return ProductsView(presenter: presenter)
    }
}
