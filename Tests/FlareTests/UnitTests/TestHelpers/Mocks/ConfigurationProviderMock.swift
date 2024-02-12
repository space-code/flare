//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class ConfigurationProviderMock: IConfigurationProvider {
    var invokedApplicationUsernameGetter = false
    var invokedApplicationUsernameGetterCount = 0
    var stubbedApplicationUsername: String!

    var applicationUsername: String? {
        invokedApplicationUsernameGetter = true
        invokedApplicationUsernameGetterCount += 1
        return stubbedApplicationUsername
    }

    var invokedFetchCachePolicyGetter = false
    var invokedFetchCachePolicyGetterCount = 0
    var stubbedFetchCachePolicy: FetchCachePolicy!

    var fetchCachePolicy: FetchCachePolicy {
        invokedFetchCachePolicyGetter = true
        invokedFetchCachePolicyGetterCount += 1
        return stubbedFetchCachePolicy
    }

    var invokedConfigure = false
    var invokedConfigureCount = 0
    var invokedConfigureParameters: (configuration: Configuration, Void)?
    var invokedConfigureParametersList = [(configuration: Configuration, Void)]()

    func configure(with configuration: Configuration) {
        invokedConfigure = true
        invokedConfigureCount += 1
        invokedConfigureParameters = (configuration, ())
        invokedConfigureParametersList.append((configuration, ()))
    }
}
