//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import TestConcurrency
import XCTest

private extension String {
    static let requestId = "request_identifier"
}

// MARK: - ReceiptRefreshProviderTests

class ReceiptRefreshProviderTests: XCTestCase {
    // MARK: - Properties

    private var testDispatchQueue: TestDispatchQueue!
    private var dispatchQueueFactory: TestDispatchQueueFactory!
    private var receiptRefreshProvider: ReceiptRefreshProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        testDispatchQueue = TestDispatchQueue()
        dispatchQueueFactory = TestDispatchQueueFactory(testQueue: testDispatchQueue)
        receiptRefreshProvider = ReceiptRefreshProvider(dispatchQueueFactory: dispatchQueueFactory)
    }

    override func tearDown() {
        testDispatchQueue = nil
        dispatchQueueFactory = nil
        receiptRefreshProvider = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testThatReceiptRefreshProviderHandleRequestError() {
        // given
        var result: Result<Void, IAPError>?
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestId)
        let handler: ReceiptRefreshHandler = { result = $0 }
        let error = IAPError.paymentCancelled

        // when
        receiptRefreshProvider.refresh(requestId: .requestId, handler: handler)
        receiptRefreshProvider.request(request, didFailWithError: error)

        // then
        if case let .failure(resultError) = result {
            XCTAssertEqual(resultError.plainError as NSError, error.plainError as NSError)
        }
    }

    func testThatReceiptRefreshProviderFinishRequest() {
        // given
        var result: Result<Void, IAPError>?
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestId)
        let handler: ReceiptRefreshHandler = { result = $0 }

        // when
        receiptRefreshProvider.refresh(requestId: .requestId, handler: handler)
        receiptRefreshProvider.requestDidFinish(request)

        // then
        if case .failure = result {
            XCTFail()
        }
    }
}
