//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

// swiftlint:disable file_types_order

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

#if os(iOS) || os(tvOS)
    public typealias ColorRepresentation = UIKit.UIColor
#elseif os(macOS)
    public typealias ColorRepresentation = NSColor
#endif
// swiftlint:enable file_types_order
