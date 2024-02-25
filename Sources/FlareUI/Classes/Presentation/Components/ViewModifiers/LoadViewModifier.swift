//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - LoadViewModifier

struct LoadViewModifier: ViewModifier {
    // MARK: Private

    @State private var isLoaded = false

    private let handler: () -> Void

    // MARK: Initialization

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

extension View {
    func onLoad(_ handler: @escaping () -> Void) -> some View {
        modifier(LoadViewModifier(handler: handler))
    }
}
