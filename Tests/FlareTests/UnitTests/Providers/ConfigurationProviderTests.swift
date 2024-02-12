//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import XCTest

// MARK: - ConfigurationProviderTests

final class ConfigurationProviderTests: XCTestCase {
    // MARK: Properties

    private var cacheProviderMock: CacheProviderMock!

    private var sut: ConfigurationProvider!

    // MARK: Initialization

    override func setUp() {
        super.setUp()
        cacheProviderMock = CacheProviderMock()
        sut = ConfigurationProvider(
            cacheProvider: cacheProviderMock
        )
    }

    override func tearDown() {
        cacheProviderMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatCacheProviderReturnsApplicationUsername_whenUsernameExists() {
        // given
        cacheProviderMock.stubbedReadResult = String.applicationUsername

        // when
        let applicationUsername = sut.applicationUsername

        // then
        XCTAssertEqual(cacheProviderMock.invokedReadParameters?.key, .applicationUsernameKey)
        XCTAssertEqual(applicationUsername, .applicationUsername)
    }

    func test_thatCacheProviderConfigures() {
        // given
        let configurationFake = Configuration.fake()

        // when
        sut.configure(with: configurationFake)

        // then
        XCTAssertEqual(cacheProviderMock.invokedWriteParameters?.key, .applicationUsernameKey)
        XCTAssertEqual(cacheProviderMock.invokedWriteParameters?.value as? String, configurationFake.applicationUsername)
    }
}

// MARK: - Constants

private extension String {
    static let applicationUsername = "application_username"

    static let applicationUsernameKey = "flare.configuration.application_username"
}
