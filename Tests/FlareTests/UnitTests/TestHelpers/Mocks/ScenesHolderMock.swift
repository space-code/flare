//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
#if canImport(UIKit)
    import UIKit
#endif

// MARK: - ScenesHolderMock

final class ScenesHolderMock: IScenesHolder, @unchecked Sendable {
    #if os(iOS) || VISION_OS
        var invokedConnectedScenesGetter = false
        var invokedConnectedScenesGetterCount = 0
        var stubbedConnectedScenes: Set<UIScene>! = []

        var connectedScenes: Set<UIScene> {
            invokedConnectedScenesGetter = true
            invokedConnectedScenesGetterCount += 1
            return stubbedConnectedScenes
        }
    #endif
}
