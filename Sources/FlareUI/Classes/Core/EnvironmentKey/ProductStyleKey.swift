//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ProductStyleKey

struct ProductStyleKey: EnvironmentKey {
    static var defaultValue = AnyProductStyle(style: CompactProductStyle())
}

extension EnvironmentValues {
    var productViewStyle: AnyProductStyle {
        get { self[ProductStyleKey.self] }
        set { self[ProductStyleKey.self] = newValue }
    }
}

extension IProductStyle where Self == CompactProductStyle {
    static var `default`: Self {
        CompactProductStyle()
    }
}

@available(iOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension IProductStyle where Self == LargeProductStyle {
    static var large: Self {
        LargeProductStyle()
    }
}
