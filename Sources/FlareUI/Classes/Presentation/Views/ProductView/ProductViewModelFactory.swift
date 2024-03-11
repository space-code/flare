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
        dateFormatter: IDateComponentsFormatter = DateComponentsFormatter.full,
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
            price: makePrice(from: product),
            priceDescription: makePriceDescription(from: product)
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

            return [product.localizedPriceString, String(localizedPeriod?.words.last)]
                .compactMap { $0 }
                .joined(separator: "/")
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

    private func period(from product: StoreProduct) -> String? {
        guard let period = product.subscriptionPeriod else { return nil }

        let unit = makeUnit(from: period.unit)
        dateFormatter.allowedUnits = [unit]

        let dateComponents = subscriptionDateComponentsFactory.dateComponents(for: period)
        let localizedPeriod = dateFormatter.string(from: dateComponents)

        return localizedPeriod
    }

    private func makePriceDescription(from product: StoreProduct) -> String? {
        let localizedPeriod = period(from: product)

        guard let string = localizedPeriod?.words.last else { return nil }

        return L10n.Product.priceDescription(string).capitalized
    }
}

extension DateComponentsFormatter {
    static let full: IDateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = .dropAll
        return formatter
    }()
}
