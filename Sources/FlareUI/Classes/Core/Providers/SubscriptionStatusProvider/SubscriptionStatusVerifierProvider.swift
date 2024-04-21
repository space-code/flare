//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - SubscriptionStatusVerifierProvider

final class SubscriptionStatusVerifierProvider {
    // MARK: Properties

    private let configurationProvider: IConfigurationProvider
    private let subscriptionStatusVerifierResolver: ISubscriptionStatusVerifierTypeResolver

    // MARK: Initialization

    init(
        configurationProvider: IConfigurationProvider,
        subscriptionStatusVerifierResolver: ISubscriptionStatusVerifierTypeResolver
    ) {
        self.configurationProvider = configurationProvider
        self.subscriptionStatusVerifierResolver = subscriptionStatusVerifierResolver
    }
}

// MARK: ISubscriptionStatusVerifierProvider

extension SubscriptionStatusVerifierProvider: ISubscriptionStatusVerifierProvider {
    var subscriptionStatusVerifier: (any ISubscriptionStatusVerifier)? {
        guard let type = configurationProvider.subscriptionVerifierType else { return nil }
        return subscriptionStatusVerifierResolver.resolve(type)
    }
}
