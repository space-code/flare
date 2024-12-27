//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - IProductViewAssembly

/// A protocol for assembling product views.
protocol IProductViewAssembly: Sendable {
    /// Assembles a product view for the given product ID.
    ///
    /// - Parameter id: The ID of the product.
    /// - Returns: A `ViewWrapper` containing the product view model and the product wrapper view.
    @MainActor
    func assemble(id: String) -> ViewWrapper<ProductViewModel, ProductWrapperView>

    /// Assembles a product view for the given store product.
    ///
    /// - Parameter storeProduct: The store product.
    /// - Returns: A `ViewWrapper` containing the product view model and the product wrapper view.
    @MainActor
    func assemble(storeProduct: StoreProduct) -> ViewWrapper<ProductViewModel, ProductWrapperView>
}

// MARK: - ProductViewAssembly

/// An assembly class for creating product views.
final class ProductViewAssembly: IProductViewAssembly, @unchecked Sendable {
    // MARK: Properties

    private let iap: IFlare

    // MARK: Initialization

    /// Initializes the assembly with the given in-app purchase service.
    ///
    /// - Parameter iap: The in-app purchase service.
    init(iap: IFlare) {
        self.iap = iap
    }

    // MARK: IProductViewAssembly

    @MainActor
    func assemble(id: String) -> ViewWrapper<ProductViewModel, ProductWrapperView> {
        assemble(with: .productID(id))
    }

    @MainActor
    func assemble(storeProduct: StoreProduct) -> ViewWrapper<ProductViewModel, ProductWrapperView> {
        assemble(with: .product(storeProduct))
    }

    // MARK: Private

    @MainActor
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
