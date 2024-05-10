//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the background color of subscription picker items within a view.
public extension View {
    /// Sets the background color of subscription picker items for the view.
    ///
    /// - Parameter backgroundStyle: The background color to apply to subscription picker items.
    ///
    /// - Returns: A modified view with the specified background color for subscription picker items.
    @available(iOS 13.0, macOS 10.15, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    func subscriptionPickerItemBackground(_ backgroundStyle: Color) -> some View {
        environment(\.subscriptionPickerItemBackground, backgroundStyle)
    }
}
