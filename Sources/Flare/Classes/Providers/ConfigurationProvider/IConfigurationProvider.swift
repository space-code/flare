//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Type for providing configuration settings to an application.
protocol IConfigurationProvider {
    /// The application username.
    var applicationUsername: String? { get }

    /// The cache policy for fetching data.
    var fetchCachePolicy: FetchCachePolicy { get }

    /// Configures the provider with the specified configuration settings.
    ///
    /// - Parameter configuration: The configuration settings to apply.
    func configure(with configuration: Configuration)
}
