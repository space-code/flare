//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation
import StoreKit

// MARK: - ISubscriptionsPresenter

/// A protocol for presenting subscription information and handling subscriptions.
protocol ISubscriptionsPresenter: Sendable {
    /// Called when the view has loaded.
    func viewDidLoad()

    /// Selects a product with the specified ID.
    ///
    /// - Parameter id: The ID of the product to select.
    func selectProduct(with id: String)

    /// Retrieves the product with the specified ID.
    ///
    /// - Parameter id: The ID of the product to retrieve.
    /// - Returns: The store product corresponding to the ID, or `nil` if not found.
    func product(withID id: String) -> StoreProduct?

    /// Initiates a subscription with optional purchase options asynchronously.
    ///
    /// - Parameter optionsHandler: The handler for purchase options.
    /// - Returns: A `StoreTransaction` representing the subscription transaction.
    func subscribe(optionsHandler: PurchaseOptionHandler?) async throws -> StoreTransaction
}

// MARK: - SubscriptionsPresenter

/// A presenter for managing subscriptions.
@available(watchOS, unavailable)
final class SubscriptionsPresenter: IPresenter, @unchecked Sendable {
    // MARK: Properties

    /// The in-app purchase service.
    private let iap: IFlare
    /// The collection of subscription IDs.
    private let ids: any Collection<String>
    /// The factory for creating view models and views.
    private let viewModelFactory: ISubscriptionsViewModelViewFactory

    private var products: [StoreProduct] = []

    weak var viewModel: WrapperViewModel<SubscriptionsViewModel>?

    // MARK: Initialization

    /// Initializes the presenter with the given dependencies.
    ///
    /// - Parameters:
    ///   - iap: The in-app purchase service.
    ///   - ids: The collection of subscription IDs.
    ///   - viewModelFactory: The factory for creating view models and views.
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
        let transaction: StoreTransaction = if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *), let options = options?.options {
            try await iap.purchase(product: product, options: options)
        } else {
            try await iap.purchase(product: product)
        }

        loadProducts()

        return transaction
    }
}
