//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif

// MARK: - IScenesHolder

/// A type that holds all connected scenes.
@MainActor
protocol IScenesHolder: Sendable {
    #if os(iOS) || VISION_OS
        /// The scenes that are connected to the app.
        var connectedScenes: Set<UIScene> { get }
    #endif
}
