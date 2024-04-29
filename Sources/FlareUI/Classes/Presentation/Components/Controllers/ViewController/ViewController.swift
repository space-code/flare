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
    public typealias ViewController = UIViewController
#elseif os(macOS)
    public typealias ViewController = NSViewController
#elseif os(watchOS)
    public typealias ViewController = WKInterfaceController
#endif
