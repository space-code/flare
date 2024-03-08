//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation
import StoreKit
import SwiftUI

// MARK: - IProductPresenter

protocol IProductPresenter {
    func viewDidLoad()
    func purchase(options: PurchaseOptions?) async throws -> Bool
}

// MARK: - ProductPresenter

final class ProductPresenter: IPresenter {
    // MARK: Properties

    private let iap: IFlare
    private let productFetcher: IProductFetcherStrategy

    private var isInProgress = false

    weak var viewModel: ViewModel<ProductViewModel>?

    // MARK: Initialization

    init(
        iap: IFlare,
        productFetcher: IProductFetcherStrategy
    ) {
        self.iap = iap
        self.productFetcher = productFetcher
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
    func purchase(options: PurchaseOptions?) async throws -> Bool {
        guard !isInProgress else { return false }

        defer { isInProgress = false }
        isInProgress = true

        guard case let .product(product) = viewModel?.model.state else {
            throw IAPError.unknown
        }

        do {
            let transaction = try await purchase(product: product, options: options)
            // TODO: Don't finish transaction
            await iap.finish(transaction: transaction)
            return true
        } catch {
            if let error = error as? IAPError, error != .paymentCancelled {
                throw error
            }
            return false
        }
    }

    private func purchase(product: StoreProduct, options: PurchaseOptions?) async throws -> StoreTransaction {
        if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *), let options = options?.options {
            return try await iap.purchase(product: product, options: options)
        } else {
            return try await iap.purchase(product: product)
        }
    }
}
