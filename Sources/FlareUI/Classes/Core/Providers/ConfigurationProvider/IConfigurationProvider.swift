//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Type for providing configuration settings to an application.
protocol IConfigurationProvider {
    /// The subscription verifier type.
    var subscriptionVerifierType: SubscriptionStatusVerifierType? { get }

    /// Configures the application with the provided UI configuration.
    ///
    /// - Parameter configuration: The UI configuration to apply.
    func configure(with configuration: UIConfiguration)
}
