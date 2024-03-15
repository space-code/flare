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
    func make(_ products: [StoreProduct]) -> [SubscriptionView.ViewModel] {
        products.map {
            SubscriptionView.ViewModel(
                id: $0.productIdentifier,
                title: $0.localizedTitle,
                price: $0.localizedPriceString ?? "",
                description: $0.localizedDescription
            )
        }
    }
}
