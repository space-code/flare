//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

/// A type defines dependencies for the package.
protocol IFlareDependencies {
    /// An IAP manager.
    var iap: IFlare { get }
}
