//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - ConfigurationProvider

/// A class responsible for providing configuration settings.
final class ConfigurationProvider {
    // MARK: Properties

    /// The configuration for the UI module.
    private var configuration: UIConfiguration?
}

// MARK: IConfigurationProvider

extension ConfigurationProvider: IConfigurationProvider {
    var subscriptionVerifierType: SubscriptionStatusVerifierType? {
        guard let configuration else {
            if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
                return .automatic
            }
            return nil
        }
        return configuration.subscriptionVerifier
    }

    func configure(with configuration: UIConfiguration) {
        self.configuration = configuration
    }
}
