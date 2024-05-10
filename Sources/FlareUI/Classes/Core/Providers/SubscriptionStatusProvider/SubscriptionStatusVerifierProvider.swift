//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - SubscriptionStatusVerifierProvider

/// A class responsible for providing an object that can verify subscription status.
final class SubscriptionStatusVerifierProvider {
    // MARK: Properties

    /// The configuration provider for obtaining the subscription verifier type.
    private let configurationProvider: IConfigurationProvider

    /// The resolver for obtaining the subscription status verifier based on the type.
    private let subscriptionStatusVerifierResolver: ISubscriptionStatusVerifierTypeResolver

    // MARK: Initialization

    /// Initializes the provider with the given configuration provider and resolver.
    ///
    /// - Parameters:
    ///   - configurationProvider: The configuration provider.
    ///   - subscriptionStatusVerifierResolver: The resolver for obtaining the verifier.
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
    var subscriptionStatusVerifier: ISubscriptionStatusVerifier? {
        guard let type = configurationProvider.subscriptionVerifierType else { return nil }
        return subscriptionStatusVerifierResolver.resolve(type)
    }
}
