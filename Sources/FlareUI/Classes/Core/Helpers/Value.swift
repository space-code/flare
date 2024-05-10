//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

func value<T>(default: T, tvOS: T? = nil, macOS: T? = nil, iOS: T? = nil, watchOS: T? = nil) -> T {
    #if os(iOS)
        return iOS ?? `default`
    #elseif os(macOS)
        return macOS ?? `default`
    #elseif os(tvOS)
        return tvOS ?? `default`
    #elseif os(watchOS)
        return watchOS ?? `default`
    #else
        return `default`
    #endif
}
