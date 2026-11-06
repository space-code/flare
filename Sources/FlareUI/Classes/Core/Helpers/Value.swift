//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

func value<T>(default: T, tvOS: T? = nil, macOS: T? = nil, iOS: T? = nil, watchOS: T? = nil) -> T {
    #if os(iOS)
        iOS ?? `default`
    #elseif os(macOS)
        macOS ?? `default`
    #elseif os(tvOS)
        tvOS ?? `default`
    #elseif os(watchOS)
        watchOS ?? `default`
    #else
        `default`
    #endif
}
