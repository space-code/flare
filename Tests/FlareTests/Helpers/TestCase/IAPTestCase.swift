//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKitTest
import XCTest

// MARK: - IAPTestCase

class IAPTestCase: XCTestCase {
    // MARK: Private

    private var session: ISKTestSession?

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        configureTestSession()
    }

    override func tearDown() {
        session = nil
        super.tearDown()
    }

    // MARK: Private

    private func configureTestSession() {
        if #available(macOS 11, iOS 14, tvOS 14, watchOS 7, visionOS 1.0, *) {
            if let url = Bundle.module.url(forResource: .resourceName, withExtension: .ext) {
                session = try? SKTestSession(contentsOf: url)
            }
        }
    }
}

// MARK: - Constants

private extension String {
    static let resourceName = "Flare"
    static let ext = "storekit"
}
