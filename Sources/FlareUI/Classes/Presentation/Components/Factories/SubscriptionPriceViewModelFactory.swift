//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

final class SubscriptionPriceViewModelFactory: ISubscriptionPriceViewModelFactory {
    // MARK: Properties

    private var dateFormatter: IDateComponentsFormatter
    private let subscriptionDateComponentsFactory: ISubscriptionDateComponentsFactory

    // MARK: Initialization

    init(
        dateFormatter: IDateComponentsFormatter = DateComponentsFormatter.full,
        subscriptionDateComponentsFactory: ISubscriptionDateComponentsFactory = SubscriptionDateComponentsFactory()
    ) {
        self.dateFormatter = dateFormatter
        self.subscriptionDateComponentsFactory = subscriptionDateComponentsFactory
    }

    // MARK: ISubscriptionPriceViewModelFactory

    func make(_ product: StoreProduct, format: PriceDisplayFormat) -> String {
        makePrice(from: product, format: format)
    }

    func period(from product: StoreProduct) -> String? {
        guard let period = product.subscriptionPeriod else { return nil }

        let unit = makeUnit(from: period.unit)
        dateFormatter.allowedUnits = [unit]

        let dateComponents = subscriptionDateComponentsFactory.dateComponents(for: period)
        let localizedPeriod = dateFormatter.string(from: dateComponents)

        return localizedPeriod
    }

    // MARK: Private

    private func makePrice(from product: StoreProduct, format: PriceDisplayFormat) -> String {
        switch product.productType {
        case .consumable, .nonConsumable, .nonRenewableSubscription:
            return product.localizedPriceString ?? ""
        case .autoRenewableSubscription:
            guard let period = product.subscriptionPeriod else { return "" }

            switch format {
            case .short:
                return product.localizedPriceString ?? ""
            case .full:
                let unit = makeUnit(from: period.unit)
                dateFormatter.allowedUnits = [unit]

                let dateComponents = subscriptionDateComponentsFactory.dateComponents(for: period)
                let localizedPeriod = dateFormatter.string(from: dateComponents)

                return [product.localizedPriceString, String(localizedPeriod?.words.last)]
                    .compactMap { $0 }
                    .joined(separator: "/")
            }
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

    private func makePriceDescription(from product: StoreProduct) -> String? {
        let localizedPeriod = period(from: product)

        guard let string = localizedPeriod?.words.last else { return nil }

        return L10n.Product.priceDescription(string).capitalized
    }
}
