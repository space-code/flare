//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif

// MARK: - IScenesHolder

/// A type that holds all connected scenes.
protocol IScenesHolder {
    #if os(iOS) || VISION_OS
        /// The scenes that are connected to the app.
        var connectedScenes: Set<UIScene> { get }
    #endif
}

#if os(iOS) || VISION_OS
    extension UIApplication: IScenesHolder {}
#endif
