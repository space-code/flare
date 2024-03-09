//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import FlareUIMock
import XCTest

final class StoreButtonPresenterTests: XCTestCase {
    // MARK: Properties

    private var iapMock: FlareMock!

    private var sut: StoreButtonPresenter!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        iapMock = FlareMock()
        sut = StoreButtonPresenter(iap: iapMock)
    }

    override func tearDown() {
        iapMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func test_thatPresenterRestoresTransactions() async throws {
        // when
        try await sut.restore()

        // then
        XCTAssertEqual(iapMock.invokedRestoreCount, 1)
    }
}
