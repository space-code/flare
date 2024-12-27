//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation
import XCTest

// MARK: - IReceiptRefreshRequestFactoryTests

final class IReceiptRefreshRequestFactoryTests: XCTestCase {
    // MARK: Properties

    private var factory: ReceiptRefreshRequestFactory!

    // MARK: Initialization

    override func setUp() {
        super.setUp()
        factory = ReceiptRefreshRequestFactory()
    }

    override func tearDown() {
        factory = nil
        super.tearDown()
    }

    func test_thatFactoryMakesReceipt() {
        // when
        let receipt = factory.make(requestID: .requestID, delegate: nil)

        // then
        XCTAssertEqual(receipt.id, .requestID)
    }
}

// MARK: - Constants

private extension String {
    static let requestID = "request_id"
}
