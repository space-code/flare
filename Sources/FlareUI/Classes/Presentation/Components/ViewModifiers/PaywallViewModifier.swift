//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A view modifier provides a paywall functionality.
@available(watchOS, unavailable)
struct PaywallViewModifier: ViewModifier {
    // MARK: Properties

    /// The paywall type.
    private let paywallType: PaywallType
    /// The binding to control the presentation state of the paywall.
    private let presented: Binding<Bool>

    // MARK: Initialization

    /// Creates a `PaywallViewModifier` instance.
    ///
    /// - Parameters:
    ///   - paywallType: The paywall type.
    ///   - presented: The binding to control the presentation state of the paywall.
    init(
        paywallType: PaywallType,
        presented: Binding<Bool>
    ) {
        self.paywallType = paywallType
        self.presented = presented
    }

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: presented) {
                ZStack {
                    Palette.systemBackground.edgesIgnoringSafeArea(.all)
                    PaywallView(paywallType: paywallType)
                }
            }
    }
}
