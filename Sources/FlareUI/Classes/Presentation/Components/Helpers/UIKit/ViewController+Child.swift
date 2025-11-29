//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(Cocoa)
    import Cocoa
#endif

#if os(iOS) || os(macOS)
    extension ViewController {
        func add(_ controller: ViewController) {
            addChild(controller)
            view.addSubview(controller.view)

            #if os(iOS) || os(tvOS)
                controller.didMove(toParent: self)
            #endif

            controller.view.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                controller.view.topAnchor.constraint(equalTo: self.safeTopAnchor),
                controller.view.leadingAnchor.constraint(equalTo: self.safeLeadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: self.safeTrailingAnchor),
                controller.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
        }

        // MARK: Private

        private var safeTopAnchor: NSLayoutYAxisAnchor {
            if #available(iOS 11.0, macOS 11.0, *) {
                view.safeAreaLayoutGuide.topAnchor
            } else {
                view.bottomAnchor
            }
        }

        private var safeBottomAnchor: NSLayoutYAxisAnchor {
            if #available(iOS 11.0, macOS 11.0, *) {
                view.safeAreaLayoutGuide.bottomAnchor
            } else {
                view.topAnchor
            }
        }

        private var safeLeadingAnchor: NSLayoutXAxisAnchor {
            if #available(iOS 11.0, macOS 11.0, *) {
                view.safeAreaLayoutGuide.leadingAnchor
            } else {
                view.leadingAnchor
            }
        }

        private var safeTrailingAnchor: NSLayoutXAxisAnchor {
            if #available(iOS 11.0, macOS 11.0, *) {
                view.safeAreaLayoutGuide.trailingAnchor
            } else {
                view.trailingAnchor
            }
        }
    }
#endif
