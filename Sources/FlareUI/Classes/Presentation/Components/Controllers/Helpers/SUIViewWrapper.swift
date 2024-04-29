//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

#if os(iOS) || os(tvOS)
    public typealias ViewRepresentation = UIKit.UIView
#elseif os(macOS)
    public typealias ViewRepresentation = NSView
#elseif os(watchOS)
    public typealias ViewRepresentation = WKInterfaceObject
#endif

// MARK: - SUIViewWrapper

struct SUIViewWrapper<CustomView: ViewRepresentation>: ViewRepresentable {
    // MARK: Types

    #if os(iOS) || os(tvOS)
        typealias UIViewType = CustomView
    #elseif os(macOS)
        typealias NSViewType = CustomView
    #elseif os(watchOS)
        typealias WKInterfaceObjectType = CustomView
    #endif

    // MARK: Properties

    private let view: CustomView

    // MARK: Initialization

    init(view: CustomView) {
        self.view = view
    }

    // MARK: ViewRepresentable

    #if os(macOS)
        func makeNSView(context _: Context) -> CustomView {
            view
        }

        func updateNSView(_: NSViewType, context _: Context) {}
    #endif

    #if os(iOS) || os(tvOS)
        func makeUIView(context _: Context) -> CustomView {
            view
        }

        func updateUIView(_: UIViewType, context _: Context) {}
    #endif

    #if os(watchOS)
        func makeWKInterfaceObject(context _: Context) -> CustomView {
            view
        }

        func makeCoordinator() {}

        func updateWKInterfaceObject(_: CustomView, context _: Context) {}
    #endif
}
