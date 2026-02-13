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

        #if swift(>=6.0)
            override func setUp() {
                super.setUp()
                scenesHolderMock = ScenesHolderMock()
                sut = SystemInfoProvider(scenesHolder: scenesHolderMock)
            }
        #else
            @MainActor
            override func setUp() {
                super.setUp()
                scenesHolderMock = ScenesHolderMock()
                sut = SystemInfoProvider(scenesHolder: scenesHolderMock)
            }
        #endif

        override func tearDown() {
            scenesHolderMock = nil
            sut = nil
            super.tearDown()
        }

        // MARK: Tests

//        @MainActor
//        func test_thatScenesHolderReturnsCurrentScene() async throws {
//            // given
//            let windowScene = WindowSceneFactory.makeWindowScene()
//            scenesHolderMock.stubbedConnectedScenes = Set(arrayLiteral: windowScene)
//
//            // when
//            let scene = try await sut.currentScene
//
//            // then
//            XCTAssertEqual(windowScene, scene)
//        }

        func test_thatScenesHolderThrowsAnErrorWhenThereIsNoActiveWindowScene() async {
            // when
            let error: Error? = await self.error(for: { try await sut.currentScene })

            // then
            XCTAssertEqual(error as? NSError, IAPError.unknown as NSError)
        }
    }
#endif
