//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI
#if canImport(UIKit)
    import UIKit
#elseif canImport(Cocoa)
    import Cocoa
#endif

#if os(iOS) || os(tvOS)
    typealias ViewRepresentable = UIViewRepresentable
#elseif os(macOS)
    typealias ViewRepresentable = NSViewRepresentable
#elseif os(watchOS)
    typealias ViewRepresentable = WKInterfaceObjectRepresentable
#endif

// MARK: - ActivityIndicatorView

#if os(iOS) || os(tvOS) || os(macOS)
    struct ActivityIndicatorView: ViewRepresentable {
        // MARK: Properties

        @Binding var isAnimating: Bool

        #if os(iOS) || os(tvOS)
            let style: UIActivityIndicatorView.Style
        #endif

        // MARK: UIViewRepresentable

        #if os(macOS)
            func makeNSView(context _: Context) -> NSProgressIndicator {
                let progressIndicator = NSProgressIndicator()
                progressIndicator.style = .spinning
                progressIndicator.usesThreadedAnimation = true
                return progressIndicator
            }

            func updateNSView(_ nsView: NSViewType, context _: Context) {
                if isAnimating {
                    nsView.startAnimation(nil)
                } else {
                    nsView.stopAnimation(nil)
                }
            }
        #endif

        #if os(iOS) || os(tvOS)
            func makeUIView(context _: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
                UIActivityIndicatorView(style: style)
            }

            func updateUIView(
                _ uiView: UIActivityIndicatorView,
                context _: UIViewRepresentableContext<ActivityIndicatorView>
            ) {
                if isAnimating {
                    uiView.startAnimating()
                } else {
                    uiView.stopAnimating()
                }
            }
        #endif
    }
#endif
