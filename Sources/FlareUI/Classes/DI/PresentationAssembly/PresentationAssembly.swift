//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

final class PresentationAssembly: IPresentationAssembly {
    // MARK: Properties

    private let dependencies: IFlareDependencies

    // MARK: Initialization

    init(dependencies: IFlareDependencies) {
        self.dependencies = dependencies
    }

    // MARK: IPresentationAssembly

    var productsViewAssembly: IProductsViewAssembly {
        ProductsViewAssembly(productAssembly: productViewAssembly)
    }

    var productViewAssembly: IProductViewAssembly {
        ProductViewAssembly(iap: dependencies.iap)
    }

    var subscritpionsViewAssembly: ISubscriptionAssembly {
        SubscriptionAssembly(iap: dependencies.iap)
    }
}
