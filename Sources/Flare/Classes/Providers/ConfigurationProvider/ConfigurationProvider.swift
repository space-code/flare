//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - ConfigurationProvider

final class ConfigurationProvider {
    // MARK: Properties

    private let cacheProvider: ICacheProvider

    // MARK: Initialization

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
        cacheProvider.write(key: .applicationUsername, value: configuration.applicationUserName)
    }
}

// MARK: - Constants

private extension String {
    static let applicationUsername = "application_username"
}
