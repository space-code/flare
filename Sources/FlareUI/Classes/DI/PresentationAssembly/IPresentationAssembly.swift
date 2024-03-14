//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// A type defines a presentation assembly.
protocol IPresentationAssembly {
    /// A products view assembly.
    var productsViewAssembly: IProductsViewAssembly { get }

    /// A subscriptions view assembly.
    var subscritpionsViewAssembly: ISubscriptionsAssembly { get }

    /// A product view assembly.
    var productViewAssembly: IProductViewAssembly { get }
}
