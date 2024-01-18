//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Protocol for managing `UserDefaults` operations.
protocol IUserDefaults {
    /// Sets a `Codable` value in `UserDefaults` for a given key.
    ///
    /// - Parameters:
    ///   - key: The key to associate with the Codable value.
    ///
    ///   - codable: The Codable value to be stored.
    func set<T: Codable>(key: String, codable: T)

    /// Retrieves a `Codable` value from `UserDefaults` for a given key.
    ///
    /// - Parameter key: The key associated with the desired Codable value.
    ///
    /// - Returns: The Codable value stored for the given key, or nil if not found.
    func get<T: Codable>(key: String) -> T?
}
