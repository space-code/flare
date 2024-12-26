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
    private var appStoreReceiptProviderMock: AppStoreReceiptProviderMock!
    private var fileManagerMock: FileManagerMock!
    private var receiptRefreshRequestFactoryMock: ReceiptRefreshRequestFactoryMock!

    private var sut: ReceiptRefreshProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        testDispatchQueue = TestDispatchQueue()
        appStoreReceiptProviderMock = AppStoreReceiptProviderMock()
        dispatchQueueFactory = TestDispatchQueueFactory(testQueue: testDispatchQueue)
        fileManagerMock = FileManagerMock()
        receiptRefreshRequestFactoryMock = ReceiptRefreshRequestFactoryMock()
        sut = ReceiptRefreshProvider(
            dispatchQueueFactory: dispatchQueueFactory,
            fileManager: fileManagerMock,
            appStoreReceiptProvider: appStoreReceiptProviderMock,
            receiptRefreshRequestFactory: receiptRefreshRequestFactoryMock
        )
    }

    override func tearDown() {
        testDispatchQueue = nil
        dispatchQueueFactory = nil
        sut = nil
        appStoreReceiptProviderMock = nil
        fileManagerMock = nil
        receiptRefreshRequestFactoryMock = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatReceiptRefreshProviderHandlesRequestError_whenErrorOccurred() async throws {
        // given
        let stubbedRequest = ReceiptRefreshRequestMock()
        stubbedRequest.stubbedId = .requestID
        receiptRefreshRequestFactoryMock.stubbedMakeResult = stubbedRequest

        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let error = IAPError.paymentCancelled

        // when
        let result: Result<Void, IAPError> = try await withCheckedThrowingContinuation { continuation in
            sut.refresh(requestID: .requestID) { result in
                continuation.resume(returning: result)
            }

            sut.request(request, didFailWithError: error)
        }

        // then
        if case let .failure(resultError) = result {
            XCTAssertEqual(resultError.plainError as NSError, error.plainError as NSError)
        }
    }

    func test_thatReceiptRefreshProviderFinishesRequest_whenRequestCompletedSuccessfully() async throws {
        // given
        let stubbedRequest = ReceiptRefreshRequestMock()
        stubbedRequest.stubbedId = .requestID
        receiptRefreshRequestFactoryMock.stubbedMakeResult = stubbedRequest

        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)

        // when
        let result: Result<Void, IAPError>? = try await withCheckedThrowingContinuation { continuation in
            sut.refresh(requestID: .requestID) { result in
                continuation.resume(returning: result)
            }

            sut.requestDidFinish(request)
        }

        // then
        if case .failure = result { XCTFail("The result must be `success`") }
        XCTAssertEqual(stubbedRequest.invokedIdGetterCount, 1)
    }

    func test_thatReceiptRefreshProviderLoadsAppStoreReceipt_whenReceiptExists() {
        // given
        appStoreReceiptProviderMock.stubbedAppStoreReceiptURL = .mockURL
        fileManagerMock.stubbedFileExistsResult = true

        // when
        let receipt = sut.receipt

        // then
        XCTAssertNotNil(receipt)
    }

    func test_thatReceiptRefreshProviderDoesNotLoadAppStoreReceipt_whenReceiptDoesNotExist() {
        // given
        appStoreReceiptProviderMock.stubbedAppStoreReceiptURL = nil
        fileManagerMock.stubbedFileExistsResult = false

        // when
        let receipt = sut.receipt

        // then
        XCTAssertNil(receipt)
    }

    func test_thatReceiptRefreshProviderRefreshesReceipt_whenRequestDidFailWithError() async {
        // given
        let request = ReceiptRefreshRequestMock()
        receiptRefreshRequestFactoryMock.stubbedMakeResult = request

        request.stubbedStartAction = {
            self.sut.request(
                self.makeSKRequest(id: request.id),
                didFailWithError: IAPError.paymentNotAllowed
            )
        }

        // when
        let iapError: IAPError? = await error(for: { try await sut.refresh(requestID: .requestID) })

        // then
        XCTAssertEqual(iapError, IAPError(error: IAPError.paymentNotAllowed))
    }

    func test_thatReceiptRefreshProviderRefreshesReceipt_whenRequestCompletedSuccessfully() async {
        // given
        let request = ReceiptRefreshRequestMock()
        request.stubbedId = .requestID

        receiptRefreshRequestFactoryMock.stubbedMakeResult = request

        request.stubbedStartAction = {
            self.sut.requestDidFinish(self.makeSKRequest(id: .requestID))
        }

        // when
        let iapError: IAPError? = await error(for: { try await sut.refresh(requestID: .requestID) })

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
