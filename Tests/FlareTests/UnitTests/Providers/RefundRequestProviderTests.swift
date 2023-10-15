//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import XCTest

#if os(iOS) || VISION_OS

    @available(iOS 15.0, *)
    final class RefundRequestProviderTests: XCTestCase {
        // MARK: Proeprties

        private var sut: RefundRequestProvider!

        // MARK: XCTestCase

        override func setUp() {
            super.setUp()
            sut = RefundRequestProvider()
        }

        override func tearDown() {
            sut = nil
            super.tearDown()
        }

        // MARK: Tests

        @MainActor
        func test_thatRefundRequestProviderThrowsAnUnknownError_whenRequestDidFailed() async throws {
            // given
            let windowScene = WindowSceneFactory.makeWindowScene()

            // when
            let status = try await sut.beginRefundRequest(
                transactionID: .transactionID,
                windowScene: windowScene
            )

            // then
            if case let .failure(error) = status {
                XCTAssertEqual(error as NSError, IAPError.refund(error: .failed) as NSError)
            } else {
                XCTFail("state must be `failure`")
            }
        }
    }

    // MARK: - Constants

    private extension UInt64 {
        static let transactionID: UInt64 = 0
    }

    private extension String {
        static let productID: String = "product_id"
    }

#endif
