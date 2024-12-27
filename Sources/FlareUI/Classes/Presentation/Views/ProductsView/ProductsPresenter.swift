//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductsPresenter

/// A protocol for the presenter of products.
protocol IProductsPresenter {
    /// Called when the view has loaded.
    func viewDidLoad()
}

// MARK: - ProductsPresenter

/// The presenter for products.
final class ProductsPresenter: IPresenter, @unchecked Sendable {
    // MARK: Properties

    /// The collection of product IDs.
    private let ids: any Collection<String>
    /// The in-app purchase service.
    private let iap: IFlare

    weak var viewModel: WrapperViewModel<ProductsViewModel>?

    // MARK: Initialization

    /// Initializes the presenter with the given dependencies.
    ///
    /// - Parameters:
    ///   - ids: The collection of product IDs.
    ///   - iap: The in-app purchase service.
    init(ids: some Collection<String>, iap: IFlare) {
        self.ids = ids
        self.iap = iap
    }
}

// MARK: IProductsPresenter

extension ProductsPresenter: IProductsPresenter {
    func viewDidLoad() {
        Task { @MainActor in
            do {
                let products = try await iap.fetch(productIDs: ids)
                self.update(state: .products(products))
            } catch {
                self.update(state: .error(error.iap))
            }
        }
    }
}
