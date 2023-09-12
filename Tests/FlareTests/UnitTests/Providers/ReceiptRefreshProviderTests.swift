//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import TestConcurrency
import XCTest

// MARK: - ReceiptRefreshProviderTests

class ReceiptRefreshProviderTests: XCTestCase {
    // MARK: - Properties

    private var testDispatchQueue: TestDispatchQueue!
    private var dispatchQueueFactory: TestDispatchQueueFactory!
    private var receiptRefreshProvider: ReceiptRefreshProvider!
    private var appStoreReceiptProviderMock: AppStoreReceiptProviderMock!
    private var fileManagerMock: FileManagerMock!
    private var receiptRefreshRequestFactoryMock: ReceiptRefreshRequestFactoryMock!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        testDispatchQueue = TestDispatchQueue()
        appStoreReceiptProviderMock = AppStoreReceiptProviderMock()
        dispatchQueueFactory = TestDispatchQueueFactory(testQueue: testDispatchQueue)
        fileManagerMock = FileManagerMock()
        receiptRefreshRequestFactoryMock = ReceiptRefreshRequestFactoryMock()
        receiptRefreshProvider = ReceiptRefreshProvider(
            dispatchQueueFactory: dispatchQueueFactory,
            fileManager: fileManagerMock,
            appStoreReceiptProvider: appStoreReceiptProviderMock,
            receiptRefreshRequestFactory: receiptRefreshRequestFactoryMock
        )
    }

    override func tearDown() {
        testDispatchQueue = nil
        dispatchQueueFactory = nil
        receiptRefreshProvider = nil
        appStoreReceiptProviderMock = nil
        fileManagerMock = nil
        receiptRefreshRequestFactoryMock = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatReceiptRefreshProviderHandlesRequestError() {
        // given
        receiptRefreshRequestFactoryMock.stubbedMakeResult = ReceiptRefreshRequestMock()

        var result: Result<Void, IAPError>?
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let handler: ReceiptRefreshHandler = { result = $0 }
        let error = IAPError.paymentCancelled

        // when
        receiptRefreshProvider.refresh(requestId: .requestID, handler: handler)
        receiptRefreshProvider.request(request, didFailWithError: error)

        // then
        if case let .failure(resultError) = result {
            XCTAssertEqual(resultError.plainError as NSError, error.plainError as NSError)
        }
    }

    func test_thatReceiptRefreshProviderFinishesRequest() {
        // given
        receiptRefreshRequestFactoryMock.stubbedMakeResult = ReceiptRefreshRequestMock()

        var result: Result<Void, IAPError>?
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let handler: ReceiptRefreshHandler = { result = $0 }

        // when
        receiptRefreshProvider.refresh(requestId: .requestID, handler: handler)
        receiptRefreshProvider.requestDidFinish(request)

        // then
        if case .failure = result {
            XCTFail()
        }
    }

    func test_thatReceiptRefreshProviderLoadsAppStoreReceipt_whenReceiptExists() {
        // given
        appStoreReceiptProviderMock.stubbedAppStoreReceiptURL = .mockURL
        fileManagerMock.stubbedFileExistsResult = true

        // when
        let receipt = receiptRefreshProvider.receipt

        // then
        XCTAssertNotNil(receipt)
    }

    func test_thatReceiptRefreshProviderDoesNotLoadAppStoreReceipt_whenReceiptDoesNotExist() {
        // given
        appStoreReceiptProviderMock.stubbedAppStoreReceiptURL = nil
        fileManagerMock.stubbedFileExistsResult = false

        // when
        let receipt = receiptRefreshProvider.receipt

        // then
        XCTAssertNil(receipt)
    }

    func test_thatReceiptRefreshProviderRefreshesReceipt_whenRequestDidFailWithError() async {
        // given
        let request = ReceiptRefreshRequestMock()
        receiptRefreshRequestFactoryMock.stubbedMakeResult = request

        request.stubbedStartAction = {
            self.receiptRefreshProvider.request(
                self.makeSKRequest(id: request.id),
                didFailWithError: IAPError.paymentNotAllowed
            )
        }

        // when
        var iapError: IAPError?

        do {
            try await receiptRefreshProvider.refresh(requestId: .requestID)
        } catch {
            iapError = error as? IAPError
        }

        // then
        XCTAssertEqual(iapError, IAPError(error: IAPError.paymentNotAllowed))
    }

    func test_thatReceiptRefreshProviderRefreshesReceipt_whenRequestDid() async {
        // given
        let request = ReceiptRefreshRequestMock()
        request.stubbedId = .requestID

        receiptRefreshRequestFactoryMock.stubbedMakeResult = request

        request.stubbedStartAction = {
            self.receiptRefreshProvider.requestDidFinish(self.makeSKRequest(id: .requestID))
        }

        // when
        var iapError: IAPError?

        do {
            try await receiptRefreshProvider.refresh(requestId: .requestID)
        } catch {
            iapError = error as? IAPError
        }

        // then
        XCTAssertNil(iapError)
    }

    // MARK: Private

    private func makeSKRequest(id: String) -> SKRequest {
        let skRequest = SKRequest()
        skRequest.id = id
        return skRequest
    }
}

// MARK: - Constants

private extension URL {
    static let mockURL = URL(string: "https://google.com")
}

private extension String {
    static let requestID = "request_id"
}
