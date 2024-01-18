//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Type for a cache provider that supports reading and writing Codable values.
protocol ICacheProvider {
    /// Reads a Codable value from the cache using the specified key.
    ///
    /// - Parameters:
    ///   - key: The key associated with the value in the cache.
    /// - Returns: The Codable value associated with the key, or nil if not found.
    func read<T: Codable>(key: String) -> T?

    /// Writes a Codable value to the cache using the specified key.
    ///
    /// - Parameters:
    ///   - key: The key to associate with the value in the cache.
    ///   - value: The Codable value to be stored in the cache.
    func write<T: Codable>(key: String, value: T)
}
