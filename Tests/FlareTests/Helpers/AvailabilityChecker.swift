//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import XCTest

enum AvailabilityChecker {
    static func iOS15APINotAvailableOrSkipTest() throws {
        if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *) {
            throw XCTSkip("Test only for older devices")
        }
    }
}
