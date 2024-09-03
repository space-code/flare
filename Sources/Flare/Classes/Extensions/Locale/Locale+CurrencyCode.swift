//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

extension Locale {
    var currencyCodeID: String? {
        #if swift(>=5.9)
            if #available(macOS 13, iOS 16, tvOS 16, watchOS 9, visionOS 1.0, *) {
                return self.currency?.identifier
            } else {
                return currencyCode
            }
        #else
            return currencyCode
        #endif
    }
}
