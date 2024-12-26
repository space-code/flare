//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

#if os(iOS) || VISION_OS
    import UIKit

    enum WindowSceneFactory {
        @MainActor
        static func makeWindowScene() -> UIWindowScene {
            UIApplication.shared.connectedScenes.first as! UIWindowScene
        }
    }
#endif
