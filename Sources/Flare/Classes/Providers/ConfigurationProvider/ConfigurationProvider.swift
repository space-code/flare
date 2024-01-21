//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - ConfigurationProvider

/// A class responsible for providing configuration settings, utilizing a cache provider.
final class ConfigurationProvider {
    // MARK: Properties

    /// The cache provider used to store and retrieve configuration settings.
    private let cacheProvider: ICacheProvider

    // MARK: Initialization

    /// Initializes a ConfigurationProvider with a specified cache provider.
    ///
    /// - Parameter cacheProvider: The cache provider to use. Defaults to an instance of
    ///                            `CacheProvider` with standard UserDefaults.
    init(cacheProvider: ICacheProvider = CacheProvider(userDefaults: UserDefaults.standard)) {
        self.cacheProvider = cacheProvider
    }
}

// MARK: IConfigurationProvider

extension ConfigurationProvider: IConfigurationProvider {
    var applicationUsername: String? {
        cacheProvider.read(key: .applicationUsername)
    }

    func configure(with configuration: Configuration) {
        cacheProvider.write(key: .applicationUsername, value: configuration.applicationUsername)
        Logger.debug(message: L10n.Flare.initWithConfiguration(configuration))
    }
}

// MARK: - Constants

private extension String {
    static let applicationUsername = "flare.configuration.application_username"
}
