//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ISubscriptionsViewModelViewFactory

protocol ISubscriptionsViewModelViewFactory {
    func make(_ products: [StoreProduct]) -> [SubscriptionView.ViewModel]
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

    func make(_ products: [StoreProduct]) -> [SubscriptionView.ViewModel] {
        products.map {
            SubscriptionView.ViewModel(
                id: $0.productIdentifier,
                title: $0.localizedTitle,
                price: makePrice(string: subscriptionPriceViewModelFactory.make($0, format: .full)),
                description: $0.localizedDescription
            )
        }
    }

    // MARK: Private

    private func makePrice(string: String) -> String {
        #if os(tvOS)
            return L10n.Subscriptions.Renewable.subscriptionDescriptionSeparated(string)
        #else
            return string
        #endif
    }
}
