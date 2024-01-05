//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if os(iOS) || VISION_OS
    import UIKit

    final class WindowSceneFactory {
        static func makeWindowScene() -> UIWindowScene {
            UIApplication.shared.connectedScenes.first as! UIWindowScene
        }
    }
#endif
