//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ISubscriptionsViewModelViewFactory

@available(watchOS, unavailable)
protocol ISubscriptionsViewModelViewFactory {
    func make(_ products: [StoreProduct]) async throws -> [SubscriptionView.ViewModel]
}

// MARK: - SubscriptionsViewModelViewFactory

@available(watchOS, unavailable)
final class SubscriptionsViewModelViewFactory: ISubscriptionsViewModelViewFactory {
    // MARK: Properties

    private let subscriptionPriceViewModelFactory: ISubscriptionPriceViewModelFactory
    private let subscriptionStatusVerifier: ISubscriptionStatusVerifier?

    // MARK: Initialization

    init(
        subscriptionPriceViewModelFactory: ISubscriptionPriceViewModelFactory = SubscriptionPriceViewModelFactory(),
        subscriptionStatusVerifier: ISubscriptionStatusVerifier? = nil
    ) {
        self.subscriptionPriceViewModelFactory = subscriptionPriceViewModelFactory
        self.subscriptionStatusVerifier = subscriptionStatusVerifier
    }

    // MARK: ISubscriptionsViewModelViewFactory

    func make(_ products: [StoreProduct]) async throws -> [SubscriptionView.ViewModel] {
        var viewModels: [SubscriptionView.ViewModel] = []

        for product in products {
            let viewModel = try SubscriptionView.ViewModel(
                id: product.productIdentifier,
                title: product.localizedTitle,
                price: makePrice(string: subscriptionPriceViewModelFactory.make(product, format: .full)),
                description: product.localizedDescription,
                isActive: await validationSubscriptionStatus(product)
            )

            viewModels.append(viewModel)
        }

        return viewModels
    }

    // MARK: Private

    private func validationSubscriptionStatus(_ product: StoreProduct) async throws -> Bool {
        guard let subscriptionStatusVerifier = subscriptionStatusVerifier else { return false }
        return try await subscriptionStatusVerifier.validate(product)
    }

    private func makePrice(string: String) -> String {
        #if os(tvOS)
            return L10n.Subscriptions.Renewable.subscriptionDescriptionSeparated(string)
        #else
            return string
        #endif
    }
}
