//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - IPaywallAssembly

protocol IPaywallAssembly {
    func assemble(paywallType: PaywallType) -> PaywallView
}

// MARK: - PaywallAssembly

final class PaywallAssembly: IPaywallAssembly {
    // MARK: Properties

    private let productsAssembly: IProductsViewAssembly
    private let subscriptionsAssembly: ISubscriptionAssembly

    // MARK: Initialization

    init(productsAssembly: IProductsViewAssembly, subscriptionsAssembly: ISubscriptionAssembly) {
        self.productsAssembly = productsAssembly
        self.subscriptionsAssembly = subscriptionsAssembly
    }

    // MARK: IPaywallAssembly

    func assemble(paywallType: PaywallType) -> PaywallView {
        PaywallView(
            paywallType: paywallType,
            productsAssembly: productsAssembly,
            subscriptionsAssembly: subscriptionsAssembly
        )
    }
}
