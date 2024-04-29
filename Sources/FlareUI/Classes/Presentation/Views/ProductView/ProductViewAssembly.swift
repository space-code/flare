//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - IProductViewAssembly

protocol IProductViewAssembly {
    func assemble(id: String) -> ViewWrapper<ProductViewModel, ProductWrapperView>
    func assemble(storeProduct: StoreProduct) -> ViewWrapper<ProductViewModel, ProductWrapperView>
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

    func assemble(id: String) -> ViewWrapper<ProductViewModel, ProductWrapperView> {
        assemble(with: .productID(id))
    }

    func assemble(storeProduct: StoreProduct) -> ViewWrapper<ProductViewModel, ProductWrapperView> {
        assemble(with: .product(storeProduct))
    }

    // MARK: Private

    private func assemble(with type: ProductViewType) -> ViewWrapper<ProductViewModel, ProductWrapperView> {
        let presenter = ProductPresenter(
            productFetcher: ProductStrategy(type: type, iap: iap),
            purchaseService: ProductPurchaseService(iap: iap)
        )
        let viewModel = WrapperViewModel<ProductViewModel>(
            model: ProductViewModel(state: .loading, presenter: presenter)
        )
        presenter.viewModel = viewModel

        return ViewWrapper<ProductViewModel, ProductWrapperView>(
            viewModel: viewModel
        )
    }
}
