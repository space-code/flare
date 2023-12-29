//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if os(iOS) || VISION_OS
    @testable import Flare
    import XCTest

    final class SystemInfoProviderTests: XCTestCase {
        // MARK: Properties

        private var scenesHolderMock: ScenesHolderMock!

        private var sut: SystemInfoProvider!

        // MARK: Initialization

        override func setUp() {
            super.setUp()
            scenesHolderMock = ScenesHolderMock()
            sut = SystemInfoProvider(scenesHolder: scenesHolderMock)
        }

        override func tearDown() {
            scenesHolderMock = nil
            sut = nil
            super.tearDown()
        }

        // MARK: Tests

        @MainActor
        func test_thatScenesHolderReturnsCurrentScene() throws {
            // given
            let windowScene = WindowSceneFactory.makeWindowScene()
            scenesHolderMock.stubbedConnectedScenes = Set(arrayLiteral: windowScene)

            // when
            let scene = try sut.currentScene

            // then
            XCTAssertEqual(windowScene, scene)
        }

        @MainActor
        func test_thatScenesHolderThrowsAnErrorWhenThereIsNoActiveWindowScene() async throws {
            // when
            let error: Error? = await self.error(for: { try sut.currentScene })

            // then
            XCTAssertEqual(error as? NSError, IAPError.unknown as NSError)
        }
    }
#endif
