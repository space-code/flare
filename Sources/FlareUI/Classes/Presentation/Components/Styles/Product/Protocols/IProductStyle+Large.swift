//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public extension IProductStyle where Self == LargeProductStyle {
    static var large: Self {
        LargeProductStyle()
    }
}
