//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation
import StoreKit

// MARK: - ISubscriptionsPresenter

protocol ISubscriptionsPresenter {
    func viewDidLoad()
    func selectProduct(with id: String)
    func product(withID id: String) -> StoreProduct?
    func subscribe(optionsHandler: PurchaseOptionHandler?) async throws -> StoreTransaction
}

// MARK: - SubscriptionsPresenter

@available(watchOS, unavailable)
final class SubscriptionsPresenter: IPresenter {
    // MARK: Properties

    private let iap: IFlare
    private let ids: any Collection<String>
    private let viewModelFactory: ISubscriptionsViewModelViewFactory

    private var products: [StoreProduct] = []

    weak var viewModel: WrapperViewModel<SubscriptionsViewModel>?

    // MARK: Initialization

    init(iap: IFlare, ids: some Collection<String>, viewModelFactory: ISubscriptionsViewModelViewFactory) {
        self.iap = iap
        self.ids = ids
        self.viewModelFactory = viewModelFactory
    }

    // MARK: Private

    private func loadProducts() {
        Task { @MainActor in
            do {
                self.products = try await iap.fetch(productIDs: ids)
                    .filter { $0.productType == .autoRenewableSubscription }

                guard !products.isEmpty else {
                    update(state: .error(.storeProductNotAvailable))
                    return
                }

                let viewModel = try await viewModelFactory.make(products)

                update(state: .products(viewModel))
            } catch {
                update(state: .error(error.iap))
            }
        }
    }
}

// MARK: ISubscriptionsPresenter

@available(watchOS, unavailable)
extension SubscriptionsPresenter: ISubscriptionsPresenter {
    func viewDidLoad() {
        loadProducts()
    }

    func product(withID id: String) -> StoreProduct? {
        products.by(id: id)
    }

    func selectProduct(with id: String) {
        guard let model = self.viewModel?.model else { return }
        self.viewModel?.model = model.setSelectedProductID(id)
    }

    func subscribe(optionsHandler: PurchaseOptionHandler?) async throws -> StoreTransaction {
        guard let id = self.viewModel?.model.selectedProductID, let product = products.by(id: id) else {
            throw IAPError.unknown
        }

        let options = optionsHandler?(product)
        let transaction: StoreTransaction

        if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *), let options = options?.options {
            transaction = try await iap.purchase(product: product, options: options)
        } else {
            transaction = try await iap.purchase(product: product)
        }

        loadProducts()

        return transaction
    }
}
