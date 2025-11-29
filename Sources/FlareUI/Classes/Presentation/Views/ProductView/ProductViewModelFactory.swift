//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - IProductViewModelFactory

protocol IProductViewModelFactory {
    func make(_ product: StoreProduct, style: ProductStyle) -> ProductInfoView.ViewModel
}

// MARK: - ProductViewModelFactory

final class ProductViewModelFactory: IProductViewModelFactory {
    // MARK: Properties

    private let subscriptionPriceViewModelFactory: ISubscriptionPriceViewModelFactory

    // MARK: Initialization

    init(
        subscriptionPriceViewModelFactory: ISubscriptionPriceViewModelFactory = SubscriptionPriceViewModelFactory()
    ) {
        self.subscriptionPriceViewModelFactory = subscriptionPriceViewModelFactory
    }

    // MARK: IProductViewModelFactory

    func make(_ product: StoreProduct, style: ProductStyle) -> ProductInfoView.ViewModel {
        ProductInfoView.ViewModel(
            id: product.productIdentifier,
            title: product.localizedTitle,
            description: product.localizedDescription,
            price: makePrice(from: product, style: style),
            priceDescription: makePriceDescription(from: product)
        )
    }

    // MARK: Private

    private func makePrice(from product: StoreProduct, style: ProductStyle) -> String {
        switch style {
        case .compact:
            subscriptionPriceViewModelFactory.make(product, format: .short)
        case .large:
            subscriptionPriceViewModelFactory.make(product, format: .full)
        }
    }

    private func makePriceDescription(from product: StoreProduct) -> String? {
        let localizedPeriod = subscriptionPriceViewModelFactory.period(from: product)

        guard let string = localizedPeriod?.words.last else { return nil }

        return L10n.Product.priceDescription(string).capitalized
    }
}
