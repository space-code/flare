//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - IProductsViewAssembly

/// A protocol for assembling the view for products.
protocol IProductsViewAssembly {
    /// Assembles the view for products.
    ///
    /// - Parameter ids: The collection of product IDs.
    ///
    /// - Returns: The assembled view as `AnyView`.
    func assemble(ids: some Collection<String>) -> AnyView
}

// MARK: - ProductsViewAssembly

/// An assembly class for creating the view for products.
final class ProductsViewAssembly: IProductsViewAssembly {
    // MARK: Properties

    /// The assembly for product views.
    private let storeButtonsAssembly: IStoreButtonsAssembly
    /// The assembly for store buttons.
    private let productAssembly: IProductViewAssembly
    ///  The in-app purchase service.
    private let iap: IFlare

    // MARK: Initialization

    /// Initializes the `ProductsViewAssembly` with the given dependencies.
    ///
    /// - Parameters:
    ///   - productAssembly: The assembly for product views.
    ///   - storeButtonsAssembly: The assembly for store buttons.
    ///   - iap: The in-app purchase service.
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
