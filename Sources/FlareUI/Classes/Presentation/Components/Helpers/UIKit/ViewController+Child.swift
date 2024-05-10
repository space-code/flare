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
                controller.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                controller.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                controller.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
        }
    }
#endif
