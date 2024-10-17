//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
#if canImport(UIKit)
    import UIKit
#endif

// MARK: - SystemInfoProviderMock

final class SystemInfoProviderMock: ISystemInfoProvider {
    #if os(iOS) || VISION_OS
        var invokedCurrentSceneGetter = false
        var invokedCurrentSceneGetterCount = 0
        var stubbedCurrentScene: Result<UIWindowScene, Error>!

        var currentScene: UIWindowScene {
            get throws {
                invokedCurrentSceneGetter = true
                invokedCurrentSceneGetterCount += 1
                switch stubbedCurrentScene {
                case let .success(scene):
                    return scene
                case let .failure(error):
                    throw error
                default:
                    fatalError()
                }
            }
        }
    #endif
}
