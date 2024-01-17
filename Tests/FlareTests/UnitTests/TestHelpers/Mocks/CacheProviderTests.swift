//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import XCTest

// MARK: - CacheProviderTests

final class CacheProviderTests: XCTestCase {
    // MARK: Properties

    private var userDefaultsMock: UserDefaultsMock!

    private var sut: CacheProvider!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        userDefaultsMock = UserDefaultsMock()
        sut = CacheProvider(userDefaults: userDefaultsMock)
    }

    override func tearDown() {
        userDefaultsMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_write() {
        // when
        sut.write(key: .key, value: String.value)

        // then
        XCTAssertEqual(userDefaultsMock.invokedSetParameters?.key, .key)
        XCTAssertEqual(userDefaultsMock.invokedSetParameters?.codable as? String, String.value)
    }

    func test_read() {
        // given
        userDefaultsMock.stubbedGetResult = String.value

        // when
        let value: String? = sut.read(key: .key)

        // then
        XCTAssertEqual(userDefaultsMock.invokedGetParameters?.key, .key)
        XCTAssertEqual(value, String.value)
    }
}

// MARK: - Constants

private extension String {
    static let key = "key"
    static let value = "value"
}
