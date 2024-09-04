//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

#if os(macOS)

    import Cocoa

    @main
    class AppDelegate: NSObject, NSApplicationDelegate {}

#elseif os(watchOS)

    @main
    struct TestApp: App {
        var body: some Scene {
            WindowGroup {
                Text("Hello World")
            }
        }
    }

#else
    @main
    class AppDelegate: UIResponder, UIApplicationDelegate {}

#endif
