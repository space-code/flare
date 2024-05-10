//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation
import SwiftUI

// MARK: - IProductPresenter

/// A protocol for presenting product information and handling purchases.
protocol IProductPresenter {
    /// Called when the view has loaded.
    func viewDidLoad()

    /// Initiates a purchase for the product with optional purchase options asynchronously.
    ///
    /// - Parameter options: Optional purchase options.
    ///
    /// - Returns: A `StoreTransaction` representing the purchase transaction.
    func purchase(options: PurchaseOptions?) async throws -> StoreTransaction
}

// MARK: - ProductPresenter

/// The presenter for a product.
final class ProductPresenter: IPresenter {
    // MARK: Properties

    /// The strategy for fetching product information.
    private let productFetcher: IProductFetcherStrategy
    /// The service for handling product purchases.
    private let purchaseService: IProductPurchaseService

    /// The view model.
    weak var viewModel: WrapperViewModel<ProductViewModel>?

    // MARK: Initialization

    /// Initializes the presenter with the given dependencies.
    ///
    /// - Parameters:
    ///   - productFetcher: The strategy for fetching product information.
    ///   - purchaseService: The service for handling product purchases.
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
