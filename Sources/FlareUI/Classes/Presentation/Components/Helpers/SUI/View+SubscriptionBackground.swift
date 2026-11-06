//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the background color of subscription views within a view.
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(iOS 13.0, macOS 10.15, *)
public extension View {
    /// Sets the background color of subscription views for the view.
    ///
    /// - Parameter color: The background color to apply to subscription views.
    ///
    /// - Returns: A modified view with the specified background color for subscription views.
    func subscriptionBackground(_ color: Color) -> some View {
        environment(\.subscriptionBackground, color)
    }
}
