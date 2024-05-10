//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the style of subscription controls within a view.
public extension View {
    /// Sets the style of subscription controls for the view.
    ///
    /// - Parameter style: The style to apply to subscription controls.
    ///
    /// - Returns: A modified view with the specified style for subscription controls.
    @available(watchOS, unavailable)
    func subscriptionControlStyle(_ style: some ISubscriptionControlStyle) -> some View {
        environment(\.subscriptionControlStyle, prepareStyle(style))
    }

    // MARK: Private

    /// Prepares the style for subscription controls.
    ///
    /// - Parameter style: The style to prepare.
    ///
    /// - Returns: The prepared style as an `AnySubscriptionControlStyle`.
    private func prepareStyle(_ style: some ISubscriptionControlStyle) -> AnySubscriptionControlStyle {
        if let style = style as? AnySubscriptionControlStyle {
            return style
        } else {
            return AnySubscriptionControlStyle(style: style)
        }
    }
}
