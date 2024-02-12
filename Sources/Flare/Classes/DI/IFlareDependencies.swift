//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// The package's dependencies.
protocol IFlareDependencies {
    /// The IAP provider.
    var iapProvider: IIAPProvider { get }
    /// The configuration provider.
    var configurationProvider: IConfigurationProvider { get }
}
