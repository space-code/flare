//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the background color of subscription picker items within a view.
@available(visionOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(iOS 13.0, macOS 10.15, *)
public extension View {
    /// Sets the background color of subscription picker items for the view.
    ///
    /// - Parameter backgroundStyle: The background color to apply to subscription picker items.
    ///
    /// - Returns: A modified view with the specified background color for subscription picker items.
    func subscriptionPickerItemBackground(_ backgroundStyle: Color) -> some View {
        environment(\.subscriptionPickerItemBackground, backgroundStyle)
    }
}
