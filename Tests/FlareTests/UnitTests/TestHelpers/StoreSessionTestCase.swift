//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKitTest
import XCTest

class StoreSessionTestCase: XCTestCase {
    // MARK: Properties

    var session: SKTestSession?

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()

        if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
            do {
                session = try SKTestSession(configurationFileNamed: "Flare")
                session?.resetToDefaultState()
                session?.askToBuyEnabled = false
                session?.disableDialogs = true
            } catch {
                debugPrint("[StoreSessionTestCase] An error occurred while initializing a session: \(error.localizedDescription)")
            }
        }
    }

    override func tearDown() {
        session?.clearTransactions()
        session = nil
        super.tearDown()
    }
}
