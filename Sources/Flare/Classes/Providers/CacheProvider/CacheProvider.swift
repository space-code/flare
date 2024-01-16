//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

// MARK: - CacheProvider

final class CacheProvider {
    // MARK: Properties

    private let userDefaults: IUserDefaults

    // MARK: Initialization

    init(userDefaults: IUserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}

// MARK: ICacheProvider

extension CacheProvider: ICacheProvider {
    func read<T: Codable>(key: String) -> T? {
        userDefaults.get(key: key)
    }

    func write<T: Codable>(key: String, value: T) {
        userDefaults.set(key: key, codable: value)
    }
}
