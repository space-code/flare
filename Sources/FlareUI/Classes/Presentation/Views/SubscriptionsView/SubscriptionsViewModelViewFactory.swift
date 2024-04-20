//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ISubscriptionsViewModelViewFactory

protocol ISubscriptionsViewModelViewFactory {
    func make(_ products: [StoreProduct]) async throws -> [SubscriptionView.ViewModel]
}

// MARK: - SubscriptionsViewModelViewFactory

final class SubscriptionsViewModelViewFactory: ISubscriptionsViewModelViewFactory {
    // MARK: Properties

    private let subscriptionPriceViewModelFactory: ISubscriptionPriceViewModelFactory

    // MARK: Initialization

    init(subscriptionPriceViewModelFactory: ISubscriptionPriceViewModelFactory = SubscriptionPriceViewModelFactory()) {
        self.subscriptionPriceViewModelFactory = subscriptionPriceViewModelFactory
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
        guard let subscription = product.subscription else { return false }

        let statuses = try await subscription.subscriptionStatus

        for status in statuses {
            if case let .verified(subscription) = status.subscriptionRenewalInfo,
               subscription.currentProductID == product.productIdentifier
            {
                if status.renewalState == .subscribed {
                    return true
                }
            }
        }

        return false
    }

    private func makePrice(string: String) -> String {
        #if os(tvOS)
            return L10n.Subscriptions.Renewable.subscriptionDescriptionSeparated(string)
        #else
            return string
        #endif
    }
}
