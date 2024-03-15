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
            storeButtonAssembly: storeButtonAssembly,
            iap: dependencies.iap
        )
    }

    var productViewAssembly: IProductViewAssembly {
        ProductViewAssembly(iap: dependencies.iap)
    }

    var subscritpionsViewAssembly: ISubscriptionsAssembly {
        SubscriptionsAssembly(
            iap: dependencies.iap,
            storeButtonAssembly: storeButtonAssembly
        )
    }

    // MARK: Private

    private var storeButtonAssembly: IStoreButtonAssembly {
        StoreButtonAssembly(iap: dependencies.iap)
    }
}
