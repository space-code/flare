//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import XCTest

extension XCTestCase {
    func wait(
        _ condition: @escaping @autoclosure () -> (Bool),
        timeout: TimeInterval = 10
    ) {
        wait(
            for: [
                XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in condition() }), object: nil
                ),
            ],
            timeout: timeout
        )
    }
}
