//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

final class PresentationAssembly: IPresentationAssembly {
    // MARK: Properties

    private let dependencies: IFlareDependencies

    // MARK: Initialization

    init(dependencies: IFlareDependencies = FlareDependencies()) {
        self.dependencies = dependencies
    }

    // MARK: IPresentationAssembly

    var productsViewAssembly: IProductsViewAssembly {
        ProductsViewAssembly(
            productAssembly: productViewAssembly,
            storeButtonsAssembly: storeButtonsAssembly,
            iap: dependencies.iap
        )
    }

    var productViewAssembly: IProductViewAssembly {
        ProductViewAssembly(iap: dependencies.iap)
    }

    var subscritpionsViewAssembly: ISubscriptionsAssembly {
        SubscriptionsAssembly(
            iap: dependencies.iap,
            storeButtonsAssembly: storeButtonsAssembly,
            subscriptionStatusVerifierProvider: dependencies.subscriptionStatusVerifierProvider
        )
    }

    // MARK: Private

    private var storeButtonAssembly: IStoreButtonAssembly {
        StoreButtonAssembly(iap: dependencies.iap)
    }

    private var storeButtonsAssembly: IStoreButtonsAssembly {
        StoreButtonsAssembly(
            storeButtonAssembly: storeButtonAssembly,
            policiesButtonAssembly: policiesButtonAssembly
        )
    }

    private var policiesButtonAssembly: IPoliciesButtonAssembly {
        PoliciesButtonAssembly()
    }
}
