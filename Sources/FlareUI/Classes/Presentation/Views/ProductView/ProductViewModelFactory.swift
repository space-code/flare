//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductViewModelFactory

protocol IProductViewModelFactory {
    func make(_ product: StoreProduct) -> ProductInfoView.ViewModel
}

// MARK: - ProductViewModelFactory

final class ProductViewModelFactory: IProductViewModelFactory {
    // MARK: Properties

    private var dateFormatter: IDateComponentsFormatter
    private let subscriptionDateComponentsFactory: ISubscriptionDateComponentsFactory

    // MARK: Initialization

    init(
        dateFormatter: IDateComponentsFormatter = DateComponentsFormatter(),
        subscriptionDateComponentsFactory: ISubscriptionDateComponentsFactory = SubscriptionDateComponentsFactory()
    ) {
        self.dateFormatter = dateFormatter
        self.subscriptionDateComponentsFactory = subscriptionDateComponentsFactory
    }

    // MARK: IProductViewModelFactory

    func make(_ product: StoreProduct) -> ProductInfoView.ViewModel {
        ProductInfoView.ViewModel(
            id: product.productIdentifier,
            title: product.localizedTitle,
            description: product.localizedDescription,
            price: makePrice(from: product)
        )
    }

    // MARK: Private

    private func makePrice(from product: StoreProduct) -> String {
        switch product.productType {
        case .consumable, .nonConsumable, .nonRenewableSubscription:
            return product.localizedPriceString ?? ""
        case .autoRenewableSubscription:
            guard let period = product.subscriptionPeriod else { return "" }

            let unit = makeUnit(from: period.unit)
            dateFormatter.allowedUnits = [unit]

            let dateComponents = subscriptionDateComponentsFactory.dateComponents(for: period)
            let localizedPeriod = dateFormatter.string(from: dateComponents)

            return localizedPeriod ?? ""
        case .none:
            return ""
        }
    }

    private func makeUnit(from unit: SubscriptionPeriod.Unit) -> NSCalendar.Unit {
        switch unit {
        case .day:
            return .day
        case .week:
            return .weekOfMonth
        case .month:
            return .month
        case .year:
            return .year
        }
    }
}
