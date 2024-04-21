//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation
import SwiftUI

// MARK: - IProductPresenter

protocol IProductPresenter {
    func viewDidLoad()
    func purchase(options: PurchaseOptions?) async throws -> StoreTransaction
}

// MARK: - ProductPresenter

final class ProductPresenter: IPresenter {
    // MARK: Properties

    private let productFetcher: IProductFetcherStrategy
    private let purchaseService: IProductPurchaseService

    weak var viewModel: WrapperViewModel<ProductViewModel>?

    // MARK: Initialization

    init(
        productFetcher: IProductFetcherStrategy,
        purchaseService: IProductPurchaseService
    ) {
        self.productFetcher = productFetcher
        self.purchaseService = purchaseService
    }
}

// MARK: IProductPresenter

extension ProductPresenter: IProductPresenter {
    func viewDidLoad() {
        update(state: .loading)

        Task { @MainActor in
            do {
                let product = try await productFetcher.product()
                self.update(state: .product(product))
            } catch {
                if let error = error as? IAPError {
                    self.update(state: .error(error))
                } else {
                    self.update(state: .error(IAPError.with(error: error)))
                }
            }
        }
    }

    @MainActor
    func purchase(options: PurchaseOptions?) async throws -> StoreTransaction {
        guard case let .product(product) = viewModel?.model.state else {
            throw IAPError.unknown
        }

        return try await purchaseService.purchase(product: product, options: options)
    }
}
