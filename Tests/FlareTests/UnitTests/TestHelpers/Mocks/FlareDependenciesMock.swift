//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class FlareDependenciesMock: IFlareDependencies {
    var invokedIapProviderGetter = false
    var invokedIapProviderGetterCount = 0
    var stubbedIapProvider: IIAPProvider!

    var iapProvider: IIAPProvider {
        invokedIapProviderGetter = true
        invokedIapProviderGetterCount += 1
        return stubbedIapProvider
    }

    var invokedConfigurationProviderGetter = false
    var invokedConfigurationProviderGetterCount = 0
    var stubbedConfigurationProvider: IConfigurationProvider!

    var configurationProvider: IConfigurationProvider {
        invokedConfigurationProviderGetter = true
        invokedConfigurationProviderGetterCount += 1
        return stubbedConfigurationProvider
    }
}
