//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif

// MARK: - ISystemInfoProvider

/// A type that provides the system info.
protocol ISystemInfoProvider {
    #if os(iOS) || VISION_OS
        /// The current window scene.
        var currentScene: UIWindowScene { get throws }
    #endif
}
