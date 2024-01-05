//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKitTest
import XCTest

@available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
class StoreSessionTestCase: XCTestCase {
    // MARK: Properties

    var session: SKTestSession?

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()

        session = try? SKTestSession(configurationFileNamed: "Flare")
        session?.resetToDefaultState()
        session?.askToBuyEnabled = false
        session?.disableDialogs = true
    }

    override func tearDown() {
        session?.clearTransactions()
        session = nil
        super.tearDown()
    }
}
