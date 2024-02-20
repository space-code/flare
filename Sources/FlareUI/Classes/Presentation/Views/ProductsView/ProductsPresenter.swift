//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductsPresenter

protocol IProductsPresenter {
    func viewDidLoad()
    func purchase(productID id: String) async
}

// MARK: - ProductsPresenter

final class ProductsPresenter {
    // MARK: Properties

    private let ids: Set<String>
    private let iap: IFlare
    private let viewModelFactory: IProductsViewModelFactory

    private var products: [StoreProduct] = []

    weak var viewModel: ViewModel<ProductsViewModel>?

    // MARK: Initialization

    init(
        ids: Set<String>,
        iap: IFlare,
        viewModelFactory: IProductsViewModelFactory
    ) {
        self.ids = ids
        self.iap = iap
        self.viewModelFactory = viewModelFactory
    }
}

// MARK: IProductsPresenter

extension ProductsPresenter: IProductsPresenter {
    func viewDidLoad() {
        iap.fetch(productIDs: ids) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(products):
                self.products = products

                DispatchQueue.main.async {
                    self.viewModel?.model = .init(
                        isLoading: false,
                        products: self.viewModelFactory.make(products),
                        presenter: self
                    )
                }
            case let .failure(error):
                break
            }
        }
    }

    func purchase(productID _: String) async {
        do {
//            let transaction = try await iap.purchase(product: <#T##StoreProduct#>)
        } catch {}
    }
}
