//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

#if os(iOS) || VISION_OS
    @testable import Flare
    import XCTest

    @available(iOS 15.0, *)
    class RefundProviderTests: XCTestCase {
        // MARK: - Properties

        private var systemInfoProviderMock: SystemInfoProviderMock!
        private var refundRequestProviderMock: RefundRequestProviderMock!

        private var sut: RefundProvider!

        // MARK: - XCTestCase

        override func setUp() {
            super.setUp()
            refundRequestProviderMock = RefundRequestProviderMock()
            systemInfoProviderMock = SystemInfoProviderMock()
            sut = RefundProvider(systemInfoProvider: systemInfoProviderMock, refundRequestProvider: refundRequestProviderMock)
        }

        override func tearDown() {
            refundRequestProviderMock = nil
            systemInfoProviderMock = nil
            sut = nil
            super.tearDown()
        }

        // MARK: - Tests

        func testThatRefundProviderThrowsAnError_whenVerificationDidFail() async throws {
            // given
            refundRequestProviderMock.stubbedVerifyTransaction = nil
            systemInfoProviderMock.stubbedCurrentScene = .failure(IAPError.unknown)

            // when
            let error: Error? = await error(for: { try await sut.beginRefundRequest(productID: .productID) })

            // then
            XCTAssertEqual(error as? NSError, IAPError.unknown as NSError)
        }

//        func testThatRefundProviderThrowsAnErrorWhenRefundRequestDidFail() async throws {
//            // given
//            refundRequestProviderMock.stubbedVerifyTransaction = .transactionID
//            refundRequestProviderMock.stubbedBeginRefundRequest = .failure(IAPError.unknown)
//            systemInfoProviderMock.stubbedCurrentScene = .success(WindowSceneFactory.makeWindowScene())
//
//            // when
//            let status: RefundRequestStatus? = try await sut.beginRefundRequest(productID: .productID)
//
//            // then
//            if case .failed = status {}
//            else { XCTFail("The status must be `failed`") }
//            XCTAssertEqual(refundRequestProviderMock.invokedBeginRefundRequestCount, 1)
//        }
//
//        func testThatRefundProviderReturnsSuccessStatusWhenRefundRequestCompleted() async throws {
//            // given
//            refundRequestProviderMock.stubbedVerifyTransaction = .transactionID
//            refundRequestProviderMock.stubbedBeginRefundRequest = .success(.success)
//            systemInfoProviderMock.stubbedCurrentScene = .success(WindowSceneFactory.makeWindowScene())
//
//            // when
//            let status: RefundRequestStatus? = try await sut.beginRefundRequest(productID: .productID)
//
//            // then
//            if case .success = status {}
//            else { XCTFail("The status must be `success`") }
//            XCTAssertEqual(refundRequestProviderMock.invokedBeginRefundRequestCount, 1)
//        }
//
//        func testThatRefundProviderReturnsUserCancelledStatusWhenUserCancelledRequest() async throws {
//            // given
//            refundRequestProviderMock.stubbedVerifyTransaction = .transactionID
//            refundRequestProviderMock.stubbedBeginRefundRequest = .success(.userCancelled)
//            systemInfoProviderMock.stubbedCurrentScene = .success(WindowSceneFactory.makeWindowScene())
//
//            // when
//            let status: RefundRequestStatus? = try await sut.beginRefundRequest(productID: .productID)
//
//            // then
//            if case .userCancelled = status {}
//            else { XCTFail("The status must be `userCancelled`") }
//            XCTAssertEqual(refundRequestProviderMock.invokedBeginRefundRequestCount, 1)
//        }
    }

    // MARK: - Constants

//
//    private extension UInt64 {
//        static let transactionID: UInt64 = 5
//    }
//
    private extension String {
        static let productID: String = "product_id"
    }

#endif
