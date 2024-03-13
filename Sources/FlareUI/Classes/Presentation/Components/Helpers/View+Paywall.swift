//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A SwiftUI extension to add a paywall to a view.
public extension View {
    /// Adds a paywall to the view.
    ///
    /// - Parameters:
    ///   - presented: A binding to control the presentation state of the paywall.
    ///   - paywallType: The type of paywall to display.
    ///
    /// - Returns: A modified view with the paywall added.
    func paywall(presented: Binding<Bool>, paywallType: PaywallType) -> some View {
        modifier(
            PaywallViewModifier(
                paywallType: paywallType,
                presented: presented
            )
        )
    }
}
