//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import XCTest

final class ProcessInfoTests: XCTestCase {
    func test_thatProcessInfoReturnsSsRunningUnitTestsEqualsToTrue_whenRuggingUnderTests() {
        XCTAssertTrue(ProcessInfo.isRunningUnitTests)
    }
}
