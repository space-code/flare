//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductsPresenter

protocol IProductsPresenter {
    var viewModel: ViewModel<ProductsViewModel> { get }

    func viewDidLoad()
}

// MARK: - ProductsPresenter

final class ProductsPresenter {
    // MARK: Properties

    private let ids: Set<String>
    private let iap: IFlare

    let viewModel: ViewModel<ProductsViewModel>

    // MARK: Initialization

    init(ids: Set<String>, iap: IFlare, viewModel: ViewModel<ProductsViewModel>) {
        self.ids = ids
        self.iap = iap
        self.viewModel = viewModel
    }
}

// MARK: IProductsPresenter

extension ProductsPresenter: IProductsPresenter {
    func viewDidLoad() {
        iap.fetch(productIDs: ids) { _ in
        }
    }
}
