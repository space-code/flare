//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import XCTest

final class ArrayExtensionsTests: XCTestCase {
    func test_thatArrayRemovesDuplicates() {
        // given
        let array = [10, 10, 9, 1, 3, 3, 7, 8, 7, 7, 7]

        // when
        let filteredArray = array.removingDuplicates()

        // then
        XCTAssertEqual(filteredArray, [10, 9, 1, 3, 7, 8])
    }
}
