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

    private let id: String
    private let iap: IFlare

    private var isInProgress = false

    weak var viewModel: ViewModel<ProductViewModel>?

    // MARK: Initialization

    init(
        id: String,
        iap: IFlare
    ) {
        self.id = id
        self.iap = iap
    }
}

// MARK: IProductPresenter

extension ProductPresenter: IProductPresenter {
    func viewDidLoad() {
        update(state: .loading)

        iap.fetch(productIDs: [id]) { [weak self] result in
            guard let self = self, let viewModel = self.viewModel else { return }

            switch result {
            case let .success(product):
                guard let product = product.first else { return }
                self.update(state: .product(product))
            case let .failure(error):
                self.update(state: .error(error))
            }
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
