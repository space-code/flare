//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductsPresenter

protocol IProductsPresenter {
    func viewDidLoad()
}

// MARK: - ProductsPresenter

final class ProductsPresenter: IPresenter {
    // MARK: Properties

    private let ids: any Collection<String>
    private let iap: IFlare

    weak var viewModel: WrapperViewModel<ProductsViewModel>?

    // MARK: Initialization

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
