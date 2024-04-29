//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

final class FlareDependencies: IFlareDependencies {
    // MARK: IFlareDependencies

    lazy var configurationProvider: IConfigurationProvider = ConfigurationProvider()

    var iap: IFlare {
        Flare.shared
    }

    var subscriptionStatusVerifierProvider: ISubscriptionStatusVerifierProvider {
        SubscriptionStatusVerifierProvider(
            configurationProvider: self.configurationProvider,
            subscriptionStatusVerifierResolver: self.subscriptionStatusVerifierResolver
        )
    }

    // MARK: Private

    private var subscriptionStatusVerifierResolver: ISubscriptionStatusVerifierTypeResolver {
        SubscriptionStatusVerifierTypeResolver()
    }
}
