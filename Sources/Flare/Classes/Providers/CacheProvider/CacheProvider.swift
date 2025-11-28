//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - CacheProvider

/// A class provides caching functionality.
final class CacheProvider {
    // MARK: Properties

    /// The user defaults.
    private let userDefaults: IUserDefaults

    // MARK: Initialization

    /// Creates a `CacheProvider` instance.
    ///
    /// - Parameter userDefaults: The user defaults.
    init(userDefaults: IUserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}

// MARK: ICacheProvider

extension CacheProvider: ICacheProvider {
    func read<T: Codable>(key: String) -> T? {
        userDefaults.get(key: key)
    }

    func write(key: String, value: some Codable) {
        userDefaults.set(key: key, codable: value)
    }
}
