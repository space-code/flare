//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the background color of subscription header content within a view.
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(macOS, unavailable)
@available(iOS 13.0, *)
public extension View {
    /// Sets the background color of subscription header content for the view.
    ///
    /// - Parameter color: The background color to apply to subscription header content.
    ///
    /// - Returns: A modified view with the specified background color for subscription header content.
    func subscriptionHeaderContentBackground(_ color: Color) -> some View {
        environment(\.subscriptionHeaderContentBackground, color)
    }
}
