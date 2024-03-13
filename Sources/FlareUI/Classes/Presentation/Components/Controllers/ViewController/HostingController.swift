//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(Cocoa)
    import Cocoa
#endif

import SwiftUI

#if os(iOS) || os(tvOS)
    typealias HostingController = UIHostingController
#elseif os(macOS)
    typealias HostingController = NSHostingController
#endif
