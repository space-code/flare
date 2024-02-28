//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif

import SwiftUI

// MARK: - Palette

enum Palette {
    static var gray: Color {
        #if os(macOS)
            Color(NSColor.systemGray)
        #elseif os(watchOS)
            Color(UIColor.gray)
        #elseif os(tvOS)
            Color(UIColor.systemGray)
        #else
            Color(UIColor.systemGray6)
        #endif
    }

    static var systemGray: Color {
        #if os(macOS)
            Color(NSColor.systemGray)
        #elseif os(watchOS)
            Color(UIColor.gray)
        #else
            Color(UIColor.systemGray)
        #endif
    }
}
