//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import SwiftUI

#if os(watchOS) || os(tvOS)

    @main
    struct TestApp: App {
        var body: some Scene {
            WindowGroup {
                Text("Hello World")
            }
        }
    }

#else

    // Scene isn't available until iOS 14.0, so this is for backwards compatibility.

    @main
    class AppDelegate: UIResponder, UIApplicationDelegate {}

#endif
