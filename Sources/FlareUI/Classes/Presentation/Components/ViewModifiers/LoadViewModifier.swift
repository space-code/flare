//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - LoadViewModifier

/// A view modifier that triggers a handler once when view is loaded.
struct LoadViewModifier: ViewModifier {
    // MARK: Private

    /// A Bool value that indicates the view is loaded.
    @State private var isLoaded = false

    /// A handler closure.
    private let handler: () -> Void

    // MARK: Initialization

    /// Creates a ``LoadViewModifier`` instance.
    ///
    /// - Parameter handler: A handler closure to be performed when view is loaded.
    init(handler: @escaping () -> Void) {
        self.handler = handler
    }

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        content.onAppear {
            if !isLoaded {
                handler()
                isLoaded.toggle()
            }
        }
    }
}

// MARK: - Extensions

extension View {
    func onLoad(_ handler: @escaping () -> Void) -> some View {
        modifier(LoadViewModifier(handler: handler))
    }
}
