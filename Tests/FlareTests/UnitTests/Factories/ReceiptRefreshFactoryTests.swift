//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
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
        let receipt = factory.make(id: .productID, delegate: nil)

        // then
        XCTAssertEqual(receipt.id, .productID)
    }
}

// MARK: - Constants

private extension String {
    static let productID = "product_id"
}
