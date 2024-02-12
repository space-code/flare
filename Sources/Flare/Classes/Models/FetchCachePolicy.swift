//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Enum representing different cache policies for fetching data.
public enum FetchCachePolicy: Sendable, Codable {
    /// Fetch the current data without using the cache.
    case fetch

    /// Use the cached data if available; otherwise, fetch the data.
    case cachedOrFetch

    /// The default cache policy, set to use cached data if available; otherwise, fetch the data.
    static let `default`: FetchCachePolicy = .cachedOrFetch
}
