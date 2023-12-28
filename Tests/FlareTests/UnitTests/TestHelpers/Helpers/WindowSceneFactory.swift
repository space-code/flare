//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if os(iOS) || VISION_OS
    import ObjectsFactory
    import UIKit

    final class WindowSceneFactory {
        static func makeWindowScene() -> UIWindowScene {
            do {
                let session = try ObjectsFactory.create(UISceneSession.self)
                let scene = try ObjectsFactory.create(UIWindowScene.self, properties: ["session": session])
                return scene
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
#endif
