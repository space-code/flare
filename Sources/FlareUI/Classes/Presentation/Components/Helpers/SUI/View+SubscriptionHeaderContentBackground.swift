//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the background color of subscription header content within a view.
public extension View {
    /// Sets the background color of subscription header content for the view.
    ///
    /// - Parameter color: The background color to apply to subscription header content.
    ///
    /// - Returns: A modified view with the specified background color for subscription header content.
    @available(iOS 13.0, *)
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    func subscriptionHeaderContentBackground(_ color: Color) -> some View {
        environment(\.subscriptionHeaderContentBackground, color)
    }
}
