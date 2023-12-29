//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Concurrency
@testable import Flare
import TestConcurrency
import XCTest

// MARK: - ProductProviderStoreKit2Tests

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
final class ProductProviderStoreKit2Tests: StoreSessionTestCase {
    // MARK: - Properties

    private var testDispatchQueue: TestDispatchQueue!
    private var dispatchQueueFactory: IDispatchQueueFactory!

    private var sut: ProductProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        testDispatchQueue = TestDispatchQueue()
        dispatchQueueFactory = TestDispatchQueueFactory(testQueue: testDispatchQueue)
        sut = ProductProvider(dispatchQueueFactory: dispatchQueueFactory)
    }

    override func tearDown() {
        testDispatchQueue = nil
        dispatchQueueFactory = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatProductProviderFetchesProductsWithIDs() async throws {
        // when
        let products = try await sut.fetch(productIDs: [.productID])

        // then
        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products.first?.productIdentifier, .productID)
    }
}

// MARK: - Constants

private extension String {
    static let productID = "com.flare.test_purchase_1"
}
