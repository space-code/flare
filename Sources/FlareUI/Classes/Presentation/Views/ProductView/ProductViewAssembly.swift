//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - IProductViewAssembly

protocol IProductViewAssembly {
    func assemble(id: String) -> ViewWrapper<ProductViewModel, ProductView>
}

// MARK: - ProductViewAssembly

final class ProductViewAssembly: IProductViewAssembly {
    // MARK: Properties

    private let iap: IFlare

    // MARK: Initialization

    init(iap: IFlare) {
        self.iap = iap
    }

    // MARK: IProductViewAssembly

    func assemble(id: String) -> ViewWrapper<ProductViewModel, ProductView> {
        let presenter = ProductPresenter(
            id: id,
            iap: iap
        )
        let viewModel = ViewModel<ProductViewModel>(
            model: ProductViewModel(state: .loading, presenter: presenter)
        )
        presenter.viewModel = viewModel

        return ViewWrapper<ProductViewModel, ProductView>(
            viewModel: viewModel
        )
    }
}
