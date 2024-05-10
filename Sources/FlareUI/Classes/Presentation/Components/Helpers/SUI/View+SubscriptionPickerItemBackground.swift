//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// Extension for configuring the label style of subscription store buttons within a view.
public extension View {
    /// Sets the label style for subscription store buttons for the view.
    ///
    /// - Parameter style: The label style to apply to subscription store buttons.
    ///
    /// - Returns: A modified view with the specified label style for subscription store buttons.
    @available(iOS 13.0, macOS 10.15, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @available(visionOS, unavailable)
    func subscriptionButtonLabel(_ style: SubscriptionStoreButtonLabel) -> some View {
        environment(\.subscriptionStoreButtonLabel, style)
    }
}
