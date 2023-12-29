//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import SwiftUI

#if os(macOS)

    import Cocoa

    @main
    class AppDelegate: NSObject, NSApplicationDelegate {}

#else
    @main
    class AppDelegate: UIResponder, UIApplicationDelegate {}

#endif
