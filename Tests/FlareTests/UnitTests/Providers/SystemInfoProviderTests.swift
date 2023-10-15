//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if os(iOS) || VISION_OS
    @testable import Flare
    import XCTest

    final class SystemInfoProviderTests: XCTestCase {
        // MARK: Properties

        private var sut: SystemInfoProvider!
        private var scenesHolderMock: ScenesHolderMock!

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
        func test_thatScenesHolderThrowsAnErrorWhenThereIsNoActiveWindowScene() {
            // when
            var receivedError: Error?
            do {
                _ = try sut.currentScene
            } catch {
                receivedError = error
            }

            // then
            XCTAssertEqual(receivedError as? NSError, IAPError.unknown as NSError)
        }
    }
#endif
