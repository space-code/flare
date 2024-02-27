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
    func purchase() async throws
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
            } catch {}
        }
    }

    @MainActor
    func purchase() async throws {
        guard !isInProgress else { return }

        defer { isInProgress = false }
        isInProgress = true

        guard case let .product(product) = viewModel?.model.state else {
            throw IAPError.unknown
        }

        do {
            let transaction = try await iap.purchase(product: product)
            await iap.finish(transaction: transaction)
        } catch {
            if let error = error as? IAPError, error != .paymentCancelled {
                throw error
            }
        }
    }
}
