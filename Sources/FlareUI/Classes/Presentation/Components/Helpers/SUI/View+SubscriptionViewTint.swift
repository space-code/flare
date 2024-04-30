//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the tint color of subscription views within a view.
public extension View {
    /// Sets the tint color for subscription views for the view.
    ///
    /// - Parameter color: The tint color to apply to subscription views.
    ///
    /// - Returns: A modified view with the specified tint color for subscription views.
    func subscriptionViewTint(_ color: Color) -> some View {
        environment(\.subscriptionViewTint, color)
    }
}
